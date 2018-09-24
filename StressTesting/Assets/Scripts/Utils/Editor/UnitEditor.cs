using System.Collections.Generic;
using UnityEngine;
using UnityEditor;
using Unity.Entities;
using System.Reflection;
using System;
using Unity.Collections;
using Unity.Mathematics;
using UnityEngine.Experimental.AI;
using Unity.Jobs;

public class UnitEditor :  EditorWindow
{

	[MenuItem("Tools/Unit Editor")]
	public static void OpenWindow()
	{
		UnitEditor window = (UnitEditor)EditorWindow.GetWindow(typeof(UnitEditor));
		window.Show();
	}

	[MenuItem("Tools/Spawn Units")]
	public static void SpawnUnits()
	{
		if (EditorHelperSystem.I == null) return;


		EditorHelperSystem.I.spawnerSystem.InitialSpawning();
	}
	
	public static IEnumerable<FieldInfo> GetAllFields(Type t)
	{
		return t.GetFields ();
	}

	public static Dictionary<string, string> GetAllFields(Type t, object o)
	{
		Dictionary<string, string> dic = new Dictionary<string, string>();
		if (o == null)
			return dic;
		dic.Add (t.Name, " ");
		//dic.Add ("Type", t.ToString());

		foreach(FieldInfo info in GetAllFields(t))
		{
			string name = t.ToString() + "." + info.Name;
			if (info.FieldType == typeof(NavMeshLocation))
			{
				var value = (NavMeshLocation)info.GetValue(o);
				dic.Add(name, (value.polygon.IsNull() ? "invalid" : "valid") + " " + value.position);
			}
			else dic.Add(name, info.GetValue(o).ToString());
		}
		return dic;
	}

	public void OnEnable()
	{
		SceneView.onSceneGUIDelegate -= OnSceneGUI;
		SceneView.onSceneGUIDelegate += OnSceneGUI;

		EditorApplication.update -= Repaint;
		EditorApplication.update += Repaint;
	}

	public void OnDisable()
	{
		SceneView.onSceneGUIDelegate -= OnSceneGUI;
		EditorApplication.update -= Repaint;
	}

	public Vector2 scrollview = Vector2.zero;

	public bool DrawFormations = true;
	public bool DrawFormationsNavigation = false;

	public bool DrawUnitPathFinding = false;

	public bool SelectFormations = false;
	public bool SelectUnits = false;

	public int formationId;
	public int unitId;

	public void OnGUI()
	{
		GUILayout.BeginVertical("Box");
		DrawFormations = EditorGUILayout.ToggleLeft("Draw formations", DrawFormations);
		DrawFormationsNavigation = EditorGUILayout.ToggleLeft("Draw formations navigation", DrawFormationsNavigation);
		GUILayout.EndVertical();

		GUILayout.BeginVertical("Box");
		DrawUnitPathFinding = EditorGUILayout.ToggleLeft("Draw lost unit path finding", DrawUnitPathFinding);
		GUILayout.EndVertical();

		GUILayout.BeginVertical("Box");
		SelectFormations = EditorGUILayout.ToggleLeft("Select formations", SelectFormations);
		if (SelectFormations) formationId = EditorGUILayout.IntField("Selected Formation", formationId);
		GUILayout.EndVertical();

		GUILayout.BeginVertical("Box");
		SelectUnits = EditorGUILayout.ToggleLeft("Select Units", SelectUnits);
		if (SelectUnits) unitId = EditorGUILayout.IntField("Selected Unit", unitId);
		GUILayout.EndVertical();
		
		if (!Application.isPlaying || EditorHelperSystem.I.formations.Length == 0)
		{
			return;
		}

		GUILayout.BeginVertical("Box");

		try
		{
			GUILayout.Label("Minion system minions: " + EditorHelperSystem.I.minions.Length);
			GUILayout.Label("Attack queue: " + CommandSystem.AttackCommands.Count);
		}
		catch (Exception) { }

		GUILayout.EndVertical();

		if (EditorHelperSystem.I.integritySystem != null) EditorHelperSystem.I.CompleteDependency();

		formationId = Mathf.Clamp(formationId, 0, EditorHelperSystem.I.formations.Length - 1);
		unitId = Mathf.Clamp(unitId, 0, EditorHelperSystem.I.minions.Length - 1);

		scrollview = EditorGUILayout.BeginScrollView (scrollview);
		
		if (SelectFormations)
		{
			WriteSelectedFormation();
		}
		if (SelectUnits)
		{
			WriteSelectedUnit();
		}

		CommonDrawings();
		EditorGUILayout.EndScrollView();

	}

	public static void DrawFormation(FormationData formation)
	{
		if (EditorApplication.isPaused) return;

		float3 pos1, pos2, pos3, pos4;

		if (formation.Width == 0)
		{
			pos1 = formation.Position + new float3(1, 0, 1);
			pos2 = formation.Position + new float3(-1, 0, 1);
			pos3 = formation.Position + new float3(1, 0, -1);
			pos4 = formation.Position + new float3(-1, 0, -1);
		}
		else
		{
			pos1 = formation.Position + formation.GetOffsetFromCenter(0);
			pos2 = formation.Position + formation.GetOffsetFromCenter(formation.Width - 1);
			pos3 = formation.Position + formation.GetOffsetFromCenter(formation.UnitCount - formation.Width);
			pos4 = formation.Position + formation.GetOffsetFromCenter(formation.UnitCount - 1);
		}

		Color c = formation.IsFriendly ? Color.blue : Color.red;

		// Draw the position of the formation
		Debug.DrawLine(pos1, pos2, c, Time.deltaTime * 2);
		Debug.DrawLine(pos2, pos3, c, Time.deltaTime * 2);
		Debug.DrawLine(pos3, pos4, c, Time.deltaTime * 2);
		Debug.DrawLine(pos4, pos1, c, Time.deltaTime * 2);
		Debug.DrawLine(pos3, pos1, c, Time.deltaTime * 2);
		Debug.DrawLine(pos4, pos2, c, Time.deltaTime * 2);

	}

	public static void DrawNavigation(CrowdAgentNavigator navigator, CrowdAgent agent)
	{
		if (EditorApplication.isPaused) return;
		Debug.DrawLine(agent.worldPosition, navigator.requestedDestination, Color.green, Time.deltaTime * 2);
	}

	public static void DrawUnitPaths(MinionPathData minionPathInfo, NativeSlice<float3> path)
	{
		if (EditorApplication.isPaused) return;
		if ((minionPathInfo.bitmasks & 4) == 0)
		{
			// No path finding
			return;
		}

		for (int i = minionPathInfo.currentCornerIndex; i < minionPathInfo.pathSize; i++)
		{
			if (i < 1) continue;
			Debug.DrawLine(path[i - 1], path[i], Color.green, Time.deltaTime * 2);
		}
	}

	public void WriteSelectedFormation()
	{
		if (EditorHelperSystem.I == null || EditorHelperSystem.I.formations.Length == 0)
			return;

		int i = formationId;
		
		GUILayout.BeginVertical("Box");

		foreach (KeyValuePair<string, string> pair in GetAllFields(EditorHelperSystem.I.formations.data[i].GetType(), EditorHelperSystem.I.formations.data[i]))
		{
			DrawField(pair.Key, pair.Value);
		}
		foreach(KeyValuePair<string, string> pair in GetAllFields(EditorHelperSystem.I.formations.agents[i].GetType(), EditorHelperSystem.I.formations.agents[i]))
		{
			DrawField(pair.Key, pair.Value);
		}
		foreach(KeyValuePair<string, string> pair in GetAllFields(EditorHelperSystem.I.formations.navigators[i].GetType(), EditorHelperSystem.I.formations.navigators[i]))
		{
			DrawField(pair.Key, pair.Value);
		}
		foreach(KeyValuePair<string, string> pair in GetAllFields(EditorHelperSystem.I.formations.closestFormations[i].GetType(), EditorHelperSystem.I.formations.closestFormations[i]))
		{
			DrawField(pair.Key, pair.Value);
		}
		foreach (KeyValuePair<string, string> pair in GetAllFields(EditorHelperSystem.I.formations.highLevelPaths[i].GetType(), EditorHelperSystem.I.formations.highLevelPaths[i]))
		{
			DrawField(pair.Key, pair.Value);
		}
		foreach (KeyValuePair<string, string> pair in GetAllFields(EditorHelperSystem.I.formations.integrityData[i].GetType(), EditorHelperSystem.I.formations.integrityData[i]))
		{
			DrawField(pair.Key, pair.Value);
		}

		GUILayout.EndVertical();
	}

	public void WriteSelectedUnit()
	{
		var e = EditorHelperSystem.I;
		if (e == null || e.minions.Length == 0) return;

		GUILayout.BeginVertical("Box");

		foreach (KeyValuePair<string, string> pair in GetAllFields(typeof(MinionData), e.minions.data[unitId]))
		{
			DrawField(pair.Key, pair.Value);
		}
		foreach (KeyValuePair<string, string> pair in GetAllFields(typeof(NavMeshLocation), e.minions.locationComponents[unitId].NavMeshLocation))
		{
			DrawField(pair.Key, pair.Value);
		}
		foreach (KeyValuePair<string, string> pair in GetAllFields(typeof(UnitTransformData), e.minions.transforms[unitId]))
		{
			DrawField(pair.Key, pair.Value);
		}
		foreach (KeyValuePair<string, string> pair in GetAllFields(typeof(MinionAttackData), e.minions.attackData[unitId]))
		{
			DrawField(pair.Key, pair.Value);
		}
		foreach (KeyValuePair<string, string> pair in GetAllFields(typeof(MinionTarget), e.minions.targets[unitId]))
		{
			DrawField(pair.Key, pair.Value);
		}
		foreach (KeyValuePair<string, string> pair in GetAllFields(typeof(MinionPathData), e.minions.pathsInfo[unitId]))
		{
			DrawField(pair.Key, pair.Value);
		}
		foreach (KeyValuePair<string, string> pair in GetAllFields(typeof(MinionBitmask), e.minions.bitmask[unitId]))
		{
			DrawField(pair.Key, pair.Value);
		}
		foreach (var pair in GetAllFields(typeof(TextureAnimatorData), e.minions.animationData[unitId]))
		{
			DrawField(pair.Key, pair.Value);
		}
		foreach (var pair in GetAllFields(typeof(RigidbodyData), e.minions.rigidbodies[unitId]))
		{
			DrawField(pair.Key, pair.Value);
		}

		GUILayout.EndVertical();
	}

	public void DrawField(string name, string value)
	{
		GUI.color = value == " " ? Color.green : Color.white;
		GUILayout.BeginHorizontal("Box");
		GUI.color = Color.white;

		GUILayout.Label(name);
		GUILayout.FlexibleSpace();
		GUILayout.Label(value);

		GUILayout.EndHorizontal();
	}

	public void CommonDrawings()
	{
		//var pos1 = FindClosestUnit.transform.Position;
		//var pos2 = FindClosestUnit.formation.Position +  FindClosestUnit.formation.GetOffsetFromCenter (FindClosestUnit.transform.IndexInFormation);
		//Debug.DrawLine (pos1, pos2, Color.yellow, Time.deltaTime * 2);

		for (int i = 0; i < EditorHelperSystem.I.formations.Length; i++)
		{
			if (DrawFormations) DrawFormation(EditorHelperSystem.I.formations.data[i]);
			if (DrawFormationsNavigation) DrawNavigation(EditorHelperSystem.I.formations.navigators[i], EditorHelperSystem.I.formations.agents[i]);
		}
		
		if (DrawUnitPathFinding)
		{
			for (int i = 0; i < EditorHelperSystem.I.minions.Length; i++)
			{
				DrawUnitPaths(EditorHelperSystem.I.minions.pathsInfo[i], EditorHelperSystem.I.minions.paths[i]);
			}
		}
		
		if (SelectFormations && !EditorApplication.isPaused)
		{
			var formation = EditorHelperSystem.I.formations.data[formationId];
			for (int j = 0; j < formation.UnitCount; j++)
			{
				Debug.DrawLine(formation.Position, formation.Position + formation.GetOffsetFromCenter(j), Color.yellow, Time.deltaTime * 2);
			}
		}

		if (SelectUnits)
		{
			var unit = EditorHelperSystem.I.minions.transforms[unitId];
			Color c = (EditorHelperSystem.I.minions.bitmask[unitId].IsFriendly) ? Color.blue : Color.red;

			Debug.DrawLine(unit.Position + new float3(1, 0, 1), unit.Position + new float3(1, 0, -1), c, Time.deltaTime * 2);
			Debug.DrawLine(unit.Position + new float3(1, 0, 1), unit.Position + new float3(-1, 0, 1), c, Time.deltaTime * 2);
			Debug.DrawLine(unit.Position + new float3(-1, 0, -1), unit.Position + new float3(1, 0, -1), c, Time.deltaTime * 2);
			Debug.DrawLine(unit.Position + new float3(-1, 0, -1), unit.Position + new float3(-1, 0, 1), c, Time.deltaTime * 2);
		}
	}

	public void OnSceneGUI(SceneView v)
	{
		var e = EditorHelperSystem.I;

		if (e == null) return;
		if (e.formations.Length == 0 || e.minions.Length == 0 || (!SelectFormations && !SelectUnits)) return;
		
		if (Event.current.type == EventType.MouseDown && Event.current.button == 0)
		{
			Ray ray = HandleUtility.GUIPointToWorldRay(Event.current.mousePosition);
			RaycastHit hit;

			if (Physics.Raycast(ray, out hit, Mathf.Infinity, FormationSystem.GroundLayermask))
			{
				Repaint();

				// Select formations
				if (SelectFormations)
				{
					int closestIndex = 0;
					for (int i = 1; i < e.formations.Length; i++)
					{
						if (math.distance(e.formations.data[closestIndex].Position, hit.point) >
							math.distance(e.formations.data[i].Position, hit.point))
						{
							closestIndex = i;
						}
					}

					formationId = closestIndex;
				}

				// Select units
				if (SelectUnits)
				{
					int closestIndex = 0;
					for (int i = 1; i < e.minions.Length; i++)
					{
						if (math.distance(e.minions.transforms[closestIndex].Position, hit.point) >
							math.distance(e.minions.transforms[i].Position, hit.point))
						{
							closestIndex = i;
						}
					}

					unitId = closestIndex;
				}
			}
		}
	}
}

[UpdateAfter(typeof(CommandSystem))]
public class EditorHelperSystem : JobComponentSystem
{
	public struct Minions
	{
		public ComponentDataArray<UnitTransformData> transforms;
		public ComponentDataArray<MinionTarget> targets;
		public ComponentDataArray<RigidbodyData> rigidbodies;
		public ComponentDataArray<TextureAnimatorData> animationData;
		public ComponentDataArray<MinionData> data;
		public ComponentDataArray<MinionPathData> pathsInfo;
		public FixedArrayArray<float3> paths;
		public ComponentDataArray<NavMeshLocationComponent> locationComponents;
		public ComponentDataArray<MinionAttackData> attackData;
		public ComponentDataArray<MinionBitmask> bitmask;
		public EntityArray entities;

		public int Length;
	}

	public struct Formations
	{
		public EntityArray entities;
		public ComponentDataArray<FormationClosestData> closestFormations;
		public ComponentDataArray<FormationData> data;
		public ComponentDataArray<CrowdAgent> agents;
		public ComponentDataArray<CrowdAgentNavigator> navigators;
		public ComponentDataArray<FormationHighLevelPath> highLevelPaths;
		public ComponentDataArray<FormationIntegrityData> integrityData;

		public int Length;
	}

	// To make sure dependencies for this system is a superset of the dependencies of FormationIntegritySystem
    [Inject]
    public FixedArrayFromEntity<EntityRef> entityRefs;


	[Inject]
	public Minions minions;

	[Inject]
	public Formations formations;

	[Inject]
	public FormationIntegritySystem integritySystem;
	[Inject]
	public SpawnerSystem spawnerSystem;
	
	public static EditorHelperSystem I;

	public Queue<Action> work;

	protected override void OnCreateManager()
	{
		base.OnCreateManager();

		work = new Queue<Action>();
		I = this;
	}

	bool completeDependencies = false;
	protected override JobHandle OnUpdate(JobHandle inputDeps)
	{
		if (completeDependencies)
		{
			inputDeps.Complete();
			return inputDeps;
		}
		while (work.Count > 0)
		{
			work.Dequeue().Invoke();
		}
		return inputDeps;
	}

	public void CompleteDependency()
	{
		// Hack to emulate CompleteDependency in the old ecs
		completeDependencies = true;
		Update();
		completeDependencies = false;
	}
}
