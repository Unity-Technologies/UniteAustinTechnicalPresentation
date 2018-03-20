using Unity.Entities;

public struct AttackCommand
{
	public Entity AttackerEntity;
	public Entity DefenderEntity;

	public int Damage;

	public AttackCommand(Entity attackerEntity, Entity defenderEntity, int damage)
	{
		Damage = damage;
		AttackerEntity = attackerEntity;
		DefenderEntity = defenderEntity;
	}
}