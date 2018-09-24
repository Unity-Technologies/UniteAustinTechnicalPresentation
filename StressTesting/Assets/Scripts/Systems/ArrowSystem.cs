using Unity.Collections;
using Unity.Jobs;
using Unity.Mathematics;
using UnityEngine;
using Unity.Entities;

[UpdateAfter(typeof(MinionSystem))]
public class ArrowSystem : JobComponentSystem
{
	public struct Arrows
	{
		public ComponentDataArray<ArrowData> data;
		public EntityArray entities;

		public readonly int Length;
	}

	public struct Minions
	{
		[ReadOnly]
		public ComponentDataArray<AliveMinionData> aliveMinionsFilter;
		[ReadOnly]
		public ComponentDataArray<MinionBitmask> constData;
		[ReadOnly]
		public ComponentDataArray<UnitTransformData> transforms;
		public EntityArray entities;

		public readonly int Length;
	}

	[Inject]
	private Arrows arrows;

	[Inject]
	private Minions minions;

	[Inject]
	private MinionSystem minionSystem;

	private NativeArray<RaycastHit> raycastHits;
	private NativeArray<RaycastCommand> raycastCommands;

	[Inject]
	private UnitLifecycleManager lifecycleManager;

	protected override void OnDestroyManager ()
	{
		base.OnDestroyManager ();
		if (raycastHits.IsCreated) raycastHits.Dispose();
		if (raycastCommands.IsCreated) raycastCommands.Dispose();
	}

	protected override JobHandle OnUpdate(JobHandle inputDeps)
	{
		if (minionSystem == null) return inputDeps;

		if (arrows.Length == 0) return inputDeps;
		if (minions.Length == 0) return inputDeps;

		// Update seems to be called after Play mode has been exited

		// ============ REALLOC ===============
		// todo fix nativearray
		NativeArrayExtensions.ResizeNativeArray(ref raycastHits, math.max(raycastHits.Length, arrows.Length));
		NativeArrayExtensions.ResizeNativeArray(ref raycastCommands, math.max(raycastCommands.Length, arrows.Length));

		// ============ JOB CREATION ===============

		var arrowJob = new ProgressArrowJob
		{
			raycastCommands = raycastCommands,
			arrows = arrows.data,
			arrowEntities = arrows.entities,
			dt = Time.deltaTime,
			allMinionTransforms = minions.transforms,
			buckets = minionSystem.CollisionBuckets,
			minionConstData = minions.constData,
			AttackCommands = CommandSystem.AttackCommandsConcurrent,
			minionEntities = minions.entities,
			queueForKillingEntities = lifecycleManager.queueForKillingEntities.ToConcurrent()
		};
			
		var stopArrowJob = new StopArrowsJob
		{
			raycastHits = raycastHits,
			arrows = arrows.data,
			arrowEntities = arrows.entities,
			stoppedArrowsQueue = lifecycleManager.deathQueue.ToConcurrent()
		};

		var arrowJobFence = arrowJob.Schedule(arrows.Length, SimulationState.SmallBatchSize, JobHandle.CombineDependencies(inputDeps, CommandSystem.AttackCommandsFence));
		arrowJobFence.Complete();
		var raycastJobFence = RaycastCommand.ScheduleBatch(raycastCommands, raycastHits, SimulationState.SmallBatchSize, arrowJobFence);
		var stopArrowJobFence = stopArrowJob.Schedule(arrows.Length, SimulationState.SmallBatchSize, raycastJobFence);

		CommandSystem.AttackCommandsConcurrentFence = JobHandle.CombineDependencies(stopArrowJobFence, CommandSystem.AttackCommandsConcurrentFence);
		// Complete arrow movement
		return stopArrowJobFence;
	}
	
	//[ComputeJobOptimization]
	public struct StopArrowsJob : IJobParallelFor
	{
		public ComponentDataArray<ArrowData> arrows;
		[ReadOnly]
		public EntityArray arrowEntities;

		[ReadOnly]
		public NativeArray<RaycastHit> raycastHits;

		public NativeQueue<Entity>.Concurrent stoppedArrowsQueue;

		public void Execute(int index)
		{
			if (arrows[index].active != 0)
			{
				var arrow = arrows[index];

				if (arrow.position.y <= raycastHits[index].point.y)
				{
					arrow.active = 0;
					arrows[index] = arrow;
					stoppedArrowsQueue.Enqueue (arrowEntities [index]);
				}
			}
		}
	}
}