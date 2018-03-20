using Unity.Mathematics;
using Unity.Entities;

public struct MinionAttackData : IComponentData
{
	public Entity targetEntity;
	public float3 attackPosition;

	public MinionAttackData(Entity targetEntity)
	{
		this.targetEntity = targetEntity;
		attackPosition = new float3();
	}
}
