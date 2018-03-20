using Unity.Entities;
using Unity.Mathematics;
using UnityEngine.Experimental.AI;

public struct CrowdAgent : IComponentData
{
    public int type;    // NavMeshAgent type
    public float3 worldPosition;
    public float3 velocity;
    public NavMeshLocation location;
}

public class CrowdAgentComponent : ComponentDataWrapper<CrowdAgent> {}
