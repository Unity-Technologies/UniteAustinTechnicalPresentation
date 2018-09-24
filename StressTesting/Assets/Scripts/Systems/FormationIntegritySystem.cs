using Unity.Collections;
using Unity.Jobs;
using Unity.Mathematics;
using Unity.Entities;

[UpdateAfter(typeof(PrepareMinionTargetsSystem))]
public class FormationIntegritySystem : JobComponentSystem
{
    public struct Formations
    {
        public ComponentDataArray<FormationIntegrityData> integrityData;
        public ComponentDataArray<FormationData> data;
        public BufferArray<EntityRef> unitData;

        public readonly int Length;
    }

    [Inject]
    private Formations formations;

    [Inject]
    public ComponentDataFromEntity<MinionData> minionData;

    [Inject]
    public ComponentDataFromEntity<UnitTransformData> minionTransforms;
    
    [Inject]
    public ComponentDataFromEntity<MinionTarget> minionTargets;

	protected override JobHandle OnUpdate(JobHandle inputDeps)
    {
        if (formations.Length == 0) return inputDeps;

        var calculateIntegrityDataJob = new CalculateIntegrityDataJob
        {
            formationIntegrityData = formations.integrityData,
            formationData = formations.data,
            minionData = minionData,
            transforms = minionTransforms,
            minionTargets = minionTargets,
            formationUnitData = formations.unitData
        };

        var CalculateIntegrityFence = calculateIntegrityDataJob.Schedule(formations.Length, SimulationState.BigBatchSize, inputDeps);

        return CalculateIntegrityFence;
    }

    [ComputeJobOptimization]
    private struct CalculateIntegrityDataJob : IJobParallelFor
    {
        public ComponentDataArray<FormationIntegrityData> formationIntegrityData;

        [ReadOnly]
        public ComponentDataFromEntity<MinionData> minionData;

        [ReadOnly]
        public ComponentDataFromEntity<UnitTransformData> transforms;

        [ReadOnly]
        public ComponentDataFromEntity<MinionTarget> minionTargets;


        [ReadOnly]
        public BufferArray<EntityRef> formationUnitData;
        
        [ReadOnly]
        public ComponentDataArray<FormationData> formationData;
        
        public void Execute(int index)
        {
            var integrityData = new FormationIntegrityData();
            var unitsInFormation = formationUnitData[index];

            for (var i = 0; i < formationData[index].UnitCount; ++i)
            {
                var unitEntity = unitsInFormation[i].entity;

                if (unitEntity == new Entity()) break; // if it's a null entity we reached
                
                var unitTransform = transforms[unitEntity];
                var unitData = minionData[unitEntity];
                var target = minionTargets[unitEntity].Target;

                if (unitData.attackCycle >= 0)
                    ++integrityData.unitsAttacking;
                
                var distance = math.length(target - unitTransform.Position);
                
                if (distance < FormationPathFindSystem.FarDistance)
                {
                    ++integrityData.unitCount;
                    if (distance >= FormationPathFindSystem.CloseDistance)
                        ++integrityData.unitsClose;
                }
                else
                {
                    ++integrityData.unitsFar;
                }
            }

            formationIntegrityData[index] = integrityData;
        }
    }
}