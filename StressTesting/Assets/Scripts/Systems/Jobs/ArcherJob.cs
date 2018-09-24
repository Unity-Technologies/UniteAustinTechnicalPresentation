using Unity.Collections;
using Unity.Jobs;
using Unity.Mathematics;
using UnityEngine;
using Unity.Entities;

[Unity.Burst.BurstCompile]
public struct ArcherJob : IJobParallelFor
{
	public NativeQueue<ArrowData>.Concurrent createdArrowsQueue;

	public ComponentDataArray<MinionData> archers;

	[ReadOnly]
	public ComponentDataArray<UnitTransformData> transforms;

	[ReadOnly]
	public ComponentDataFromEntity<FormationData> formations;
	[ReadOnly]
	public ComponentDataFromEntity<FormationClosestData> closestFormationsFromEntity;
	[ReadOnly]
	public ComponentDataArray<MinionBitmask> minionConstData;

	[ReadOnly]
	public int randomizer;
	[ReadOnly]
	public float archerHitTime;

	[ReadOnly]
	public float archerAttackCycle;
	[ReadOnly]
	public float prevArcherAttackCycle;

	public void Execute(int index)
	{
		var t = transforms[index];
		var archer = archers[index];

		// check if closest formation exists
		var closestFormationEntity = closestFormationsFromEntity[t.FormationEntity].closestFormation;
		if (closestFormationEntity == new Entity())
			return;

		// Check the distance
		var closestFormation = formations[closestFormationEntity];
		if (mathx.lengthSqr(closestFormation.Position - t.Position) > RangedUnitData.ArcherAttackRangeSqr)
		{
			archer.attackCycle = -1;
			archers[index] = archer;

			return;
		}

		bool readyToAttack = false;

		if (archer.attackCycle < 0)
			archer.attackCycle = 0;

		archer.attackCycle = archerAttackCycle;

		long archerAttackVarianceSeed = index;
		float attackTimeVariance = Randomizer.Float(-0.15f, 0.15f, ref archerAttackVarianceSeed);
		float varianceHitTime = archerHitTime + attackTimeVariance;
		// Check Attack cycles
		if (archerAttackCycle >= varianceHitTime && prevArcherAttackCycle < varianceHitTime)
		{
			readyToAttack = true;
		}

		if (readyToAttack)
		{
			long seed = index * randomizer;

			float3 formationSideVector = closestFormation.Forward.zyx;
			formationSideVector.x = -formationSideVector.x;

			float3 targetPosition = closestFormation.Position + closestFormation.formationSide * formationSideVector * closestFormation.Width;
			targetPosition += new float3(Randomizer.Float(-20, 20, ref seed), 0, Randomizer.Float(-20, 20, ref seed));

			float3 relativeVector = targetPosition - t.Position;
			float distance = math.length(relativeVector.xz);
			float3 arrowStartingPosition = t.Position + new float3(0f, 3f, 0f);

			//if (math.all(math.abs(t.Position) < new float3(2, 2, 2)))
			//{
			//	Debug.Log(index + " " + t.FormationIndex + " " + t.IndexInFormation + " " + t.Position);
			//}

			float angle = Mathf.PI * math.lerp(0.36f, 0.2f, math.saturate(distance / RangedUnitData.ArcherAttackRange));
			float variant = Mathf.PI * 0.05f;
			angle = Randomizer.Float(angle - variant, angle + variant, ref seed);

			float velocity = GetArrowVelocity(distance, angle, arrowStartingPosition.y - closestFormation.Position.y);

			float3 shootingVector = math.normalize(new float3(relativeVector.x, 0, relativeVector.z));

			// rotate the vector
			float3 rotAxis = math.cross(shootingVector, new float3(0, 1, 0));
			Quaternion rotation = AngleAxis(angle, rotAxis);

			shootingVector = rotation * shootingVector;

			var arrow = new ArrowData() { IsFriendly = (minionConstData[index].IsFriendly ? 1 : 0) };
			// FIREEE!!!
			arrow.position = arrowStartingPosition;
			arrow.velocity = shootingVector * velocity;
			arrow.active = 1;

			createdArrowsQueue.Enqueue(arrow);
		}
		archers[index] = archer;
	}

	public static float GetArrowVelocity(float distance, float angle, float height)
	{
		float dg = distance * -SimulationState.Gravity;
		float sqr = 2 * dg * math.tan(angle) + 2 * -SimulationState.Gravity * height;

		if (sqr < 0)
		{
			// This can happen if the target is right above the shooter
			return 1;
		}

		return dg / (math.cos(angle) * math.sqrt(sqr));
	}

	internal static Quaternion AngleAxis(float angle, float3 axis)
	{
		Quaternion q = new Quaternion();
		float mag = math.length(axis);
		if (mag > 0.000001F)
		{
			float halfAngle = angle * 0.5f;

			q.w = math.cos(halfAngle);

			float s = math.sin(halfAngle) / mag;
			q.x = s * axis.x;
			q.y = s * axis.y;
			q.z = s * axis.z;
			return q;
		}
		else
		{
			return new Quaternion(0, 0, 0, 1);
		}
	}
}
