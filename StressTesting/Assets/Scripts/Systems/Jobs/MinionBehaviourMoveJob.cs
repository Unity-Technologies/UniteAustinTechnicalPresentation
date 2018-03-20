using Unity.Collections;
using Unity.Jobs;
using UnityEngine;
using Unity.Entities;
using UnityEngine.Experimental.AI;

 [ComputeJobOptimization]
public struct MinionBehaviourMoveJob : IJobParallelForBatch
{
	public NativeArray<Vector3> positionsBuffer;
	public NativeArray<NavMeshLocation> locationsBuffer;
	[ReadOnly]
	public NavMeshQuery query;

	public void Execute(int start, int count)
	{
		var locationsSlice = new NativeSlice<NavMeshLocation>(locationsBuffer, start, count);
		var positionsSlice = new NativeSlice<Vector3>(positionsBuffer, start, count);

		query.MoveLocationsInSameAreas(locationsSlice, positionsSlice);
	}
}
