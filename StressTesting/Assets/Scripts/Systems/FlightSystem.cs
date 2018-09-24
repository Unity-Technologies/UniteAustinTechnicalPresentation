using Unity.Collections;
using Unity.Jobs;
using Unity.Mathematics;
using UnityEngine;
using Unity.Entities;

public class FlightSystem : JobComponentSystem
{
	public struct FlyingUnits
	{
		[ReadOnly]
		public ComponentDataArray<FlyingData> flyingSelector;
		public ComponentDataArray<UnitTransformData> transforms;
		public ComponentDataArray<RigidbodyData> rigidbodies;
		public ComponentDataArray<MinionData> data;
		public ComponentDataArray<TextureAnimatorData> animationData;

		public readonly int Length;
	}

	[Inject]
	private FlyingUnits flyingUnits;

	private NativeArray<RaycastHit> raycastHits;
	private NativeArray<RaycastCommand> raycastCommands;

	protected override void OnDestroyManager()
	{
		base.OnDestroyManager();

		if (raycastHits.IsCreated) raycastHits.Dispose();
		if (raycastCommands.IsCreated) raycastCommands.Dispose();
	}

	protected override JobHandle OnUpdate(JobHandle inputDeps)
	{
		if (flyingUnits.Length == 0) return inputDeps;

		// ============ REALLOC ===============

		// todo fix nativearray
		NativeArrayExtensions.ResizeNativeArray(ref raycastHits, math.max(raycastHits.Length, flyingUnits.Length));
		NativeArrayExtensions.ResizeNativeArray(ref raycastCommands, math.max(raycastCommands.Length, flyingUnits.Length));

		// ============ JOB CREATION ===============
		var prepareRaycastsJob = new PrepareRaycasts
		{
			transforms = flyingUnits.transforms,
			raycastCommands = raycastCommands
		};

		var flightJob = new MinionFlightJob
		{
			raycastHits = raycastHits,
			minionData = flyingUnits.data,
			flyingUnits = flyingUnits.transforms,
			rigidbodies = flyingUnits.rigidbodies,
			textureAnimators = flyingUnits.animationData,
			dt = Time.deltaTime,
		};

		// ==================== JOB SCHEDULING ==============
		var prepareRaycastFence = prepareRaycastsJob.Schedule(flyingUnits.Length, SimulationState.SmallBatchSize, inputDeps);
		prepareRaycastFence.Complete(); // TODO fix me
		var raycastJobFence = RaycastCommand.ScheduleBatch(raycastCommands, raycastHits, SimulationState.SmallBatchSize, prepareRaycastFence);
		var flightJobFence = flightJob.Schedule(flyingUnits.Length, SimulationState.SmallBatchSize, raycastJobFence);

		return flightJobFence;
	}
}
