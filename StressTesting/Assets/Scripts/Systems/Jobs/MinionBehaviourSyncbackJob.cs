using Unity.Collections;
using Unity.Jobs;
using Unity.Mathematics;
using UnityEngine;
using Unity.Entities;
using UnityEngine.Experimental.AI;

[ComputeJobOptimization]
public struct MinionBehaviourSyncbackJob : IJobParallelForBatch
{
	public ComponentDataArray<UnitTransformData> transforms;
	public ComponentDataArray<NavMeshLocationComponent> navMeshLocations;

	[DeallocateOnJobCompletion]
	public NativeArray<Vector3> forwardsBuffer;
	[DeallocateOnJobCompletion]
	public NativeArray<Vector3> positionsBuffer;
	[DeallocateOnJobCompletion]
	public NativeArray<NavMeshLocation> locationsBuffer;

	public void Execute(int start, int count)
	{
		for (var i = 0; i < count; ++i)
		{
			var index = start + i;
			var navLocation = locationsBuffer[index];
			var transform = transforms[index];
			var unitOffset = new float3(0, transform.HeightOffset, 0);
			transform.Position = (float3)navLocation.position + unitOffset;
			transform.Forward = forwardsBuffer[index];

			//if(float.IsNaN(transform.Position.x) || float.IsNaN(transform.Position.y) || float.IsNaN(transform.Position.z))
			//	transform.MinionState = UnitTransformData.State.Dead;

			//if (Interlocked.CompareExchange(ref aData->Health, 0, 0) <= 0)
			//{
			//	transform.MinionState = UnitTransformData.State.Dead;
			//	//animation.NewAnimationId = (int)AnimationName.Death;
			//}


			// CHECK: it worries me that we have to copy struct from array to a new one, edit it and then copy back?
			transforms[index] = transform;
			navMeshLocations[index] = new NavMeshLocationComponent { NavMeshLocation = navLocation };
		}
	}
}
