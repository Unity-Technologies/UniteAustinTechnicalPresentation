using Unity.Collections;
using Unity.Jobs;
using Unity.Mathematics;
using Unity.Entities;

[UpdateAfter(typeof(FormationMaintenanceSystem))]
public class PrepareMinionTargetsSystem : JobComponentSystem
{
    public struct Minions
    {
        public ComponentDataArray<UnitTransformData> transforms;
        public ComponentDataArray<MinionTarget> targets;
        public ComponentDataArray<MinionData> data;
        public ComponentDataArray<MinionBitmask> bitmask;
        public ComponentDataArray<IndexInFormationData> indicesInFormation;
        public ComponentDataArray<MinionPathData> pathInfos;
        public readonly int Length;
    }

    [Inject]
    private Minions minions;

    [Inject]
    private ComponentDataFromEntity<FormationData> formationDataFromEntity;

    protected override JobHandle OnUpdate(JobHandle inputDeps)
    {
        if (minions.Length == 0) return inputDeps;

        var prepareTargetsJob = new PrepareMinonTargets
        {
            formations = formationDataFromEntity,
            transforms = minions.transforms,
            minionTargets = minions.targets,
            minionData = minions.data,
            minionBitmask = minions.bitmask,
            baseMinionSpeed = SimulationSettings.Instance.MinionSpeed,
            pathInfos = minions.pathInfos,
            IndicesInFormation = minions.indicesInFormation
        };

        var PrepareTargetsFence = prepareTargetsJob.Schedule(minions.Length, SimulationState.BigBatchSize,
                                                             inputDeps);

        return PrepareTargetsFence;
    }

    [Unity.Burst.BurstCompile]
    private struct PrepareMinonTargets : IJobParallelFor
    {
        [ReadOnly]
        public ComponentDataFromEntity<FormationData> formations;

        [ReadOnly]
        public ComponentDataArray<UnitTransformData> transforms;

        [ReadOnly]
        public ComponentDataArray<MinionData> minionData;

        public ComponentDataArray<MinionBitmask> minionBitmask;

        public ComponentDataArray<MinionTarget> minionTargets;
        
        public ComponentDataArray<MinionPathData> pathInfos;

        [ReadOnly]
        public ComponentDataArray<IndexInFormationData> IndicesInFormation;

        [ReadOnly]
        public float baseMinionSpeed;

        public void Execute(int index)
        {
            var formation = formations[transforms[index].FormationEntity];
            var minionTarget = minionTargets[index];
            var pathInfo = pathInfos[index];

            var target = transforms[index].Position;

            var unitCanMove = IndicesInFormation[index].IndexInFormation >= formation.UnitCount - formation.SpawnedCount;
            if (unitCanMove)
            {
                target = formation.Position + formation.GetOffsetFromCenter(IndicesInFormation[index].IndexInFormation);

                // Set the flag that the minion is alive
                var bitmask = minionBitmask[index];
                bitmask.IsSpawned = true;
                minionBitmask[index] = bitmask;
            }

            minionTarget.Target = target;
            minionTarget.speed = formation.SpawnedCount == formation.UnitCount ? baseMinionSpeed : baseMinionSpeed * 1.75f;

            var distance = math.length(target - transforms[index].Position);
                
            if (distance < FormationPathFindSystem.FarDistance)
            {
                pathInfo.bitmasks = 0;
                //pathInfo.targetPosition = new float3(100000f, 0, 100000f);
                //pathInfo.pathFoundToPosition = -pathInfo.targetPosition;
            }
            else
            {
                pathInfo.bitmasks |= 1;
                pathInfo.targetPosition = target;
            }
            
            minionTargets[index] = minionTarget;
            pathInfos[index] = pathInfo;
        }
    }
}