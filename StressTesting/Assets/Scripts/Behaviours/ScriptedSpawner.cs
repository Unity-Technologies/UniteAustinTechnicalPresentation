using Unity.Mathematics;
using UnityEngine;
using Unity.Entities;

public class ScriptedSpawner : MonoBehaviour
{
	public int Priority = 0;

	public bool IsFriendly;
	public UnitType UnitType;
	public int Count = 1;
	public int Width = 1;

	public bool Static = false;
	public bool InactiveAtStart;

	public float RightStep = 17f;
	public float BackStep = 10f;

	private Spawner spawner;

	private FormationWaypoint[] formationWaypoints;

	private TextureAnimatorSystem textureAnimatorSystem;

	private void Start()
	{
		spawner = FindObjectOfType<Spawner>();
		formationWaypoints = FindObjectsOfType<FormationWaypoint>();
		textureAnimatorSystem = World.Active.GetExistingManager<TextureAnimatorSystem>();
	}

	public int Spawn(int index)
	{
		var forward = transform.forward;
		var left = Vector3.Cross(forward, transform.up);
		var right = -left;
		var back = -forward;

		int totalSpawned = 0;

		for (int i = 0; i < Count; i++)
		{
			if (textureAnimatorSystem.initialized && textureAnimatorSystem.initialized && textureAnimatorSystem.perUnitTypeDataHolder[UnitType].Count
				+ SimulationSettings.Instance.UnitsPerFormation >= 32000)
			{
				break;
			}
#if !ENABLE_HLVM_COMPILER
			if (i % SimulationSettings.Instance.IfBurstIsNotSupportedSpawnFormationsDividedBy != 0) continue;
#endif
			if (textureAnimatorSystem.initialized) textureAnimatorSystem.perUnitTypeDataHolder[UnitType].Count = textureAnimatorSystem.perUnitTypeDataHolder[UnitType].Count + SimulationSettings.Instance.UnitsPerFormation;
			int row = i / Width;
			int column = i % Width;

			float3 position = transform.position;

			position += (float3)(column * RightStep * left + row * BackStep * back);
			position.y = 0;

			SpawnFormation(position, forward);
			totalSpawned++;
		}

		return totalSpawned;
	}

	private void SpawnFormation(float3 position, Vector3 forward)
	{
		if (spawner == null) return;

		var settings = SimulationSettings.Instance;

		int unitCount = SimulationSettings.Instance.UnitsPerFormation;
		var formationData = new FormationData(unitCount, settings.FormationWidth, IsFriendly, UnitType, position);
		if(Static) formationData.EnableMovement = false;
		spawner.Spawn(formationData, new float3(0, 0, 0), formationWaypoints, false, forward);
	}

	private void OnDrawGizmosSelected()
	{
		if (IsFriendly)
		{
			Gizmos.color = Color.blue;
		}
		else
		{
			Gizmos.color = Color.red;
		}

		for (int i = 0; i < Count; i++)
		{
			int row = i / Width;
			int column = i % Width;

			float3 position = transform.position;

			var forward = transform.forward;
			var left = Vector3.Cross(forward, transform.up);
			var right = -left;
			var back = -forward;

			position += (float3)(column * RightStep * left + row * BackStep * back);
			position.y = 0.3f;

			float3 topLeft = position + (float3)(8 * left + 4 * forward);
			float3 bottomLeft = position + (float3)(8 * left + 4 * back);
			float3 topRight = position + (float3)(8 * right + 4 * forward);
			float3 bottomRight = position + (float3)(8 * right + 4 * back);

			Gizmos.DrawLine(topLeft, bottomLeft);
			Gizmos.DrawLine(topLeft, topRight);
			Gizmos.DrawLine(bottomLeft, bottomRight);
			Gizmos.DrawLine(topRight, bottomRight);
			Gizmos.DrawLine(position, position + (float3)(forward * 4f));
		}
	}
}
