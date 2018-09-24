using System.Runtime.InteropServices;
using Unity.Mathematics;
using Unity.Entities;

[StructLayout(LayoutKind.Sequential)]
[System.Serializable]
public struct ArrowData : IComponentData
{
	public float3 position;
	public float3 velocity;

	public byte active;
	public int IsFriendly;
}
 
public class ArrowComponent : ComponentDataWrapper<ArrowData>
{

}
