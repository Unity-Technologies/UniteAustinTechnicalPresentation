using Unity.Collections;
using Unity.Jobs;
using Unity.Mathematics;
using Unity.Entities;

[Unity.Burst.BurstCompile]
public struct PrepareBucketsJob : IJob
{

	[ReadOnly]
	public ComponentDataArray<UnitTransformData> transforms;
	[ReadOnly]
	public ComponentDataArray<MinionBitmask> minionBitmask;

	public NativeMultiHashMap<int, int> buckets;

	public void Execute()
	{
		for (int i = 0; i < transforms.Length; i++)
		{
			if (!minionBitmask[i].IsSpawned) continue;

			var hash = MinionSystem.Hash(transforms[i].Position);

			buckets.Add(hash, i);
		}
	}
}

[Unity.Burst.BurstCompile]
public struct PrepareMinionCollisionJob : IJobParallelFor
{
	[ReadOnly]
	public ComponentDataArray<UnitTransformData> 	transforms;

	[ReadOnly]
	public ComponentDataArray<MinionBitmask> 		minionBitmask;
	[ReadOnly]
	public EntityArray 								entities;

	public NativeArray<UnitTransformData> 			transformsArray;
	public NativeArray<MinionBitmask> 				minionBitmaskArray;
	public NativeArray<Entity> 						entitiesArray;

	public void Execute(int index)
	{
		transformsArray[index] = transforms[index];
		minionBitmaskArray[index] = minionBitmask[index];
		entitiesArray[index] = entities[index];
	}
}


[Unity.Burst.BurstCompile]
public struct MinionCollisionJob : IJobParallelFor
{
	[ReadOnly]
	public NativeArray<UnitTransformData> transforms;

	[ReadOnly]
	public NativeArray<Entity> entities;

	[ReadOnly]
	public NativeArray<MinionBitmask> minionBitmask;
	
	[ReadOnly]
	public NativeMultiHashMap<int, int> buckets;

	public ComponentDataArray<RigidbodyData> minionVelocities;
	public ComponentDataArray<MinionAttackData> minionAttackData;
	
	[ReadOnly]
	public float dt;

	public void Execute(int index)
	{
		if (!minionBitmask[index].IsSpawned) return;

		const float radius = 1f;
		const float radiusSqr = radius * radius;
		const float maxForce = 200f;
		const float damping = 8f;
		const float attackDistanceSqr = 1.1f * 1.1f;
		const float maxVelocity = 3.5f;
		const float maxVelocitySqr = maxVelocity * maxVelocity;

		var currentTransform = transforms[index];
		var currentMinion = minionVelocities[index];
		var attackData = minionAttackData[index];
		attackData.targetEntity = new Entity();

		var velocity = currentMinion.Velocity.xz;
		
		//if (velocity.x <= 0f && velocity.y <= 0f) velocity = 0f;

		int i = 0;
		int hash = MinionSystem.Hash(currentTransform.Position);
		NativeMultiHashMapIterator<int> iterator;
		bool found = buckets.TryGetFirstValue(hash, out i, out iterator);

		int iterations = 0;

		bool attacked = false;
		int closestDone = 0;

		const int maxIterations = 6;
		while (found)
		{
			if (i == index)
			{
				// Exclude self
				found = buckets.TryGetNextValue(out i, ref iterator);
				continue;
			}

			var epsilon = 0.00001f;

			// Construct the force direction
			var relative = currentTransform.Position.xz - transforms[i].Position.xz;

			if (mathx.lengthSqr(relative) < epsilon || !math.any(relative)) relative = new float2(1, 0);

			float distanceSqr = mathx.lengthSqr(relative);

			// Update velocity data
			float str = math.max(0, radiusSqr - distanceSqr) / radiusSqr;
			velocity += math.normalize(relative) * str * maxForce * dt;

			// Take attack distance into consideration
			if (currentTransform.UnitType != 2 && distanceSqr <= attackDistanceSqr && !attacked)
			{
				//Check if we can attack someone
				if (minionBitmask[index].IsFriendly != minionBitmask[i].IsFriendly)
				{
					attackData.targetEntity = entities[i];
					attackData.attackPosition = transforms[i].Position;

					attacked = true;
				}
			}

			// Next iteration
			found = buckets.TryGetNextValue(out i, ref iterator);

			// We will check 3 cells in the corner
			if (!found && closestDone < 3)
			{
				var position = currentTransform.Position.xz / MinionSystem.step;
				var flooredPosition = new int2(math.floor(position));

				var nextQuantizedPosition = new int2(math.round(2f * position - (flooredPosition + new float2(0.5f))));
				if (nextQuantizedPosition.x == flooredPosition.x) nextQuantizedPosition.x -= 1;
				if (nextQuantizedPosition.y == flooredPosition.y) nextQuantizedPosition.y -= 1;

				if (closestDone == 1) nextQuantizedPosition.x = flooredPosition.x;
				else if (closestDone == 2) nextQuantizedPosition.y = flooredPosition.y;

				int nextHash = nextQuantizedPosition.x + MinionSystem.fieldWidthHalf + (nextQuantizedPosition.y + MinionSystem.fieldHeightHalf) * MinionSystem.fieldWidth;

				found = buckets.TryGetFirstValue(nextHash, out i, out iterator);

				closestDone++;
			}

			if (++iterations > maxIterations) break;
		}

		var dampingStr = velocity * damping * dt;
		velocity -= dampingStr;

		currentMinion.Velocity = new float3(velocity.x, 0, velocity.y);
		if (math.dot(currentMinion.Velocity, currentMinion.Velocity) > maxVelocitySqr)
			currentMinion.Velocity = math.normalize(currentMinion.Velocity) * maxVelocity;

		minionVelocities[index] = currentMinion;
		minionAttackData[index] = attackData;
	}
}
