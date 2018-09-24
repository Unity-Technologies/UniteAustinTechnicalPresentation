using Unity.Collections;
using Unity.Jobs;
using UnityEngine;
using Unity.Entities;

[UpdateAfter(typeof(ArcherMinionSystem))]
public class MinionAttackSystem : JobComponentSystem
{
	private struct Minions
	{
		[ReadOnly]
		public ComponentDataArray<AliveMinionData> aliveMinionsFilter;
		public ComponentDataArray<MinionData> minions;
		[ReadOnly]
		public ComponentDataArray<UnitTransformData> transforms;
		[ReadOnly]
		public ComponentDataArray<MinionAttackData> attackData;
		public EntityArray entities;

		public readonly int Length;
	}
	
	[Inject]
	private Minions minions;

	protected override JobHandle OnUpdate(JobHandle inputDeps)
	{
		if (minions.Length == 0) return inputDeps;

		var attackTargetJob = new AttackTargetJob
		{
			minions = minions.minions,
			minionTransforms = minions.transforms,
			dt = Time.deltaTime,
			AttackCommands = CommandSystem.AttackCommandsConcurrent,
			minionAttacks = minions.attackData,
			entities = minions.entities
		};

		var attackJobFence = attackTargetJob.Schedule(minions.Length, SimulationState.SmallBatchSize, JobHandle.CombineDependencies(inputDeps, CommandSystem.AttackCommandsFence));
		CommandSystem.AttackCommandsConcurrentFence = JobHandle.CombineDependencies(attackJobFence, CommandSystem.AttackCommandsConcurrentFence);

		return attackJobFence;
	}
}
