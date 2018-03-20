using Unity.Mathematics;
using Unity.Entities;

public struct FormationClosestData : IComponentData
{
	public Entity closestFormation;
	public float3 closestFormationPosition;
}

public class FormationClosestComponent : ComponentDataWrapper<FormationClosestData>
{
	
}