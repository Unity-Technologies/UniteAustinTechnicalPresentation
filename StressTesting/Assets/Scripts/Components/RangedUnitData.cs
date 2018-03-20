using System;
using Unity.Entities;

[Serializable]
public struct RangedUnitData : IComponentData
{
	public const float ArcherAttackRange = 125;
	public const float ArcherAttackRangeSqr = ArcherAttackRange * ArcherAttackRange;

}
