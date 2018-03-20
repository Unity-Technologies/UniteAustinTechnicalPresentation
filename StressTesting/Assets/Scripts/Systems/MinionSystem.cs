using Unity.Collections;
using Unity.Jobs;
using Unity.Mathematics;
using UnityEngine;
using Unity.Entities;
using UnityEngine.Experimental.AI;

[UpdateAfter(typeof(MinionAttackSystem))]
public class MinionSystem : JobComponentSystem
{
	public struct Minions
	{
		[ReadOnly]
		public ComponentDataArray<AliveMinionData> aliveMinionsFilter;
		[ReadOnly]
		public ComponentDataArray<MinionTarget> targets;
		public ComponentDataArray<MinionData> minions;
		public ComponentDataArray<UnitTransformData> transforms;
		public ComponentDataArray<RigidbodyData> velocities;
		public ComponentDataArray<TextureAnimatorData> animationData;
		public ComponentDataArray<MinionBitmask> bitmask;
		public ComponentDataArray<NavMeshLocationComponent> navMeshLocations;
		public ComponentDataArray<MinionAttackData> attackData;
		public EntityArray entities;
		public ComponentDataArray<IndexInFormationData> indicesInFormation;

		public int Length;
	}
	
	[Inject]
	private Minions minions;
	
	[Inject]
	private ComponentDataFromEntity<FormationClosestData> formationClosestDataFromEntity;

	[Inject]
	private ComponentDataFromEntity<FormationData> formationsFromEntity;
	
	public NativeMultiHashMap<int, int> CollisionBuckets;

	[Inject]
	private FormationSystem formationSystem;

	public const int fieldWidth = 4000;
	public const int fieldWidthHalf = fieldWidth / 2;
	public const int fieldHeight = 4000;
	public const int fieldHeightHalf = fieldHeight / 2;
	public const float step = 2f;
	
	NavMeshQuery moveLocationQuery;
	protected override void OnCreateManager(int capacity)
	{
		var navMeshWorld = NavMeshWorld.GetDefaultWorld();
		moveLocationQuery = new NavMeshQuery(navMeshWorld, Allocator.Persistent);
	}
	protected override void OnDestroyManager()
	{
		base.OnDestroyManager();

		if (CollisionBuckets.IsCreated) CollisionBuckets.Dispose();
		moveLocationQuery.Dispose();
	}

	public static int Hash(float3 position)
	{
		int2 quantized = new int2(math.floor(position.xz / step));
		return quantized.x + fieldWidthHalf + (quantized.y + fieldHeightHalf) * fieldWidth;
	}

	public void ForceInjection()
	{
		UpdateInjectedComponentGroups();
	}

	protected override JobHandle OnUpdate(JobHandle inputDeps)
	{
		if (!Application.isPlaying)
			return inputDeps;

		if (minions.Length == 0) return inputDeps; // I still hate this initialization issues

		// TODO maybe fix native array
		var forwardsBuffer = new NativeArray<Vector3>(minions.Length, Allocator.TempJob);
		var positionsBuffer = new NativeArray<Vector3>(minions.Length, Allocator.TempJob);
		var locationsBuffer = new NativeArray<NavMeshLocation>(minions.Length, Allocator.TempJob);
		

		// ============ JOB CREATION ===============
		var minionBehaviorJob = new MinionBehaviourJob
		{
			rigidbodyData = minions.velocities,
			targetPositions = minions.targets,
			transforms = minions.transforms,
			minionAttackData = minions.attackData,
			minionData = minions.minions,
			animatorData = minions.animationData,
			navMeshLocations = minions.navMeshLocations,
			forwardsBuffer = forwardsBuffer,
			positionsBuffer = positionsBuffer,
			locationsBuffer = locationsBuffer,
			archerAttackTime = SimulationSettings.Instance.ArcherAttackTime,
			dt = Time.deltaTime,
			randomizer = Time.frameCount,
		};

		var minionBehaviorMoveJob = new MinionBehaviourMoveJob
		{
			positionsBuffer = positionsBuffer,
			locationsBuffer = locationsBuffer,
			query = moveLocationQuery
		};

		var minionBehaviorSyncbackJob = new MinionBehaviourSyncbackJob
		{
			transforms = minions.transforms,
			navMeshLocations = minions.navMeshLocations,
			forwardsBuffer = forwardsBuffer,
			positionsBuffer = positionsBuffer,
			locationsBuffer = locationsBuffer
		};

		
		var minionBehaviorJobFence = minionBehaviorJob.ScheduleBatch(minions.Length, SimulationState.BigBatchSize,
			inputDeps);
		minionBehaviorJobFence = minionBehaviorMoveJob.ScheduleBatch(minions.Length, SimulationState.BigBatchSize, minionBehaviorJobFence);
		var navMeshWorld = NavMeshWorld.GetDefaultWorld();
		navMeshWorld.AddDependency(minionBehaviorJobFence);
		minionBehaviorJobFence = minionBehaviorSyncbackJob.ScheduleBatch(minions.Length, SimulationState.BigBatchSize, minionBehaviorJobFence);

		return minionBehaviorJobFence;
	}
}
