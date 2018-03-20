using Unity.Mathematics;
using Unity.Entities;

[System.Serializable]
public struct RigidbodyData : IComponentData
{
	public float3 Velocity;
	public float3 AngularVelocity;
}

public class RigidbodyComponent : ComponentDataWrapper<RigidbodyData>
{

}
