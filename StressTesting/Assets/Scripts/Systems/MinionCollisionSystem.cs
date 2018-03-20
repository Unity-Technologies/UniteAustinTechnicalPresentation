using Unity.Collections;
using Unity.Jobs;
using UnityEngine;
using Unity.Entities;

[UpdateAfter(typeof(FormationIntegritySystem))]
public class MinionCollisionSystem : JobComponentSystem
{
	[Inject]
	private MinionSystem minionSystem;

	public struct Minions
	{
		[ReadOnly]
		public ComponentDataArray<AliveMinionData> aliveMinionsFilter;
		[ReadOnly]
		public ComponentDataArray<UnitTransformData> transforms;
		public ComponentDataArray<RigidbodyData> velocities;
		[ReadOnly]
		public ComponentDataArray<MinionBitmask> bitmask;
		public ComponentDataArray<MinionAttackData> attackData;
		public EntityArray entities;

		public int Length;
	}

	NativeList<UnitTransformData> m_Transforms;
	NativeList<Entity> m_Entities;
	NativeList<MinionBitmask> m_Bitmasks;
	
	[Inject]
	private Minions minions;

	protected override void OnCreateManager(int capacity)
	{
		m_Transforms = new NativeList<UnitTransformData>(Allocator.Persistent);
		m_Entities = new NativeList<Entity>(Allocator.Persistent);
		m_Bitmasks = new NativeList<MinionBitmask>(Allocator.Persistent);
	}

	protected override void OnDestroyManager()
	{
		m_Transforms.Dispose();
		m_Entities.Dispose();
		m_Bitmasks.Dispose();
	}

	protected override JobHandle OnUpdate(JobHandle inputDeps)
	{
		if (minions.Length == 0) return inputDeps;

		m_Transforms.ResizeUninitialized(minions.Length);
		m_Entities.ResizeUninitialized(minions.Length);
		m_Bitmasks.ResizeUninitialized(minions.Length);
		
		var prepareCollision = new PrepareMinionCollisionJob
		{
			entities = minions.entities,
			entitiesArray = m_Entities,
			
			transforms = minions.transforms,
			transformsArray = m_Transforms,
			
			minionBitmask = minions.bitmask,
			minionBitmaskArray = m_Bitmasks
		};
		inputDeps = prepareCollision.Schedule(minions.Length, 128, inputDeps);
		
		var collisionForceJob = new MinionCollisionJob
		{
			transforms = m_Transforms,
			buckets = minionSystem.CollisionBuckets,
			minionVelocities = minions.velocities,
			dt = Time.deltaTime,
			minionBitmask = m_Bitmasks,
			minionAttackData = minions.attackData,
			entities = m_Entities
		};

		var collisionJobFence = collisionForceJob.Schedule(minions.Length, SimulationState.BigBatchSize, inputDeps);

		return collisionJobFence;
	}
}
