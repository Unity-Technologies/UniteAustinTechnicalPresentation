using Unity.Collections;
using Unity.Jobs;
using Unity.Mathematics;
using Unity.Entities;


[UpdateAfter(typeof(FormationSystem))]
public class FormationMaintenanceSystem : JobComponentSystem
{
	[Inject]
	private FormationSystem.Formations formations;

	[Inject]
	private FixedArrayFromEntity<EntityRef> formationsUnitDataFromEntity;

	[Inject]
	private ComponentDataFromEntity<IndexInFormationData> indicesInFormation;

	public struct Minions
	{
		[ReadOnly]
		public ComponentDataArray<AliveMinionData> aliveMinionsFilter;
		[ReadOnly]
		public ComponentDataArray<UnitTransformData> transforms;
		[ReadOnly]
		public ComponentDataArray<IndexInFormationData> indicesInFormation;

		public EntityArray entities;

		public int Length;
	}
	
	[Inject]
	private Minions minions;
	protected override JobHandle OnUpdate(JobHandle inputDeps)
	{
		if (formations.Length == 0) return inputDeps;

		var cleanUnitsJob = new ClearUnitDataJob
		{
			formations = formations.data, formationUnitData = formations.unitData
		};
		
		var fillUnitJob = new FillUnitDataJob
		{ 
			formationUnitData = formationsUnitDataFromEntity, transforms = minions.transforms, 
			indicesInFormation = minions.indicesInFormation, minionEntities = minions.entities, 
			length = minions.Length
		};
		
		var rearrangeJob = new RearrangeUnitIndexesJob
		{
			formations = formations.data, formationUnitData = formations.unitData, indicesInFormation = indicesInFormation
		};

		var cleanFence = cleanUnitsJob.Schedule(formations.Length, SimulationState.SmallBatchSize, inputDeps);
		var fillFence = fillUnitJob.Schedule(cleanFence);
		var rearrangeFence = rearrangeJob.Schedule(formations.Length, SimulationState.SmallBatchSize, fillFence);

		return rearrangeFence;
	}

	[ComputeJobOptimization]
	private struct ClearUnitDataJob : IJobParallelFor
	{
		[ReadOnly]
		public ComponentDataArray<FormationData> formations;
		public FixedArrayArray<EntityRef> formationUnitData;

		public void Execute(int index)
		{
			var unitData = formationUnitData[index];
			var len = math.max(formations[index].SpawnedCount, formations[index].UnitCount);

			for (var i = 0; i < len; i++)
			{
				unitData[i] = new EntityRef();
			}
		}
	}

	[ComputeJobOptimization]
	private struct FillUnitDataJob : IJob // this can't be parallel job because of FromEntity does not support parallel writing
	{
		public FixedArrayFromEntity<EntityRef> formationUnitData;
		[ReadOnly]
		public ComponentDataArray<UnitTransformData> transforms;
		[ReadOnly]
		public ComponentDataArray<IndexInFormationData> indicesInFormation;
		[ReadOnly]
		public EntityArray minionEntities;

		public int length;

		public void Execute()
		{
			for (var index = 0; index < length; ++index)
			{
				var unitData = formationUnitData[transforms[index].FormationEntity];

				unitData[indicesInFormation[index].IndexInFormation] = new EntityRef(minionEntities[index]);
			}
		}
	}

	[ComputeJobOptimization]
	private struct RearrangeUnitIndexesJob : IJobParallelFor
	{
		[ReadOnly]
		public ComponentDataArray<FormationData> formations;
		public FixedArrayArray<EntityRef> formationUnitData;

		[NativeDisableParallelForRestriction]
		public ComponentDataFromEntity<IndexInFormationData> indicesInFormation;

		public void Execute(int index)
		{
			var len = math.max(formations[index].SpawnedCount, formations[index].UnitCount);

			var unitData = formationUnitData[index];

			for (var i = 0; i < len; i++)
			{
				if (unitData[i].entity != new Entity()) continue;
				
				// Find a suitable index
				int j;
				for (j = i + 1; j < len; j++)
				{
					if (unitData[j].entity == new Entity()) continue;
					
					// We got an index. Replace
					unitData[i] = unitData[j];
					var t = indicesInFormation[unitData[j].entity];
					t.IndexInFormation = i;
					indicesInFormation[unitData[j].entity] = t;

					break;
				}

				// No available indexes till the end
				if (j == len) break;
			}
		}
	}
}
