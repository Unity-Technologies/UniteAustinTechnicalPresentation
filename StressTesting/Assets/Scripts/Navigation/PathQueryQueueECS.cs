using Unity.Collections;
using Unity.Entities;
using Unity.Mathematics;
using UnityEngine;
using UnityEngine.Experimental.AI;

public struct PathQueryQueueEcs
{
    public struct RequestEcs
    {
        public Vector3 start;
        public Vector3 end;
        public int agentIndex;
        public int agentType;
        public int mask;
        public uint uid;

        public const uint invalidId = 0;
    }

    struct QueryQueueState
    {
        public int requestCount;
        public int requestIndex;
        public int resultNodesCount;
        public int resultPathsCount;
        public int currentAgentIndex;
        public PathInfo currentPathRequest;
    }

    struct PathInfo
    {
        public int begin;
        public int size;
        public NavMeshLocation start;
        public NavMeshLocation end;
    }

    NavMeshQuery m_Query;
    NativeArray<RequestEcs> m_Requests;
    NativeArray<PolygonId> m_ResultNodes;
    NativeArray<PathInfo> m_ResultRanges;
    NativeArray<int> m_AgentIndices;
    NativeArray<float> m_Costs;
    NativeArray<QueryQueueState> m_State;

    public PathQueryQueueEcs(int nodePoolSize, int maxRequestCount)
    {
        var world = NavMeshWorld.GetDefaultWorld();
        m_Query = new NavMeshQuery(world, Allocator.Persistent, nodePoolSize);
        m_Requests = new NativeArray<RequestEcs>(maxRequestCount, Allocator.Persistent);
        m_ResultNodes = new NativeArray<PolygonId>(2 * nodePoolSize, Allocator.Persistent);
        m_ResultRanges = new NativeArray<PathInfo>(maxRequestCount + 1, Allocator.Persistent);
        m_AgentIndices = new NativeArray<int>(maxRequestCount + 1, Allocator.Persistent);
        m_Costs = new NativeArray<float>(32, Allocator.Persistent);
        for (var i = 0; i < m_Costs.Length; ++i)
            m_Costs[i] = 1.0f;

        m_State = new NativeArray<QueryQueueState>(1, Allocator.Persistent);
        m_State[0] = new QueryQueueState()
        {
            requestCount = 0,
            requestIndex = 0,
            resultNodesCount = 0,
            resultPathsCount = 0,
            currentAgentIndex = -1,
            currentPathRequest = new PathInfo()
        };
    }

    public void Dispose()
    {
        m_Requests.Dispose();
        m_ResultNodes.Dispose();
        m_ResultRanges.Dispose();
        m_AgentIndices.Dispose();
        m_Costs.Dispose();
        m_State.Dispose();
        m_Query.Dispose();
    }

    public bool Enqueue(RequestEcs request)
    {
        var state = m_State[0];
        if (state.requestCount == m_Requests.Length)
            return false;

        m_Requests[state.requestCount] = request;
        state.requestCount++;
        m_State[0] = state;

        return true;
    }

    public int GetRequestCount()
    {
        return m_State[0].requestCount;
    }

    public int GetProcessedRequestsCount()
    {
        return m_State[0].requestIndex;
    }

    public bool IsEmpty()
    {
        var state = m_State[0];
        return state.requestCount == 0 && state.currentAgentIndex < 0;
    }

    public bool HasRequestForAgent(int index)
    {
        var state = m_State[0];
        if (state.currentAgentIndex == index)
            return true;

        for (var i = 0; i < state.requestCount; i++)
        {
            if (m_Requests[state.requestIndex + i].agentIndex == index)
                return true;
        }

        return false;
    }

    public int GetResultPathsCount()
    {
        return m_State[0].resultPathsCount;
    }

    public void CopyResultsTo(ref BufferArray<PolygonIdElement> agentPaths, ref ComponentDataArray<CrowdAgentNavigator> agentNavigators)
    {
        var state = m_State[0];
        for (var i = 0; i < state.resultPathsCount; i++)
        {
            var index = m_AgentIndices[i];
            var resultPathInfo = m_ResultRanges[i];
            var resultNodes = new NativeSlice<PolygonId>(m_ResultNodes, resultPathInfo.begin, resultPathInfo.size);
            var agentPathBuffer = agentPaths[index];

            var pathLength = resultNodes.Length; 
            for (var j = 0; j < pathLength; j++)
            {
                var id = new PolygonIdElement { Value = resultNodes[j] };
                if (j < agentPathBuffer.Length)
                    agentPathBuffer[j] = id;
                else
                    agentPathBuffer.Add(id); //agent path buffer will be set to the largest size ever used... does it make sense to resize to what we're currently using?
            }

            var navigator = agentNavigators[index];
            navigator.pathStart = resultPathInfo.start;
            navigator.pathEnd = resultPathInfo.end;
            navigator.pathSize = pathLength;
            navigator.StartMoving();
            agentNavigators[index] = navigator;
        }
    }

    public void ClearResults()
    {
        var state = m_State[0];
        state.resultNodesCount = 0;
        state.resultPathsCount = 0;
        m_State[0] = state;
    }

    public void RemoveAgentRecords(int index, int replacementAgent)
    {
#if DEBUG_CROWDSYSTEM_ASSERTS
        Debug.Assert(index >= 0);
#endif

        var stateChanged = false;
        var state = m_State[0];
        if (state.currentAgentIndex == index)
        {
            state.currentAgentIndex = -1;
            stateChanged = true;
        }
        else if (state.currentAgentIndex == replacementAgent)
        {
            state.currentAgentIndex = index;
            stateChanged = true;
        }

        // remove results for that agent
        for (var i = 0; i < state.resultPathsCount; i++)
        {
            if (m_AgentIndices[i] == index)
            {
                var backIndex = state.resultPathsCount - 1;
                if (i != backIndex)
                {
                    m_ResultRanges[i] = m_ResultRanges[backIndex];
                    m_AgentIndices[i] = m_AgentIndices[backIndex];
                }
                state.resultPathsCount--;
                stateChanged = true;
                i--; // rewinds i one step back to account for the newly moved item
            }
            else if (m_AgentIndices[i] == replacementAgent)
            {
                m_AgentIndices[i] = index;
            }
        }

        //remove requests in queue for that agent
        for (var q = 0; q < state.requestCount; q++)
        {
            var i = state.requestIndex + q;
            if (m_Requests[i].agentIndex == index)
            {
                var backIndex = state.requestIndex + state.requestCount - 1;
                if (i != backIndex)
                {
                    m_Requests[i] = m_Requests[backIndex];
                }
                state.requestCount--;
                stateChanged = true;
                q--;
            }
            else if (m_Requests[i].agentIndex == replacementAgent)
            {
                var req = m_Requests[i];
                req.agentIndex = index;
                m_Requests[i] = req;
            }
        }

        if (stateChanged)
        {
            m_State[0] = state;
        }
    }

    public void UpdateTimesliced(int maxIter = 100)
    {
        var state = m_State[0];
        while (maxIter > 0 && (state.currentAgentIndex >= 0 || state.requestCount > 0 && state.requestIndex < state.requestCount))
        {
            if (state.currentAgentIndex < 0 && state.requestCount > 0 && state.requestIndex < state.requestCount)
            {
                // Initialize a new query
                var request = m_Requests[state.requestIndex];
                request.uid = RequestEcs.invalidId;
                m_Requests[state.requestIndex] = request;
                state.requestIndex++;
                var startLoc = m_Query.MapLocation(request.start, 10.0f * Vector3.one, 0, request.mask);
                var endLoc = m_Query.MapLocation(request.end, 10.0f * Vector3.one, 0, request.mask);
                if (!m_Query.IsValid(startLoc) || !m_Query.IsValid(endLoc))
                    continue;

                state.currentPathRequest = new PathInfo()
                {
                    begin = 0,
                    size = 0,
                    start = startLoc,
                    end = endLoc
                };

                var status = m_Query.BeginFindPath(startLoc, endLoc, request.mask, m_Costs);
                if (!status.IsFailure())
                {
                    state.currentAgentIndex = request.agentIndex;
                }
            }

            if (state.resultPathsCount >= m_ResultRanges.Length)
                break;

            if (state.currentAgentIndex >= 0)
            {
                // Continue existing query
                int niter;
                var status = m_Query.UpdateFindPath(maxIter, out niter);
                maxIter -= niter;

                if (status.IsSuccess())
                {
                    int npath;
                    status = m_Query.EndFindPath(out npath);
                    if (status.IsSuccess())
                    {
                        var resPolygons = new NativeArray<PolygonId>(npath, Allocator.Temp);
                        var pathInfo = state.currentPathRequest;
                        pathInfo.size = m_Query.GetPathResult(resPolygons);
                        if (pathInfo.size > 0)
                        {
#if DEBUG_CROWDSYSTEM_ASSERTS
                            Debug.Assert(pathInfo.size + state.resultNodesCount <= m_ResultNodes.Length);
#endif

                            pathInfo.begin = state.resultNodesCount;
                            for (var i = 0; i < npath; i++)
                            {
                                m_ResultNodes[state.resultNodesCount] = resPolygons[i];
                                state.resultNodesCount++;
                            }
                            m_ResultRanges[state.resultPathsCount] = pathInfo;
                            m_AgentIndices[state.resultPathsCount] = state.currentAgentIndex;
                            state.resultPathsCount++;
                        }
                        state.currentPathRequest = pathInfo;
                        resPolygons.Dispose();
                    }
                }

                if (!status.IsInProgress())
                {
                    state.currentAgentIndex = -1;
                }
            }
        }

        m_State[0] = state;
    }

    public void CleanupProcessedRequests(ref NativeArray<uint> pathRequestIdForAgent)
    {
        var state = m_State[0];
        if (state.requestIndex > 0)
        {
            for (var i = 0; i < state.requestIndex; i++)
            {
                var req = m_Requests[i];
                if (req.uid == RequestEcs.invalidId || req.uid == pathRequestIdForAgent[req.agentIndex])
                {
                    pathRequestIdForAgent[req.agentIndex] = RequestEcs.invalidId;
                }
            }

            var dst = 0;
            var src = state.requestIndex;
            for (; src < state.requestCount; src++, dst++)
            {
                m_Requests[dst] = m_Requests[src];
            }
            state.requestCount -= state.requestIndex;
            state.requestIndex = 0;

            m_State[0] = state;
        }
    }

    public void DbgGetRequests(out NativeArray<RequestEcs> requestQueue, out int countWaiting, out int countDone, out RequestEcs inProgress)
    {
        requestQueue = m_Requests;
        var state = m_State[0];
        countWaiting = state.requestCount - state.requestIndex;
        countDone = state.requestIndex;
        inProgress = new RequestEcs
        {
            uid = state.currentAgentIndex >= 0 ? uint.MaxValue : RequestEcs.invalidId,
            agentIndex = state.currentAgentIndex,
            start = state.currentPathRequest.start.position,
            end = state.currentPathRequest.end.position
        };
    }

    public bool DbgRequestExistsInQueue(uint requestUid)
    {
        var existsInQ = false;
        var state = m_State[0];
        for (var i = state.requestIndex; i < state.requestCount; ++i)
        {
            existsInQ = (m_Requests[i].uid == requestUid);
            if (existsInQ)
                break;
        }

        return existsInQ;
    }
}
