using Unity.Collections;
using Unity.Jobs;
using Unity.Mathematics;
using UnityEngine;
using Unity.Entities;
using UnityEngine.Experimental.AI;

[ComputeJobOptimization]
public struct MinionBehaviourJob : IJobParallelForBatch
{
	[ReadOnly]
	public ComponentDataArray<MinionTarget> targetPositions;
	[ReadOnly]
	public ComponentDataArray<RigidbodyData> rigidbodyData;
	[ReadOnly]
	public ComponentDataArray<MinionAttackData> minionAttackData;
	[ReadOnly]
	public ComponentDataArray<MinionData> minionData;
	[ReadOnly]
	public float archerAttackTime;

	public ComponentDataArray<TextureAnimatorData> animatorData;

	[ReadOnly]
	public ComponentDataArray<UnitTransformData> transforms;

	[ReadOnly]
	public ComponentDataArray<NavMeshLocationComponent> navMeshLocations;

	public NativeArray<Vector3> forwardsBuffer;
	public NativeArray<Vector3> positionsBuffer;
	public NativeArray<NavMeshLocation> locationsBuffer;

	[ReadOnly]
	public float dt;
	[ReadOnly]
	public int randomizer;

	public void Execute(int start, int count)
	{
		for (var i = 0; i < count; ++i)
		{
			var index = start + i;

			UnitTransformData transform = transforms[index];

			var animation = animatorData[index];
			var navLocation = navMeshLocations[index].NavMeshLocation;

			long seed = randomizer * index;

			// Handle pushing
			float3 newPosition = transform.Position;
			float3 newTransformForward = transform.Forward;
			
			if (minionData[index].attackCycle < 0)
			{
				animation.NewAnimationId = AnimationName.Idle;

				// rotate towards target position
				var relativeVector = targetPositions[index].Target - transform.Position;
				relativeVector.y = 0;

				var newForward = relativeVector;
				float3 delta = 0;

				// CHECK: math.any is not using approximately checks so it's fucking up here.
				//if (math.any(newForward) && !float.IsNaN(newForward.x) && !float.IsNaN(newForward.y) && !float.IsNaN(newForward.z))
				if (!MathUtil.Approximately(math.dot(newForward, newForward), 0))
				{
					// We should move
					float3 dstForward = math.normalize(newForward);
					newTransformForward = Vector3.RotateTowards(transform.Forward, dstForward, Mathf.PI * dt, 10);
					delta = dstForward * dt * targetPositions[index].speed;
				}
				else if (MathUtil.Approximately(math.dot(transform.Forward, transform.Forward), 0))
				{
					// If the forward vector is broken we should just fix it
					newTransformForward = new float3(0, 0, 1);
				}

				// move towards target position
				float dstSqr = math.dot(relativeVector, relativeVector);
				if (dstSqr == 0 || math.dot(delta, delta) > dstSqr)
				{
					// We reached the target
					if (math.distance(targetPositions[index].Target.xz, ((float3)navLocation.position).xz) > 0.0001f)
					{
						newPosition = targetPositions[index].Target;
						animation.NewAnimationId = AnimationName.Walk;
					}
				}
				else
				{
					newPosition = newPosition + delta;
					animation.NewAnimationId = AnimationName.Walk;
				}
			}
			else
			{
				if (animation.CurrentAnimationId != AnimationName.Attack1 && animation.CurrentAnimationId != AnimationName.Attack2)
					animation.NewAnimationId = Randomizer.next(0, ref seed) == 0 ? AnimationName.Attack1 : AnimationName.Attack2;

				float3 relative = minionAttackData[index].attackPosition - transform.Position;
				relative.y = 0;
				if (math.any(relative))
				{
					newTransformForward = Vector3.RotateTowards(transform.Forward, math.normalize(relative), Mathf.PI * dt, 10);
				}
				if (2 != animation.UnitType)
				{
					animation.AnimationNormalizedTime = minionData [index].attackCycle / MinionData.AttackTime;
				}
				else
				{
					animation.AnimationNormalizedTime = minionData [index].attackCycle / archerAttackTime;
				}
			}

			newPosition += rigidbodyData[index].Velocity * dt;

			animatorData[index] = animation;

			forwardsBuffer[index] = newTransformForward;
			positionsBuffer[index] = newPosition;
			locationsBuffer[index] = navLocation;
		}
	}
}
