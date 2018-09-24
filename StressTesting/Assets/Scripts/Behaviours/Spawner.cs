using System;
using Unity.Collections;
using Unity.Collections.LowLevel.Unsafe;
using Unity.Mathematics;
using UnityEngine;
using Unity.Entities;
using UnityEngine.Experimental.AI;

public class Spawner : MonoBehaviour
{
	public static Spawner Instance;

	public static int Counter = 0;

	[NonSerialized]
	public bool SpawningFinished = false;

	EntityManager entityManager;

	NavMeshQuery mapLocationQuery;

	public void Awake()
	{
		Instance = this; // worst singleton ever but it works
		entityManager = World.Active.GetExistingManager<EntityManager>();
		var navMeshWorld = NavMeshWorld.GetDefaultWorld();
		mapLocationQuery = new NavMeshQuery(navMeshWorld, Allocator.Persistent);
	}

	public void OnDestroy()
	{
		Instance = null;
		mapLocationQuery.Dispose();
	}

	public unsafe Entity Spawn(FormationData formationData, float3 spawnPointOffset, FormationWaypoint[] waypoints, bool spawnedFromPortals = false, float3? forward = null)
	{
		var formationEntity = entityManager.CreateEntity();

		RaycastHit hit;

		if (Physics.Raycast(new Ray((Vector3)formationData.Position + new Vector3(0, 1000000, 0), Vector3.down), out hit))
		{
			formationData.Position.y = hit.point.y;
		}
		if (!spawnedFromPortals) formationData.SpawnedCount = formationData.UnitCount;
		var location = mapLocationQuery.MapLocation(formationData.Position, new Vector3(100, 100, 100), 0);
		formationData.Position = location.position;

		if (forward == null)
		{
			formationData.Forward = new float3(0, 0, formationData.Position.z > 0 ? -1 : 1);
		}
		else
		{
			formationData.Forward = forward.Value;
		}

		formationData.HighLevelPathIndex = 1;

		FormationWaypoint bridgeStart = GetClosestWaypoint(waypoints, formationData.Position, !formationData.IsFriendly);
		FormationWaypoint bridgeEnd = Array.Find(waypoints, x => x.index == bridgeStart.index && x.isLeft != bridgeStart.isLeft);

		FormationHighLevelPath highLevelPath = new FormationHighLevelPath
		{
			target1 = bridgeStart.transform.position,
			target2 = bridgeEnd.transform.position,
			ultimateDestination = new float3(formationData.Position.x, formationData.Position.y, -Mathf.Sign(formationData.Position.z) * 200)
		};

		entityManager.AddComponentData(formationEntity, formationData);
		entityManager.AddComponentData(formationEntity, new FormationClosestData() { });
		entityManager.AddComponentData(formationEntity, new FormationNavigationData { TargetPosition = formationData.Position });

		entityManager.AddComponentData(formationEntity, new CrowdAgent { worldPosition = formationData.Position, type = 0, location = location});
		entityManager.AddComponentData(formationEntity, highLevelPath);
		entityManager.AddBuffer<EntityRef>(formationEntity);
		entityManager.AddBuffer<PolygonIdElement>(formationEntity);
		entityManager.AddComponentData(formationEntity, new FormationIntegrityData() { });

		var crowd = new CrowdAgentNavigator()
		{
			active = 1,
			newDestinationRequested = 0,
			goToDestination = 0,
			destinationInView = 0,
			destinationReached = 1,
		};
		entityManager.AddComponentData(formationEntity, crowd);

		var unitType = (UnitType)formationData.UnitType;

		GameObject minionPrefab;
		minionPrefab = GetMinionPrefab(unitType);

		var prototypeMinion = entityManager.Instantiate(minionPrefab);

		entityManager.AddComponentData(prototypeMinion, new MinionBitmask(formationData.IsFriendly, spawnedFromPortals));
		entityManager.AddComponentData(prototypeMinion, new MinionAttackData(new Entity()));
		entityManager.AddComponentData(prototypeMinion, new MinionPathData());
		entityManager.AddBuffer<PathElement>(prototypeMinion);
		entityManager.AddComponentData(prototypeMinion, new IndexInFormationData(-1));
		entityManager.AddComponentData(prototypeMinion, new NavMeshLocationComponent());
		

		var minions = new NativeArray<Entity>(formationData.UnitCount, Allocator.Temp);
		entityManager.Instantiate(prototypeMinion, minions);

		for (int i = 0; i < minions.Length; ++i)
		{
			var entity = minions[i];
			var transform = entityManager.GetComponentData<UnitTransformData>(entity);
			var animator = entityManager.GetComponentData<TextureAnimatorData>(entity);
			var minion = entityManager.GetComponentData<MinionData>(entity);
			var indexInFormation = entityManager.GetComponentData<IndexInFormationData>(entity);

			transform.FormationEntity = formationEntity;
			indexInFormation.IndexInFormation = i;
			transform.UnitType = (int)unitType;
			transform.Forward = formationData.Forward;

			float scale = entityManager.GetSharedComponentData<RenderingData>(entity).LodData.Scale;
			transform.Scale = UnityEngine.Random.Range(SimulationSettings.Instance.MinionScaleMin, SimulationSettings.Instance.MinionScaleMax) * scale;
			if (unitType != UnitType.Skeleton)
			{
				transform.HeightOffset = UnityEngine.Random.Range(SimulationSettings.Instance.MinionHeightOffsetMin,
																SimulationSettings.Instance.MinionHeightOffsetMax);
			}

			if (!spawnedFromPortals)
			{
				transform.Position = formationData.GetOffsetFromCenter(i) + formationData.Position;
			}
			else
			{
				float3 unitOffset = new float3((i % SimulationSettings.countPerSpawner), 0f, 0);
				transform.Position = formationData.Position + unitOffset + spawnPointOffset;
			}

			entityManager.SetComponentData(entity, new NavMeshLocationComponent(mapLocationQuery.MapLocation(transform.Position, Vector3.one * 10, 0)));

			animator.UnitType = (int)unitType;
			animator.AnimationSpeedVariation = UnityEngine.Random.Range(SimulationSettings.Instance.MinionAnimationSpeedMin,
																		SimulationSettings.Instance.MinionAnimationSpeedMax);

			minion.attackCycle = -1;

			MinionPathData pathComponent = new MinionPathData()
			{
				bitmasks = 0,
				pathSize = 0,
				currentCornerIndex = 0
			};

			entityManager.SetComponentData(entity, pathComponent);

			entityManager.SetComponentData(entity, transform);
			entityManager.SetComponentData(entity, animator);
			entityManager.SetComponentData(entity, minion);
			entityManager.SetComponentData(entity, indexInFormation);
		}

		minions.Dispose();
		entityManager.DestroyEntity(prototypeMinion);

		return formationEntity;
	}

	public static GameObject GetMinionPrefab(UnitType unitType)
	{
		GameObject minionPrefab;
		switch (unitType)
		{
			case UnitType.Melee:
				minionPrefab = ViewSettings.Instance.MeleePrefab;
				break;
			case UnitType.Skeleton:
				minionPrefab = ViewSettings.Instance.SkeletonPrefab;
				break;
			default:
				throw new ArgumentOutOfRangeException("unitType", unitType, null);
		}
		return minionPrefab;
	}

	public void SpawnArrow(ArrowData arrowData)
	{
		var entity = entityManager.CreateEntity(typeof(ArrowData));
		entityManager.SetComponentData(entity, arrowData);
	}

	private FormationWaypoint GetClosestWaypoint(FormationWaypoint[] waypoints, float3 position, bool isLeft)
	{
		FormationWaypoint result = null;

		foreach (var w in waypoints)
		{
			if (w.isLeft != isLeft) continue;

			if (result == null || math.abs(w.transform.position.x - position.x) < math.abs(result.transform.position.x - position.x ))
			{
				result = w;
			}
		}

		return result;
	}
}
