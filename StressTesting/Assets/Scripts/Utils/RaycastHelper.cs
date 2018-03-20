using Unity.Mathematics;
using UnityEngine;

public static class RaycastHelper
{
	public static RaycastCommand CreateRaycastCommand(float3 position)
	{
		var positionVector = new Vector3(position.x, position.y, position.z);
		return new RaycastCommand(positionVector + Vector3.up * 500f, Vector3.down, 1000f, FormationSystem.GroundLayermask);
	}
}
