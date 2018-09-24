using System.Collections.Generic;
using UnityEngine;
using Unity.Entities;
using Assets.Instancing.Skinning.Scripts.ECS;
using UnityEngine.Profiling;
using System;
using Unity.Collections;
using Unity.Collections.LowLevel.Unsafe;
using Unity.Jobs;
using Unity.Mathematics;

[UpdateAfter(typeof(SpellSystem))]
public class UnitLifecycleManager : JobComponentSystem
{
	public struct Units
	{
		public ComponentDataArray<UnitTransformData> transform;
		public ComponentDataArray<MinionTarget> targets;
		public ComponentDataArray<RigidbodyData> rigidbodies;
		public ComponentDataArray<TextureAnimatorData> animationData;
		public ComponentDataArray<MinionData> data;
		public ComponentDataArray<MinionPathData> pathsInfo;
		public EntityArray entities;
		public int Length;
	}

	public struct DyingUnits
	{
		public ComponentDataArray<DyingUnitData> dyingData;
		public EntityArray entities;
		public ComponentDataArray<UnitTransformData> transforms;
		public int Length;
	}

	public struct DyingArrows
	{
		public ComponentDataArray<DyingUnitData> dyingData;
		public EntityArray entities;
		public ComponentDataArray<ArrowData> data;
		public int Length;
	}

	[Inject]
	private Units units;

	[Inject]
	private DyingUnits dyingUnits;

	[Inject]
	private DyingArrows dyingArrows;

	public NativeQueue<Entity> queueForKillingEntities;
	public NativeQueue<Entity> deathQueue;
	public NativeQueue<Entity> entitiesForFlying;

	public int MaxDyingUnitsPerFrame = 250;

	public NativeQueue<ArrowData> createdArrows;
	private const int CreatedArrowsQueueSize = 100000;

	private const int DeathQueueSize = 80000;

	[Inject]
	private SpellSystem spellSystem;

	private Queue<Entity> entitiesThatNeedToBeKilled = new Queue<Entity>(100000);

	protected override unsafe void OnDestroyManager()
	{
		if (queueForKillingEntities.IsCreated) queueForKillingEntities.Dispose();
		if (deathQueue.IsCreated) deathQueue.Dispose();
		if (createdArrows.IsCreated) createdArrows.Dispose();
		if (entitiesForFlying.IsCreated) entitiesForFlying.Dispose();

		base.OnDestroyManager();
	}

	protected override void OnCreateManager()
	{
		base.OnCreateManager();
		if (!queueForKillingEntities.IsCreated) queueForKillingEntities = new NativeQueue<Entity>(Allocator.Persistent);
		if (!entitiesForFlying.IsCreated) entitiesForFlying = new NativeQueue<Entity>(Allocator.Persistent);
	}

	protected override JobHandle OnUpdate(JobHandle inputDeps)
	{
		if (units.entities.Length == 0) return inputDeps;
		Profiler.BeginSample("Explosion wait");
		spellSystem.CombinedExplosionHandle.Complete(); // TODO try to remove this 
		Profiler.EndSample();
		inputDeps.Complete();
		Profiler.BeginSample("Spawn ");

		if (!deathQueue.IsCreated) deathQueue = new NativeQueue<Entity>(Allocator.Persistent);
		if (!createdArrows.IsCreated) createdArrows = new NativeQueue<ArrowData>(Allocator.Persistent);

		while (createdArrows.Count > 0)
		{
			var data = createdArrows.Dequeue();
			Spawner.Instance.SpawnArrow(data);
		}

		UpdateInjectedComponentGroups();

		var cleanupJob = new CleanupJob
		{
			deathQueue = deathQueue.ToConcurrent(),
			minionData = units.data,
			entitites = units.entities
		};

		var moveUnitsJob = new MoveUnitsBelowGround()
		{
			dyingUnitData = dyingUnits.dyingData,
			transforms = dyingUnits.transforms,
			time = Time.time
		};

		var cleanupJobFence = cleanupJob.Schedule(units.Length, SimulationState.BigBatchSize, inputDeps);
		var moveUnitsBelowGroundFence = moveUnitsJob.Schedule(dyingUnits.Length, SimulationState.HugeBatchSize, spellSystem.CombinedExplosionHandle);

		Profiler.EndSample();

		cleanupJobFence.Complete();
		moveUnitsBelowGroundFence.Complete();

		Profiler.BeginSample("LifeCycleManager - Main Thread");

		float time = Time.time;
		if (dyingUnits.Length > 0)
		{
			for (int i = 0; i < dyingUnits.Length; i++)
			{
				if (time > dyingUnits.dyingData[i].TimeAtWhichToExpire)
				{
					var entityToKill = dyingUnits.entities[i];
					queueForKillingEntities.Enqueue(entityToKill);
				}
				//else if (time > dyingData[i].TimeAtWhichToExpire - 2f)
				//{
				//	float t = (dyingData[i].TimeAtWhichToExpire - time) / 2f;
				//	var transform = transforms[i];
				//	transform.Position.y = math.lerp(dyingData[i].StartingYCoord, dyingData[i].StartingYCoord - 1f, t);
				//	transforms[i] = transform;
				//}
			}
		}

		if (dyingArrows.Length > 0)
		{
			for (int i = 0; i < dyingArrows.Length; i++)
			{
				if (time > dyingArrows.dyingData[i].TimeAtWhichToExpire)
				{
					var arrowToKill = dyingArrows.entities[i];
					queueForKillingEntities.Enqueue(arrowToKill);
				}
			}
		}

		Profiler.EndSample();
		Profiler.BeginSample("Queue processing");

		float timeForUnitExpiring = Time.time + 5f;
		float timeForArrowExpiring = Time.time + 1f;

		Profiler.BeginSample("Death queue");
		int processed = 0;
		while (deathQueue.Count > 0)
		{
			var entityToKill = deathQueue.Dequeue();
			if (EntityManager.HasComponent<MinionData>(entityToKill))
			{
				EntityManager.RemoveComponent<MinionData>(entityToKill);
				entitiesThatNeedToBeKilled.Enqueue(entityToKill);
			}

			if (EntityManager.HasComponent<ArrowData>(entityToKill))
			{
				EntityManager.AddComponentData(entityToKill, new DyingUnitData(timeForArrowExpiring, 0));
			}
		}
		Profiler.EndSample();

		Profiler.BeginSample("Explosion wait");
		spellSystem.CombinedExplosionHandle.Complete();
		Profiler.EndSample();

		Profiler.BeginSample("Killing minionEntities");
		// TODO try batched replacing 
		while (entitiesThatNeedToBeKilled.Count > 0 && processed < MaxDyingUnitsPerFrame)
		{
			processed++;
			var entityToKill = entitiesThatNeedToBeKilled.Dequeue();
			if (EntityManager.HasComponent<MinionTarget>(entityToKill))
			{
				EntityManager.RemoveComponent<MinionTarget>(entityToKill);
				if (EntityManager.HasComponent<AliveMinionData>(entityToKill)) EntityManager.RemoveComponent<AliveMinionData>(entityToKill);

				var textureAnimatorData = EntityManager.GetComponentData<TextureAnimatorData>(entityToKill);
				textureAnimatorData.NewAnimationId = AnimationName.Death;
				var transform = EntityManager.GetComponentData<UnitTransformData>(entityToKill);
				EntityManager.AddComponentData(entityToKill, new DyingUnitData(timeForUnitExpiring, transform.Position.y));

				EntityManager.SetComponentData(entityToKill, textureAnimatorData);

				var formations = GetComponentDataFromEntity<FormationData>();
				var formation = formations[transform.FormationEntity];
				formation.UnitCount--;
				formation.Width = (int)math.ceil((math.sqrt(formation.UnitCount / 2f) * 2f));
				if (formation.UnitCount == 0)
					formation.FormationState = FormationData.State.AllDead;
				formations[transform.FormationEntity] = formation;
			}
		}
		Profiler.EndSample();

		processed = 0;
		Profiler.BeginSample("Flying queue");
		while (entitiesForFlying.Count > 0 && processed < MaxDyingUnitsPerFrame)
		{
			processed++;
			var entity = entitiesForFlying.Dequeue();
			if (EntityManager.Exists(entity) && !EntityManager.HasComponent<FlyingData>(entity))
			{
				if (EntityManager.HasComponent(entity, typeof(AliveMinionData))) EntityManager.RemoveComponent<AliveMinionData>(entity);
				EntityManager.AddComponentData(entity, new FlyingData());
			}
		}
		Profiler.EndSample();

		Profiler.BeginSample("Destroying entities");
		while (queueForKillingEntities.Count > 0)
		{
			EntityManager.DestroyEntity(queueForKillingEntities.Dequeue());
		}
		Profiler.EndSample();

		Profiler.EndSample();
		return new JobHandle();
	}

	[ComputeJobOptimization]
	private struct CleanupJob : IJobParallelFor
	{
		[ReadOnly]
		public ComponentDataArray<MinionData> minionData;
		[ReadOnly]
		public EntityArray entitites;

		public NativeQueue<Entity>.Concurrent deathQueue;

		public void Execute(int i)
		{
			if (minionData[i].Health <= 0)
			{
				deathQueue.Enqueue(entitites[i]);
			}
		}
	}

	[ComputeJobOptimization]
	private struct MoveUnitsBelowGround : IJobParallelFor
	{
		[ReadOnly]
		public ComponentDataArray<DyingUnitData> dyingUnitData;

		public ComponentDataArray<UnitTransformData> transforms;

		public float time;

		public void Execute(int i)
		{
			var dyingData = dyingUnitData[i];
			var transform = transforms[i];

			float t = (dyingData.TimeAtWhichToExpire - time) / 5f;
			t = math.clamp(t, 0, 1);
			transform.Position.y = math.lerp(dyingData.StartingYCoord - 0.8f, dyingData.StartingYCoord, t);

			transforms[i] = transform;
		}
	}
}
