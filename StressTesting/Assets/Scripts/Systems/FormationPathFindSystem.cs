using Unity.Collections;
using Unity.Jobs;
using Unity.Mathematics;
using UnityEngine;
using Unity.Entities;
//using UnityEngine.AI;
//using UnityEngine.Assertions;
using UnityEngine.Experimental.AI;
using UnityEngine.Profiling;

[UpdateAfter(typeof(FormationIntegritySystem))]
public class FormationPathFindSystem : JobComponentSystem
{
    public struct Formations
    {
        public ComponentDataArray<FormationData> data;
        public ComponentDataArray<CrowdAgentNavigator> navigators;
        public ComponentDataArray<FormationIntegrityData> integrityData;

        public int Length;
    }

    public struct Minions
    {
        public ComponentDataArray<MinionTarget> targets;
        public ComponentDataArray<MinionPathData> pathsInfo;
        public FixedArrayArray<float3> paths;
        public ComponentDataArray<NavMeshLocationComponent> navMeshLocation;
        public EntityArray entities;
        public int Length;
    }
    [Inject]
    FixedArrayFromEntity<float3> minionPaths;
    [Inject]
    ComponentDataFromEntity<NavMeshLocationComponent> minionNavMeshLocation;
    [Inject]
    ComponentDataFromEntity<MinionPathData> minionPathsInfo;

    [Inject]
    private Formations formations;

    [Inject]
    private Minions minions;
    
    [Inject]
    private ComponentDataFromEntity<FormationIntegrityData> formationIntegrityData;
    [Inject]
    EntityManager entityManager;

    //private NativeArray<float> costs;

    public const float FarDistance = 15f;
    public const float CloseDistance = 2f;

    private NativeQueue<Entity> newPathQueries;
    private NativeQueue<Entity> completePathQueries;

    public const int MaxNavMeshQueries = 10;
    private const int MaxNavMeshNodes = 2048;
    private NavMeshQuery[] queries;
    private NativeList<int> queryIndexUsed;
    private NativeList<int> queryIndexFree;
    private NativeList<Entity> findingEntities;

    protected override void OnCreateManager()
    {
        base.OnCreateManager();

        //costs = new NativeArray<float>(32, Allocator.Persistent);
        //for (int i = 0; i < 32; i++) costs[i] = 1;

        newPathQueries = new NativeQueue<Entity>(Allocator.Persistent);
        completePathQueries = new NativeQueue<Entity>(Allocator.Persistent);

        var navMeshWorld = NavMeshWorld.GetDefaultWorld();
        queries = new NavMeshQuery[MaxNavMeshQueries];
        queryIndexUsed = new NativeList<int>(MaxNavMeshQueries, Allocator.Persistent);
        queryIndexFree = new NativeList<int>(MaxNavMeshQueries, Allocator.Persistent);
        for (var i = 0; i < MaxNavMeshQueries; ++i)
        {
            queries[i] = new NavMeshQuery(navMeshWorld, Allocator.Persistent, MaxNavMeshNodes);
            queryIndexFree.Add(i);
        }
        findingEntities = new NativeList<Entity>(MaxNavMeshQueries, Allocator.Persistent);
    }

    protected override void OnDestroyManager()
    {
        base.OnDestroyManager();

        //if (costs.IsCreated) costs.Dispose();
        newPathQueries.Dispose();
        completePathQueries.Dispose();
        for (int i = 0; i < MaxNavMeshQueries; ++i)
            queries[i].Dispose();
        queryIndexUsed.Dispose();
        queryIndexFree.Dispose();
        findingEntities.Dispose();
    }

    protected override JobHandle OnUpdate(JobHandle inputDeps)
    {
        if (formations.Length == 0) return inputDeps;

        var assign = new AssignFormationSpeed
        {
            navigators = formations.navigators,
            integrityData = formations.integrityData,
            formations = formations.data
        };

        Profiler.BeginSample("Alloc");
        var pathFollow = new MinionFollowPath
        {
            entities = minions.entities,
            newPathQueries = newPathQueries,
            pathsInfo = minions.pathsInfo,
            minionPaths = minions.paths,
            minionTargets = minions.targets,
            navMeshLocation = minions.navMeshLocation,
            maxPathSize = SimulationState.MaxPathSize
        };
        Entity rmEnt;
        while (completePathQueries.TryDequeue(out rmEnt))
        {
            // TODO: avoid linear search
            for (int i = 0; i < findingEntities.Length; ++i)
            {
                if (findingEntities[i] == rmEnt)
                {
                    findingEntities.RemoveAtSwapBack(i);
                    queryIndexFree.Add(queryIndexUsed[i]);
                    queryIndexUsed.RemoveAtSwapBack(i);
                    break;
                }
            }
        }
        for (int i = 0; i < findingEntities.Length; ++i)
        {
            if (!entityManager.Exists(findingEntities[i]))
            {
                findingEntities.RemoveAtSwapBack(i);
                queryIndexFree.Add(queryIndexUsed[i]);
                queryIndexUsed.RemoveAtSwapBack(i);
                --i;
            }
        }
        // Refill with new path queries
        while (findingEntities.Length < MaxNavMeshQueries && newPathQueries.Count > 0)
        {
            // TODO: should use some kind of round robin to make sure all minions get a chance to path find
            findingEntities.Add(newPathQueries.Dequeue());
            queryIndexUsed.Add(queryIndexFree[queryIndexFree.Length - 1]);
            queryIndexFree.RemoveAtSwapBack(queryIndexFree.Length - 1);
        }

        //Debug.Assert(queryIndexFree.Length + queryIndexUsed.Length == MaxNavMeshQueries);

        var navMeshWorld = NavMeshWorld.GetDefaultWorld();

        newPathQueries.Clear();
        var findHandle = inputDeps;
        for (int i = 0; i < findingEntities.Length; ++i)
        {
            var pathFind = new MinionPathFind
            {
                query = queries[queryIndexUsed[i]],
                entity = findingEntities[i],
                completePathQueries = completePathQueries,

                pathsInfo = minionPathsInfo,
                minionPaths = minionPaths,
                navMeshLocation = minionNavMeshLocation,
                maxPathSize = SimulationState.MaxPathSize,
                //costs = costs,
                polygons = new NativeArray<PolygonId>(100, Allocator.TempJob),
                straightPath = new NativeArray<NavMeshLocation>(SimulationState.MaxPathSize, Allocator.TempJob),
                straightPathFlags = new NativeArray<StraightPathFlags>(SimulationState.MaxPathSize, Allocator.TempJob),
                vertexSide = new NativeArray<float>(SimulationState.MaxPathSize, Allocator.TempJob)
            };
            // TODO: figure out how to run these in parallel, they write to different parts of the same array
            findHandle = pathFind.Schedule(findHandle);
            navMeshWorld.AddDependency(findHandle);
        }
        if (findingEntities.Length > 0)
        {
            navMeshWorld.AddDependency(findHandle);
        }
        Profiler.EndSample();

        var pathFindFence = pathFollow.Schedule(minions.Length, SimulationState.BigBatchSize, findHandle); // prepare targets fence?
        var assignFence = assign.Schedule(formations.Length, SimulationState.BigBatchSize, inputDeps);

        navMeshWorld.AddDependency(pathFindFence);

        return JobHandle.CombineDependencies(assignFence, pathFindFence);
    }

    [ComputeJobOptimization]
    private struct MinionPathFind : IJob
    {
        public NavMeshQuery query;

        // Minion data
        public Entity entity;
        public NativeQueue<Entity> completePathQueries;
        public ComponentDataFromEntity<MinionPathData> pathsInfo;
        public FixedArrayFromEntity<float3> minionPaths;
        public ComponentDataFromEntity<NavMeshLocationComponent> navMeshLocation;

        // Temp data for path finding
        public int maxPathSize;
        [DeallocateOnJobCompletion]
        public NativeArray<PolygonId> polygons;
        [DeallocateOnJobCompletion]
        public NativeArray<NavMeshLocation> straightPath;
        [DeallocateOnJobCompletion]
        public NativeArray<StraightPathFlags> straightPathFlags;

        [DeallocateOnJobCompletion]
        public NativeArray<float> vertexSide;
        
        // Mostly static data for path finding
        // TODO: cannot be read only, should investigate allowing that in the nav mesh apis
        //[ReadOnly]
        //public NativeArray<float> costs;

        public void Execute()
        {
            var pathInfo = pathsInfo[entity];

            // Check bit 1 and 2
            if ((pathInfo.bitmasks & 6) == 0)
            {
                //m_InitFindPath.Begin();
                // We need to do path finding
                var end = query.MapLocation(pathInfo.targetPosition, new Vector3(100, 100, 100), 0);
                query.BeginFindPath(navMeshLocation[entity].NavMeshLocation, end); //, NavMesh.AllAreas, costs);
                pathInfo.bitmasks |= 2;
                //m_InitFindPath.End();

                //Debug.Log("START PATH FINDING");
            }

            // Path searching is initialized, we should update stuff
            //m_UpdatePath.Begin();
            int performed;
            var status = query.UpdateFindPath(10, out performed);
            //m_UpdatePath.End();

            //Debug.Log("UPDATE SLICE " + performed + " " + status);

            if (status.IsSuccess())
            {
                //m_MovePath.Begin();
                int polySize;
                status = query.EndFindPath(out polySize);
                if (status.IsSuccess())
                {
                    query.GetPathResult(polygons);
                    pathInfo.currentCornerIndex = 0;

                    // Update the bitmask: Path finding done & path found
                    pathInfo.bitmasks &= ~2;
                    pathInfo.bitmasks |= 4;
                    completePathQueries.Enqueue(entity);

                    var minionPath = minionPaths[entity];

                    pathInfo.pathSize = 0;

                    var cornerCount = 0;
                    var pathStatus = PathUtils.FindStraightPath(query, navMeshLocation[entity].NavMeshLocation.position,
                                                                pathInfo.targetPosition,
                                                                polygons, polySize,
                                                                ref straightPath, ref straightPathFlags, ref vertexSide,
                                                                ref cornerCount, maxPathSize);

                    if (pathStatus.IsSuccess() && cornerCount > 1 && cornerCount <= maxPathSize)
                    {
                        for (var i = 0; i < cornerCount; i++)
                        {
                            minionPath[i] = straightPath[i].position;
                        }

                        pathInfo.pathFoundToPosition = straightPath[cornerCount - 1].position;
                        pathInfo.pathSize = cornerCount;
                    }

                    //Debug.Log("PATH FINDING DONE " + path.pathSize);
                }

                //m_MovePath.End();
            }

            if (status.IsFailure())
            {
                // Failure happened, reset stuff
                pathInfo.bitmasks &= ~2;
                completePathQueries.Enqueue(entity);
            }
            pathsInfo[entity] = pathInfo;
        }
    }
    [ComputeJobOptimization]
    private struct MinionFollowPath : IJobParallelFor
    {
        [ReadOnly]
        public EntityArray entities;
        public NativeQueue<Entity>.Concurrent newPathQueries;
        public ComponentDataArray<MinionPathData> pathsInfo;
        public FixedArrayArray<float3> minionPaths;
        public ComponentDataArray<MinionTarget> minionTargets;

        public ComponentDataArray<NavMeshLocationComponent> navMeshLocation;

        public int maxPathSize;

        public void Execute(int index)
        {
            var pathInfo = pathsInfo[index];
            var pathDataChanged = false;

            if ((pathInfo.bitmasks & 1) == 1)
            {
                var minionTarget = minionTargets[index];

                if (mathx.lengthSqr(pathInfo.pathFoundToPosition - pathInfo.targetPosition) > FarDistance * FarDistance)
                {
                    pathInfo.bitmasks &= ~4;
                    pathDataChanged = true;
                }

                // Check bit 1 and 2
                if ((pathInfo.bitmasks & 6) == 0)
                {
                    newPathQueries.Enqueue(entities[index]);
                }

                if ((pathInfo.bitmasks & 4) != 0)
                {
                    // The path was previously found. We need to move on it

                    var minionPath = minionPaths[index];

                    if (maxPathSize != 0)
                    {
                        var potentialTarget = minionPath[pathInfo.currentCornerIndex];

                        if (mathx.lengthSqr((float3)navMeshLocation[index].NavMeshLocation.position - potentialTarget) < 0.01f)
                        {
                            // Increase the index if needed
                            if (pathInfo.currentCornerIndex < pathInfo.pathSize)
                            {
                                // Go to next corner
                                potentialTarget = minionPath[++pathInfo.currentCornerIndex];
                                pathDataChanged = true;
                            }
                        }

                        minionTarget.Target = potentialTarget;
                    }
                }

                minionTargets[index] = minionTarget;
            }

            if (pathDataChanged)
            {
                pathsInfo[index] = pathInfo;
            }
        }
    }

    [ComputeJobOptimization]
    private struct AssignFormationSpeed : IJobParallelFor
    {
        [ReadOnly]
        public ComponentDataArray<FormationData> formations;

        public ComponentDataArray<CrowdAgentNavigator> navigators;

        [ReadOnly]
        public ComponentDataArray<FormationIntegrityData> integrityData;

        public void Execute(int index)
        {
            FormationIntegrityData data = integrityData[index];

            var n = navigators[index];
            if (!formations[index].EnableMovement || data.unitsFar + data.unitsClose >= data.unitCount ||
                formations[index].FormationState == FormationData.State.Spawning)
            {
                n.speed = 0f;
            }
            else
            {
                n.speed = math.lerp(1f, 2.1f, 1 - (data.unitsClose / (float)data.unitCount));
            }

            navigators[index] = n;
        }
    }
}
