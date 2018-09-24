using System.Linq;
using Unity.Collections;
using Unity.Jobs;
using Unity.Mathematics;
using UnityEngine;
using UnityEngine.Experimental.AI;
using Unity.Entities;

public partial class CrowdSystem : JobComponentSystem
{
#if DEBUG_CROWDSYSTEM
    public bool drawDebug = false;
    public bool dbgPrintAgentCount = false;
    public bool dbgPrintRequests = false;
    public bool dbgCheckRequests = false;
    int dbgSampleTimespan = 50; //frames
#endif

    struct CrowdGroup
    {
        public ComponentDataArray<CrowdAgent> agents;
        public ComponentDataArray<CrowdAgentNavigator> agentNavigators;
        public FixedArrayArray<PolygonId> paths;
    }

    [Inject]
    CrowdGroup m_Crowd;

    NativeList<byte> m_PlanPathForAgent;
    NativeList<byte> m_EmptyPlanPathForAgent;
    NativeList<uint> m_PathRequestIdForAgent;
    NativeList<PathQueryQueueEcs.RequestEcs> m_PathRequests;
    NativeArray<int> m_PathRequestsRange;
    NativeArray<uint> m_UniqueIdStore;
    NativeArray<int> m_CurrentAgentIndex;

    const int k_MaxQueryNodes = 2000;           // how many NavMesh nodes should the NavMeshQuery allocate space for
    const int k_MaxRequestsPerQuery = 100;      // how many requests should be stored by a query queue
    const int k_QueryCount = 7;                 // how many NavMesh queries can run in parallel - preferably the number of worker threads
    const int k_PathRequestsPerTick = 24;       // how many requests can be added to the query queues per tick
    const int k_MaxQueryIterationsPerTick = 100;// how many NavMesh nodes should the query process per tick
    const int k_AgentsBatchSize = 50;           // how many agents should be processed in one batched job

    NavMeshQuery m_NavMeshQuery;
    PathQueryQueueEcs[] m_QueryQueues;
    bool[] m_IsEmptyQueryQueue;
    UpdateQueriesJob[] m_QueryJobs;
    NativeArray<JobHandle> m_AfterQueriesProcessed;
    JobHandle m_AfterQueriesCleanup;
    JobHandle m_AfterMovedRequestsForgotten;

    int m_InitialCapacity = 10;

    const int k_Start = 0;
    const int k_Count = 1;
    const int k_DataSize = 2;

    protected override void OnCreateManager()
    {
        base.OnCreateManager();

        Initialize(m_InitialCapacity);
    }

    protected override void OnDestroyManager()
    {
        base.OnDestroyManager();

        DisposeEverything();
    }

    void Initialize(int capacity)
    {
        var world = NavMeshWorld.GetDefaultWorld();
        var queryCount = world.IsValid() ? k_QueryCount : 0;

        var agentCount = world.IsValid() ? capacity : 0;
        m_PlanPathForAgent = new NativeList<byte>(agentCount, Allocator.Persistent);
        m_EmptyPlanPathForAgent = new NativeList<byte>(0, Allocator.Persistent);
        m_PathRequestIdForAgent = new NativeList<uint>(agentCount, Allocator.Persistent);
        m_PathRequests = new NativeList<PathQueryQueueEcs.RequestEcs>(k_PathRequestsPerTick, Allocator.Persistent);
        m_PathRequests.ResizeUninitialized(k_PathRequestsPerTick);
        for (var i = 0; i < m_PathRequests.Length; i++)
        {
            m_PathRequests[i] = new PathQueryQueueEcs.RequestEcs { uid = PathQueryQueueEcs.RequestEcs.invalidId };
        }
        m_PathRequestsRange = new NativeArray<int>(k_DataSize, Allocator.Persistent);
        m_PathRequestsRange[k_Start] = 0;
        m_PathRequestsRange[k_Count] = 0;
        m_UniqueIdStore = new NativeArray<uint>(1, Allocator.Persistent);
        m_CurrentAgentIndex = new NativeArray<int>(1, Allocator.Persistent);
        m_CurrentAgentIndex[0] = 0;

        m_NavMeshQuery = new NavMeshQuery(world, Allocator.Persistent);
        m_QueryQueues = new PathQueryQueueEcs[queryCount];
        m_QueryJobs = new UpdateQueriesJob[queryCount];
        m_AfterQueriesProcessed = new NativeArray<JobHandle>(queryCount, Allocator.Persistent);
        m_AfterQueriesCleanup = new JobHandle();
        m_AfterMovedRequestsForgotten = new JobHandle();
        m_IsEmptyQueryQueue = new bool[queryCount];
        for (var i = 0; i < m_QueryQueues.Length; i++)
        {
            m_QueryQueues[i] = new PathQueryQueueEcs(k_MaxQueryNodes, k_MaxRequestsPerQuery);
            m_QueryJobs[i] = new UpdateQueriesJob() { maxIterations = k_MaxQueryIterationsPerTick, queryQueue = m_QueryQueues[i] };
            m_AfterQueriesProcessed[i] = new JobHandle();
            m_IsEmptyQueryQueue[i] = true;
        }
    }

    void DisposeEverything()
    {
        m_AfterMovedRequestsForgotten.Complete();
        m_AfterQueriesCleanup.Complete();
        for (var i = 0; i < m_QueryQueues.Length; i++)
        {
            m_QueryQueues[i].Dispose();
        }
        m_AfterQueriesProcessed.Dispose();
        m_PlanPathForAgent.Dispose();
        m_EmptyPlanPathForAgent.Dispose();
        m_PathRequestIdForAgent.Dispose();
        m_PathRequests.Dispose();
        m_PathRequestsRange.Dispose();
        m_UniqueIdStore.Dispose();
        m_CurrentAgentIndex.Dispose();
        m_NavMeshQuery.Dispose();
    }

    public void OnAddElements(int numberOfAdded)
    {
        //AddAgents(numberOfAdded);
    }

    void AddAgents(int numberOfAdded)
    {
        if (numberOfAdded > 0)
        {
            m_AfterMovedRequestsForgotten.Complete();
            m_AfterQueriesCleanup.Complete();

            AddAgentResources(numberOfAdded);
        }
    }

    public void OnRemoveSwapBack(int index)
    {
        var replacementAgent = m_PlanPathForAgent.Length - 1;

        m_PlanPathForAgent.RemoveAtSwapBack(index);
        m_PathRequestIdForAgent.RemoveAtSwapBack(index);

        m_AfterQueriesCleanup.Complete();
        for (var i = 0; i < m_QueryQueues.Length; i++)
        {
            m_QueryQueues[i].RemoveAgentRecords(index, replacementAgent);
        }

        m_AfterMovedRequestsForgotten.Complete();
        var rangeEnd = m_PathRequestsRange[k_Start] + m_PathRequestsRange[k_Count];
        for (var i = m_PathRequestsRange[k_Start]; i < rangeEnd; i++)
        {
            if (m_PathRequests[i].agentIndex == index)
            {
                if (i < rangeEnd - 1)
                {
                    m_PathRequests[i] = m_PathRequests[rangeEnd - 1];
                    m_PathRequests[rangeEnd - 1] = new PathQueryQueueEcs.RequestEcs { uid = PathQueryQueueEcs.RequestEcs.invalidId };
                }
                rangeEnd--;
                i--;
            }
            else if (m_PathRequests[i].agentIndex == replacementAgent)
            {
                var req = m_PathRequests[i];
                req.agentIndex = index;
                m_PathRequests[i] = req;
            }
        }
        m_PathRequestsRange[k_Count] = rangeEnd - m_PathRequestsRange[k_Start];

#if DEBUG_CROWDSYSTEM_ASSERTS
        Debug.Assert(m_PathRequestsRange[k_Count] >= 0);
#endif
    }

    protected override JobHandle OnUpdate(JobHandle inputDeps)
    {
        //
        // Prepare data on the main thread
        //
        m_AfterQueriesCleanup.Complete();
        m_AfterMovedRequestsForgotten.Complete();

        if (m_QueryQueues.Length < k_QueryCount)
        {
            var world = NavMeshWorld.GetDefaultWorld();
            if (world.IsValid())
            {
                DisposeEverything();
                Initialize(m_InitialCapacity);
            }
        }

        if (m_Crowd.agentNavigators.Length == 0)
            return inputDeps;

        var missingAgents = m_Crowd.agentNavigators.Length - m_PlanPathForAgent.Length;
        if (missingAgents > 0)
        {
            AddAgents(missingAgents);
        }

#if DEBUG_CROWDSYSTEM_ASSERTS
        Debug.Assert(m_Crowd.agents.Length <= m_PathRequestIdForAgent.Length && m_Crowd.agents.Length <= m_PlanPathForAgent.Length,
            "" + m_Crowd.agents.Length + " agents, " + m_PathRequestIdForAgent.Length + " path request IDs, " + m_PlanPathForAgent.Length + " slots for WantsPath");

        if (dbgCheckRequests)
        {
            var rangeEnd = m_PathRequestsRange[k_Start] + m_PathRequestsRange[k_Count];
            for (var i = m_PathRequestsRange[k_Start]; i < rangeEnd; i++)
            {
                Debug.Assert(m_PathRequests[i].uid != PathQueryQueueEcs.RequestEcs.invalidId, "Path request " + i + " should have a valid unique ID");
            }
        }
#endif

#if DEBUG_CROWDSYSTEM
        if (drawDebug)
        {
            DrawDebug();
            DrawRequestsDebug();
        }
#endif

        var requestsPerQueue = int.MaxValue;
        if (m_QueryQueues.Length > 0)
        {
            var existingRequests = m_QueryQueues.Sum(queue => queue.GetRequestCount());
            var requestCount = existingRequests + m_PathRequestsRange[k_Count];
            requestsPerQueue = requestCount / m_QueryQueues.Length;
            if (requestCount % m_QueryQueues.Length != 0 || requestsPerQueue == 0)
                requestsPerQueue += 1;
        }

        for (var i = 0; i < m_QueryQueues.Length; i++)
        {
            m_IsEmptyQueryQueue[i] = m_QueryQueues[i].IsEmpty();
        }

#if DEBUG_CROWDSYSTEM_ASSERTS
        if (dbgCheckRequests)
        {
            for (var i = 0; i < m_PathRequestIdForAgent.Length; i++)
            {
                var requestIdForThisAgent = m_PathRequestIdForAgent[i];
                if (requestIdForThisAgent == PathQueryQueueEcs.RequestEcs.invalidId)
                    continue;

                var existsInQ = false;
                var rangeEnd = m_PathRequestsRange[k_Start] + m_PathRequestsRange[k_Count];
                for (var r = m_PathRequestsRange[k_Start]; r < rangeEnd; r++)
                {
                    var reqInQ = m_PathRequests[r];
                    existsInQ = reqInQ.uid == requestIdForThisAgent;
                    if (existsInQ)
                        break;
                }
                if (!existsInQ)
                {
                    foreach (var query in m_QueryQueues)
                    {
                        existsInQ = query.DbgRequestExistsInQueue(requestIdForThisAgent);
                        if (existsInQ)
                            break;
                    }
                }
                Debug.Assert(existsInQ, "The request for agent " + i + " doesn't exist in any query queue anymore. UID=" + requestIdForThisAgent);
            }
        }
#endif


        //
        // Begin scheduling jobs
        //

        //var pathNeededJob = new CheckPathNeededJob
        //{
        //    agentNavigators = m_Crowd.agentNavigators,
        //    planPathForAgent = m_PlanPathForAgent,
        //    pathRequestIdForAgent = m_PathRequestIdForAgent,
        //    paths = m_AgentPaths.GetReadOnlyData()
        //};
        //var afterPathNeedChecked = pathNeededJob.Schedule(m_Crowd.agents.Length, k_AgentsBatchSize, inputDeps);

        var makeRequestsJob = new MakePathRequestsJob
        {
            query = m_NavMeshQuery,
            agents = m_Crowd.agents,
            agentNavigators = m_Crowd.agentNavigators,
            planPathForAgent = m_EmptyPlanPathForAgent,
            pathRequestIdForAgent = m_PathRequestIdForAgent,
            pathRequests = m_PathRequests,
            pathRequestsRange = m_PathRequestsRange,
            currentAgentIndex = m_CurrentAgentIndex,
            uniqueIdStore = m_UniqueIdStore
        };
        var afterRequestsCreated = makeRequestsJob.Schedule(inputDeps);
        var navMeshWorld = NavMeshWorld.GetDefaultWorld();
        navMeshWorld.AddDependency(afterRequestsCreated);

        var afterRequestsMovedToQueries = afterRequestsCreated;
        if (m_QueryQueues.Length > 0)
        {
            foreach (var queue in m_QueryQueues)
            {
                var enqueuingJob = new EnqueueRequestsInQueriesJob
                {
                    pathRequests = m_PathRequests,
                    pathRequestsRange = m_PathRequestsRange,
                    maxRequestsInQueue = requestsPerQueue,
                    queryQueue = queue
                };
                afterRequestsMovedToQueries = enqueuingJob.Schedule(afterRequestsMovedToQueries);
                navMeshWorld.AddDependency(afterRequestsMovedToQueries);
            }
        }

        var forgetMovedRequestsJob = new ForgetMovedRequestsJob
        {
            pathRequests = m_PathRequests,
            pathRequestsRange = m_PathRequestsRange
        };
        m_AfterMovedRequestsForgotten = forgetMovedRequestsJob.Schedule(afterRequestsMovedToQueries);

        var queriesScheduled = 0;
        for (var i = 0; i < m_QueryJobs.Length; ++i)
        {
            if (m_IsEmptyQueryQueue[i])
                continue;

            m_AfterQueriesProcessed[i] = m_QueryJobs[i].Schedule(afterRequestsMovedToQueries);
            navMeshWorld.AddDependency(m_AfterQueriesProcessed[i]);
            queriesScheduled++;
        }
        var afterQueriesProcessed = queriesScheduled > 0 ? JobHandle.CombineDependencies(m_AfterQueriesProcessed) : afterRequestsMovedToQueries;

        var afterPathsAdded = afterQueriesProcessed;
        foreach (var queue in m_QueryQueues)
        {
            var resultsJob = new ApplyQueryResultsJob { queryQueue = queue, paths = m_Crowd.paths, agentNavigators = m_Crowd.agentNavigators };
            afterPathsAdded = resultsJob.Schedule(afterPathsAdded);
            navMeshWorld.AddDependency(afterPathsAdded);
        }

        var advance = new AdvancePathJob { agents = m_Crowd.agents, agentNavigators = m_Crowd.agentNavigators, paths = m_Crowd.paths };
        var afterPathsTrimmed = advance.Schedule(m_Crowd.agents.Length, k_AgentsBatchSize, afterPathsAdded);

        const int maxCornersPerAgent = 2;
        var totalCornersBuffer = m_Crowd.agents.Length * maxCornersPerAgent;
        var vel = new UpdateVelocityJob
        {
            query = m_NavMeshQuery,
            agents = m_Crowd.agents,
            agentNavigators = m_Crowd.agentNavigators,
            paths = m_Crowd.paths,
            straightPath = new NativeArray<NavMeshLocation>(totalCornersBuffer, Allocator.TempJob),
            straightPathFlags = new NativeArray<StraightPathFlags>(totalCornersBuffer, Allocator.TempJob),
            vertexSide = new NativeArray<float>(totalCornersBuffer, Allocator.TempJob)
        };
        var afterVelocitiesUpdated = vel.Schedule(m_Crowd.agents.Length, k_AgentsBatchSize, afterPathsTrimmed);
        navMeshWorld.AddDependency(afterVelocitiesUpdated);

        var move = new MoveLocationsJob { query = m_NavMeshQuery, agents = m_Crowd.agents, dt = Time.deltaTime };
        var afterAgentsMoved = move.Schedule(m_Crowd.agents.Length, k_AgentsBatchSize, afterVelocitiesUpdated);
        navMeshWorld.AddDependency(afterAgentsMoved);

#if DEBUG_CROWDSYSTEM_LOGS
        if (dbgPrintRequests)
        {
            afterPathsAdded.Complete();
            PrintRequestsDebug();
        }
#endif

        var cleanupFence = afterPathsAdded;
        foreach (var queue in m_QueryQueues)
        {
            var queryCleanupJob = new QueryCleanupJob
            {
                queryQueue = queue,
                pathRequestIdForAgent = m_PathRequestIdForAgent
            };
            cleanupFence = queryCleanupJob.Schedule(cleanupFence);
            m_AfterQueriesCleanup = cleanupFence;
            navMeshWorld.AddDependency(cleanupFence);
        }

        return afterAgentsMoved;
    }

    public void AddAgentResources(int n)
    {
        if (n <= 0)
            return;

        var oldLength = m_PlanPathForAgent.Length;
        m_PlanPathForAgent.ResizeUninitialized(oldLength + n);
        m_PathRequestIdForAgent.ResizeUninitialized(m_PlanPathForAgent.Length);
        for (var i = oldLength; i < m_PlanPathForAgent.Length; i++)
        {
            m_PlanPathForAgent[i] = 0;
            m_PathRequestIdForAgent[i] = PathQueryQueueEcs.RequestEcs.invalidId;
        }
    }

    void DrawDebug()
    {
        var activeAgents = 0;
        for (var i = 0; i < m_Crowd.agents.Length; ++i)
        {
            var agent = m_Crowd.agents[i];
            var agentNavigator = m_Crowd.agentNavigators[i];
            float3 offset = 0.5f * Vector3.up;

            if (agentNavigator.active == 0)
            {
                Debug.DrawRay(agent.worldPosition, 2.0f * Vector3.up, Color.cyan);
                Debug.DrawRay((Vector3)agent.worldPosition + 2.0f * Vector3.up - 0.4f * Vector3.right, 0.8f * Vector3.right, Color.cyan);
                continue;
            }
            activeAgents++;

            //Debug.DrawRay(agent.worldPosition + offset, agent.velocity, Color.cyan);

            if (agentNavigator.pathSize == 0 || m_PlanPathForAgent[i] != 0 || agentNavigator.newDestinationRequested != 0 || m_PathRequestIdForAgent[i] != PathQueryQueueEcs.RequestEcs.invalidId)
            {
                var requestInProcess = m_PathRequestIdForAgent[i] != PathQueryQueueEcs.RequestEcs.invalidId;
                var stateColor = requestInProcess ? Color.yellow : (m_PlanPathForAgent[i] != 0 || agentNavigator.newDestinationRequested != 0 ? Color.magenta : Color.red);
                Debug.DrawRay(agent.worldPosition + offset, 0.5f * Vector3.up, stateColor);
                continue;
            }

            offset = 0.9f * offset;
            float3 pathEndPos = agentNavigator.pathEnd.position;
            Debug.DrawLine(agent.worldPosition + offset, pathEndPos, Color.black);

            if (agentNavigator.destinationInView != 0)
            {
                Debug.DrawLine(agent.worldPosition + offset, agentNavigator.requestedDestination, Color.white);
            }
            else
            {
                Debug.DrawLine(agent.worldPosition + offset, agentNavigator.steeringTarget + offset, Color.white);
                Debug.DrawLine(agentNavigator.steeringTarget + offset, agentNavigator.requestedDestination, Color.gray);
            }
        }

#if DEBUG_CROWDSYSTEM_LOGS
        if (dbgPrintAgentCount && Time.frameCount % dbgSampleTimespan == 0)
        {
            Debug.Log("CS Agents active= " + activeAgents + " / total=" + m_Crowd.agents.Length);
        }
#endif
    }

    void DrawRequestsDebug()
    {
        foreach (var queue in m_QueryQueues)
        {
            NativeArray<PathQueryQueueEcs.RequestEcs> requestQueue;
            PathQueryQueueEcs.RequestEcs inProgress;
            int countWaiting;
            int countDone;
            queue.DbgGetRequests(out requestQueue, out countWaiting, out countDone, out inProgress);

            var hasRequestInProgress = inProgress.uid != PathQueryQueueEcs.RequestEcs.invalidId;
            if (hasRequestInProgress)
            {
                DrawDebugArrow(inProgress.start, inProgress.end, 1.0f, Color.green);
            }

            for (var j = 0; j < countDone + countWaiting; j++)
            {
                if (hasRequestInProgress && j == countDone - 1)
                    continue;

                var isDone = j < countDone;
                var color = isDone ? Color.black : Color.yellow;
                var height = isDone ? 1.3f : 0.7f;
                var req = requestQueue[j];
                DrawDebugArrow(req.start, req.end, height, color);
            }

            var rangeEnd = m_PathRequestsRange[k_Start] + m_PathRequestsRange[k_Count];
            for (var k = m_PathRequestsRange[k_Start]; k < rangeEnd; k++)
            {
                var req = m_PathRequests[k];
                DrawDebugArrow(req.start, req.end, 0.35f, Color.red);
            }
        }
    }

    static void DrawDebugArrow(Vector3 start, Vector3 end, float height, Color color)
    {
        var upCorner = start + height * Vector3.up;
        Debug.DrawLine(upCorner, start, color);
        Debug.DrawLine(upCorner, end, color);
        Debug.DrawLine(start, end, color);
    }

    void PrintRequestsDebug()
    {
        var doneReqStr = "Done req: ";
        var doneReqCount = 0;
        var totalReqNext = 0;
        for (var i = 0; i < m_QueryQueues.Length; i++)
        {
            var queue = m_QueryQueues[i];
            NativeArray<PathQueryQueueEcs.RequestEcs> requestQueue;
            PathQueryQueueEcs.RequestEcs inProgress;
            int countWaiting;
            int countDone;
            queue.DbgGetRequests(out requestQueue, out countWaiting, out countDone, out inProgress);

            doneReqStr += " |_Q" + i + " >>" + inProgress.uid + "[" + inProgress.agentIndex + "]>>";
            for (var j = 0; j < countDone; j++)
            {
                var req = requestQueue[j];
                doneReqStr += " " + "[" + req.agentIndex + "]";
            }
            doneReqCount += countDone;

            if (countWaiting > 0)
            {
                doneReqStr += " <|> ";
                for (var j = countDone; j < countDone + countWaiting; j++)
                {
                    var req = requestQueue[j];
                    doneReqStr += " " + req.uid + "[" + req.agentIndex + "]";
                }
            }
            totalReqNext += countWaiting + inProgress.uid != PathQueryQueueEcs.RequestEcs.invalidId ? 1 : 0;
        }

        //if (doneReqCount > 0)
        {
            m_AfterMovedRequestsForgotten.Complete();

            // Legend: (! new) (. done) (... waiting to be completed)
            Debug.Log(m_PathRequestsRange[k_Count] + "! " + doneReqCount + ". " + totalReqNext + "... " + doneReqStr);
        }
    }
}
