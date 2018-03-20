using Unity.Collections;
using Unity.Jobs;
using Unity.Mathematics;
using UnityEngine;
using Unity.Entities;
using UnityEngine.Profiling;

[UpdateAfter(typeof(CrowdSystem))]
public class PrepareBucketsSystem : JobComponentSystem
{
	[Inject]
	private MinionSystem minionSystem;

	public struct Minions
	{
		[ReadOnly]
		public ComponentDataArray<AliveMinionData> aliveMinionsFilter;
		[ReadOnly]
		public ComponentDataArray<UnitTransformData> transforms;
		[ReadOnly]
		public ComponentDataArray<MinionBitmask> bitmask;

		public int Length;
	}
	
	[Inject]
	private Minions minions;

	protected override JobHandle OnUpdate(JobHandle inputDeps)
	{
		if (minions.Length == 0) return inputDeps;

		Profiler.BeginSample("Clearing buckets");

		if (!minionSystem.CollisionBuckets.IsCreated) minionSystem.CollisionBuckets = new NativeMultiHashMap<int, int>(minions.Length, Allocator.Persistent);
		else minionSystem.CollisionBuckets.Clear();

		// realloc if needed
		minionSystem.CollisionBuckets.Capacity = math.max(minionSystem.CollisionBuckets.Capacity, minions.Length);

		Profiler.EndSample();

		var prepareBucketsJob = new PrepareBucketsJob
		{
			transforms = minions.transforms,
			buckets = minionSystem.CollisionBuckets,
			minionBitmask = minions.bitmask
		};

		var PrepareBucketsFence = prepareBucketsJob.Schedule(inputDeps);
		return PrepareBucketsFence;
	}
}