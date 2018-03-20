using Unity.Entities;
using UnityEngine.Experimental.AI;

public struct NavMeshLocationComponent : IComponentData
{
	public NavMeshLocation NavMeshLocation;

	public NavMeshLocationComponent(NavMeshLocation navMeshLocation)
	{
		NavMeshLocation = navMeshLocation;
	}
}