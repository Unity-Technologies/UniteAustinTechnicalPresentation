using Unity.Collections;
using Unity.Jobs;
using Unity.Entities;

[Unity.Burst.BurstCompile]
public struct AttackTargetJob : IJobParallelFor
{
	[ReadOnly]
	public ComponentDataArray<MinionAttackData> minionAttacks;

	public ComponentDataArray<MinionData> minions;

	[ReadOnly]
	public EntityArray entities;

	[ReadOnly]
	public ComponentDataArray<UnitTransformData> minionTransforms;

	[ReadOnly]
	public float dt;

	public NativeQueue<AttackCommand>.Concurrent AttackCommands;

	public void Execute(int index)
	{
		var minion = minions[index];
		var minionAttack = minionAttacks[index];

		if (minionTransforms[index].UnitType == 2)
		{
			return;
		}
		if (minion.attackCycle < 0)
		{
			if (minionAttack.targetEntity == new Entity()) return;
			minion.attackCycle = 0;
		}

		var prevAttackCycle = minion.attackCycle;

		if (minion.attackCycle + dt >= MinionData.HitTime && prevAttackCycle < MinionData.HitTime)
		{
			AttackCommands.Enqueue(new AttackCommand(entities[index], minionAttack.targetEntity, 25));
		}
		minion.attackCycle += dt;
		if (minion.attackCycle > MinionData.AttackTime)
		{
			if (minionAttack.targetEntity == new Entity()) minion.attackCycle = -1;
			else minion.attackCycle -= MinionData.AttackTime;
		}

		minions[index] = minion;
	}
}
