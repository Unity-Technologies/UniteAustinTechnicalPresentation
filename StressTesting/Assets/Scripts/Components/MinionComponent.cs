using System;
using System.Runtime.InteropServices;
using Unity.Collections;
using Unity.Collections.LowLevel.Unsafe;
using Unity.Mathematics;
using Unity.Entities;
using UnityEngine.Experimental.AI;

// The whole structure should only be accessed with pointers!
[StructLayout(LayoutKind.Sequential)]
[Serializable]
public struct MinionData : IComponentData
{
	public int Health;

	// CHECK: Mark fields as readonly?
	public float attackCycle;

	public const float AttackTime = 1;
	public const float HitTime = 0.7f;
}

public struct MinionBitmask : IComponentData
{
	// Bit 0: IsFriendly
	// Bit 1: IsSpawned
	public int bitmask;

	#region Properties

	public bool IsFriendly
	{
		get { return IsBit(0); }
		set { SetBit(0, value); }
	}

	public bool IsSpawned
	{
		get { return IsBit(1); }
		set { SetBit(1, value); }
	}

	#endregion

	public MinionBitmask(bool isFriendly)
	{
		bitmask = 0;

		IsFriendly = isFriendly;
	}

	public MinionBitmask(bool isFriendly, bool spawnedFromPortals)
	{
		bitmask = 0;

		IsFriendly = isFriendly;
		IsSpawned = !spawnedFromPortals;
	}

	public bool IsBit(int bit)
	{
		return (bitmask & (1 << bit)) != 0;
	}

	public void SetBit(int bit, bool value)
	{
		bitmask = value ? (bitmask | (1 << bit)) : (bitmask & ~(1 << bit));
	}
}

public struct MinionPathData : IComponentData
{
	// Bit 0 => Should use path finding
	// Bit 1 => Is Path finding initialized
	// Bit 2 => Is Path found
	public int bitmasks;
	public float3 targetPosition;

	public float3 pathFoundToPosition;

	public int pathSize;
	public int currentCornerIndex;
}


public class MinionComponent : ComponentDataWrapper<MinionData>
{
	
}
