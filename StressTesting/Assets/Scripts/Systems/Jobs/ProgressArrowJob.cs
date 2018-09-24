using Unity.Collections;
using Unity.Jobs;
using Unity.Mathematics;
using UnityEngine;
using Unity.Entities;

//[ComputeJobOptimization]
public struct ProgressArrowJob : IJobParallelFor
{
	public ComponentDataArray<ArrowData> arrows;
	[ReadOnly]
	public EntityArray arrowEntities;

	[ReadOnly]
	public NativeMultiHashMap<int, int> buckets;

	[ReadOnly]
	public ComponentDataArray<UnitTransformData> allMinionTransforms;
	[ReadOnly]
	public ComponentDataArray<MinionBitmask> minionConstData;

	
	public NativeQueue<AttackCommand>.Concurrent AttackCommands;
	public NativeQueue<Entity>.Concurrent queueForKillingEntities;

	public NativeArray<RaycastCommand> raycastCommands;

	[ReadOnly]
	public EntityArray minionEntities;

	[ReadOnly]
	public float dt;

	public void Execute(int index)
	{
		var arrow = arrows[index];

		// Check if the arrow is fired
		if (arrow.active != 0)
		{
			arrow.position += arrow.velocity * dt;
			arrow.velocity.y += SimulationState.Gravity * dt;

			// Check if we hit something
			int i = 0;
			int hash = MinionSystem.Hash(arrow.position);
			NativeMultiHashMapIterator<int> iterator;
			bool found = buckets.TryGetFirstValue(hash, out i, out iterator);
			int iterations = 0;

			while (found)
			{
				if (iterations++ > 3) break;

				// This freezes :/
				var relative = arrow.position - allMinionTransforms[i].Position;
				var distance = math.length(relative);

				if (distance < 1f)
				{
					if ((arrow.IsFriendly == 1) != minionConstData[i].IsFriendly)
					{
						// Deal damage and deactivate the arrow
						AttackCommands.Enqueue(new AttackCommand(arrowEntities[index], minionEntities[i], 34));

						// Send it to the end of the earth
						arrow.active = 0;
						arrow.position = Vector3.one * -1000000;
						queueForKillingEntities.Enqueue(arrowEntities[index]);

						break;
					}
				}

				found = buckets.TryGetNextValue(out i, ref iterator);
			}

			if (arrow.active != 0)
			{
				raycastCommands[index] = RaycastHelper.CreateRaycastCommand(arrow.position);
			}
			arrows[index] = arrow;
		}
	}
}
