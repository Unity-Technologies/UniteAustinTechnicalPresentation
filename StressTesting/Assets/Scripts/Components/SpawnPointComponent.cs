using UnityEngine;
using System;
using Unity.Mathematics;
using Unity.Entities;

[System.Serializable]
public class SpawnPointComponent : MonoBehaviour
{
	public UnitType Type;
	public bool IsFriendly;

	[NonSerialized]
	public float ElapsedTime;

	[NonSerialized]
	public float3 Position;

	[NonSerialized]
	public float ElapsedTimeSinceLastBatch;

	[NonSerialized]
	public int NumberOfSpawnedUnits;

	[NonSerialized]
	public int SpawnedFormationCount;

	public int minPathIndex = 0;
	public int maxPathIndex = 8;

	public int formationId;
	public Entity formationEntity;

	public float3 offset;
}