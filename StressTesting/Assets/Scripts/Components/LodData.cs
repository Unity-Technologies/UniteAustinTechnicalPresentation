using System;
using UnityEngine;

[Serializable]
public struct LodData
{
	public Mesh Lod1Mesh;
	public Mesh Lod2Mesh;
	public Mesh Lod3Mesh;

	public float Lod1Distance;
	public float Lod2Distance;
	public float Lod3Distance;

	public float Scale;

	public LodData(Mesh lod1Mesh, Mesh lod2Mesh, Mesh lod3Mesh, float lod1Distance, float lod2Distance, float lod3Distance)
	{
		Lod1Mesh = lod1Mesh;
		Lod2Mesh = lod2Mesh;
		Lod3Mesh = lod3Mesh;
		Lod1Distance = lod1Distance;
		Lod2Distance = lod2Distance;
		Lod3Distance = lod3Distance;
		Scale = 1;
	}
}
