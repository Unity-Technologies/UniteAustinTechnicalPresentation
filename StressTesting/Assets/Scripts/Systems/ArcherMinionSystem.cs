using Unity.Collections;
using Unity.Jobs;
using UnityEngine;
using Unity.Entities;

[UpdateAfter(typeof(MinionCollisionSystem))]
public class ArcherMinionSystem : JobComponentSystem
{
	public struct RangedMinions
	{
		[ReadOnly]
		public ComponentDataArray<RangedUnitData> rangedMinionsFilter;
		[ReadOnly]
		public ComponentDataArray<AliveMinionData> aliveMinionsFilter;
		public ComponentDataArray<MinionData> minions;
		public ComponentDataArray<UnitTransformData> transforms;
		public ComponentDataArray<MinionBitmask> bitmask;

		public int Length;
	}

	[Inject]
	private RangedMinions rangedMinions;

	[Inject]
	private ComponentDataFromEntity<FormationClosestData> formationClosestDataFromEntity;
	[Inject]
	private ComponentDataFromEntity<FormationData> formationsFromEntity;
	[Inject]
	private UnitLifecycleManager lifeCycleManager;

	private JobHandle archerJobFence;

	public float archerAttackCycle = 0;

	protected override JobHandle OnUpdate(JobHandle inputDeps)
	{
		if (rangedMinions.Length == 0 || !lifeCycleManager.createdArrows.IsCreated) return inputDeps;

		float prevArcherAttackCycle = archerAttackCycle;
		archerAttackCycle += Time.deltaTime;
		if (archerAttackCycle > SimulationSettings.Instance.ArcherAttackTime)
		{
			archerAttackCycle -= SimulationSettings.Instance.ArcherAttackTime;
		}

		var archerJob = new ArcherJob
		{
			createdArrowsQueue = lifeCycleManager.createdArrows.ToConcurrent(),
			archers = rangedMinions.minions,
			transforms = rangedMinions.transforms,
			formations = formationsFromEntity,
			closestFormationsFromEntity = formationClosestDataFromEntity,
			minionConstData = rangedMinions.bitmask,
			randomizer = Time.frameCount,
			archerHitTime = SimulationSettings.Instance.ArcherHitTime,
			archerAttackCycle = archerAttackCycle,
			prevArcherAttackCycle = prevArcherAttackCycle
		};

		archerJobFence = archerJob.Schedule(rangedMinions.Length, SimulationState.SmallBatchSize, inputDeps);

		return archerJobFence;
	}
}
