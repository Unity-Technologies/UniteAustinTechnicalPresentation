using System.Runtime.InteropServices;
using Unity.Mathematics;
using Unity.Entities;

[System.Serializable]
public struct FormationData : IComponentData
{
	public float3 Position;
	public float3 Forward;
	public float formationSide;

	public int Width;
	public int /* State */ FormationState;
	public int UnitCount;
	public int SpawnedCount;
	public int UnitType;

	// Bit 0	- IsFriendly
	// Bit 1	- EnableMovement
	// Bit 2-3	- HighLevelPathIndex
	// Bit 4	- EnableHighLevelPath
	// Bit 5	- EnableAggro
	public int bitfield;

	public bool IsFriendly
	{
		get { return IsBit(0); }
		set { SetBit(0, value); }
	}

	public bool EnableMovement
	{
		get { return IsBit(1); }
		set { SetBit(1, value); }
	}

	public int HighLevelPathIndex
	{
		get { return (bitfield >> 2) & 3; }
		set { bitfield = (bitfield & ~12) | ((value & 3) << 2); }
	}

	public bool EnableHighLevelPath
	{
		get { return IsBit(4); }
		set { SetBit(4, value); }
	}

	public bool EnableAgro
	{
		get { return IsBit(5); }
		set { SetBit(5, value); }
	}

	public float3 GetOffsetFromCenter(int unitId)
	{
		var formationSpacing = FormationState == State.Attacking ? 0.2f : 1.0f;
		return GetOffsetFromCenter(unitId, ref this, formationSpacing);
	}

	public static float3 GetOffsetFromCenter(int unitId, ref FormationData formation, float radius = 1.0f)
	{
		float3 sideVector = formation.Forward.zyx;
		sideVector.x = -sideVector.x;

		// required to hit the corners correctly
		var sideOffset = sideVector * radius * formation.Width * formation.formationSide * 0.5f;

		var height = math.ceil((float)formation.UnitCount / formation.Width);
		return sideVector * ((unitId % formation.Width) - (formation.Width * 0.5f)) * radius + sideOffset +
							formation.Forward * (unitId / formation.Width - (height * 0.5f)) * radius;
	}

	public FormationData(int count, int width, bool isFriendly, UnitType unitType, float3 initialPosition)
	{
		// By default enabled highlevelpath, agroing and movement
		bitfield = 0 | (1 << 1) | (1 << 4);

		Position = initialPosition;
		Width = width;
		FormationState = State.Walking;
		UnitCount = count;
		Forward = new float3(0, 0, 1);
		formationSide = 0;
		SpawnedCount = 0;
		UnitType = (int)unitType;

		IsFriendly = isFriendly;
		// By default the formation is moving to the final destination
		HighLevelPathIndex = 3;
	}

	public void SetAttack(bool attacking)
	{
		if (FormationState != State.AllDead)
		{
			FormationState = attacking ? State.Attacking : State.Walking;
		}
	}

	public bool IsBit(int bit)
	{
		return (bitfield & (1 << bit)) != 0;
	}

	public void SetBit(int bit, bool value)
	{
		bitfield = value ? (bitfield | (1 << bit)) : (bitfield & ~(1 << bit));
	}

	public struct State
	{
		public const int AllDead = 0;
		public const int Walking = 1;
		public const int Attacking = 2;
		public const int Spawning = 3;
	}
}

public struct FormationNavigationData : IComponentData
{
	public float3 TargetPosition;
	
	public float prevFormationSide;
	public float initialCornerDistance;
}

[StructLayout(LayoutKind.Sequential)]
public struct FormationHighLevelPath : IComponentData
{
	public float3 target0;
	public float3 target1;
	public float3 target2;
	public float3 ultimateDestination;

	public float3 GetTarget(int index)
	{
		if (index == 0) return target0;
		if (index == 1) return target1;
		if (index == 2) return target2;

		return ultimateDestination;

		// Probably isn't working with p2gc
		//fixed (float3* origin = &target0)
		//{
		//	return origin[index];
		//}
	}
}

public struct FormationIntegrityData : IComponentData
{
	public int unitCount;
	public int unitsClose;
	public int unitsFar;
	public int unitsAttacking;
}

// TODO remove this workaround, you should be able to add to formationEntity ComponentType.FixedArray(typeof(Entity))
[InternalBufferCapacity(8)]
public struct EntityRef : IBufferElementData
{
	public Entity entity;

	public EntityRef(Entity entity)
	{
		this.entity = entity;
	}
}

public class FormationComponent : ComponentDataWrapper<FormationData>
{
}
