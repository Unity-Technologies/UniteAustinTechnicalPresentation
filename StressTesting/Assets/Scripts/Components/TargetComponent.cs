using System;
using Unity.Mathematics;
using Unity.Entities;

[Serializable]
public struct MinionTarget : IComponentData
{
	public float3 Target;
	public float speed;
}

public class TargetComponent : ComponentDataWrapper<MinionTarget>
{
}