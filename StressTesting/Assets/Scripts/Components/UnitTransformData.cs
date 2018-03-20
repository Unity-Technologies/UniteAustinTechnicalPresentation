using Unity.Mathematics;
using Unity.Entities;

[System.Serializable]
public struct UnitTransformData : IComponentData
{
	public float3 Position;
	public float3 Forward;
	public Entity FormationEntity;
	public int UnitType;
	public float Scale;
	public float HeightOffset;

	public UnitTransformData(float3 position, float3 forward)
	{
		Position = position;
		Forward = forward;
		UnitType = 0;
		FormationEntity = new Entity(); // null entity
		Scale = 1;
		HeightOffset = 0f;
	}
}

public struct IndexInFormationData : IComponentData
{
	public int IndexInFormation;

	public IndexInFormationData(int index)
	{
		IndexInFormation = index;
	}
}