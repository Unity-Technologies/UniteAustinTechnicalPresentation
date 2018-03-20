using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Unity.Entities;

public class RenderingDataWrapper : SharedComponentDataWrapper<RenderingData>
{
	
}

[Serializable]
public struct RenderingData : ISharedComponentData
{
	public UnitType UnitType;
	public GameObject BakingPrefab;
	public Material Material;

	public LodData LodData;
}
