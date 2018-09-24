using Unity.Collections;
using Unity.Jobs;
using Unity.Mathematics;
using UnityEngine;
using Unity.Entities;

[UpdateAfter(typeof(ArrowSystem))]
public class ArrowRenderSystem : JobComponentSystem
{
	public struct Arrows
	{
		public ComponentDataArray<ArrowData> data;
		public readonly int Length;
	}

	[Inject]
	private Arrows arrows;

	private Material arrowMaterial;
	private Mesh arrowMesh;

	private ComputeBuffer argsBuffer;
	private ComputeBuffer objectToWorldBuffer;

	private const int ArrowCapacity = 50000;

	[NativeFixedLength(5)]
	private NativeArray<uint> indirectArgs;
	[NativeFixedLength(ArrowCapacity)]
	private NativeArray<Matrix4x4> transformationMatrices;

	private JobHandle previousFrameHandle;
	public int prevLength = 0;

	protected override void OnDestroyManager()
	{
		base.OnDestroyManager();

		if (argsBuffer != null) argsBuffer.Dispose();
		if (objectToWorldBuffer != null) objectToWorldBuffer.Dispose();

		previousFrameHandle.Complete();
		if (transformationMatrices.IsCreated) transformationMatrices.Dispose();
		if (indirectArgs.IsCreated) indirectArgs.Dispose();
	}

	protected override JobHandle OnUpdate(JobHandle inputDeps)
	{
		if (SimulationSettings.Instance.DisableRendering)
			return inputDeps;

		// Allocate the native array
		if (!indirectArgs.IsCreated) indirectArgs = new NativeArray<uint>(5, Allocator.Persistent);
		if (!transformationMatrices.IsCreated) transformationMatrices = new NativeArray<Matrix4x4>(ArrowCapacity, Allocator.Persistent);

		if ((arrowMaterial == null || arrowMesh == null) && Application.isPlaying)
		{
			var arrowObject = GameObject.Find("Arrow");
			if (arrowObject != null)
			{
				argsBuffer = new ComputeBuffer(1, indirectArgs.Length * sizeof(uint), ComputeBufferType.IndirectArguments);
				objectToWorldBuffer = new ComputeBuffer(ArrowCapacity, 64);

				arrowMesh = arrowObject.GetComponent<MeshFilter>().sharedMesh;
				arrowMaterial = new Material(arrowObject.GetComponent<Renderer>().sharedMaterial);

				
				arrowMaterial.SetFloat("textureCoord", 1);
			}
			else Debug.LogError("Arrow object not found");
		}

		if (arrowMaterial == null || arrowMesh == null) return inputDeps;

		arrowMaterial.SetBuffer("objectToWorldBuffer", objectToWorldBuffer);

		previousFrameHandle.Complete();

		objectToWorldBuffer.SetData(transformationMatrices);
		// Setup the args buffer
		indirectArgs[0] = arrowMesh.GetIndexCount(0);
		indirectArgs[1] = (uint)prevLength;
		argsBuffer.SetData(indirectArgs);

		Graphics.DrawMeshInstancedIndirect(arrowMesh, 0, arrowMaterial, new Bounds(Vector3.zero, 10000000 * Vector3.one), argsBuffer);

		prevLength = arrows.Length;
		var calculateMatricesJob = new CalculateArrowTransformationMatrix
		{
			arrows = arrows.data,
			transformationMatrices = transformationMatrices,
		};

		var calculateMatricesFence = calculateMatricesJob.Schedule(arrows.Length, SimulationState.SmallBatchSize, inputDeps);

		previousFrameHandle = calculateMatricesFence;
		return calculateMatricesFence;
	}

	[Unity.Burst.BurstCompile]
	private struct CalculateArrowTransformationMatrix : IJobParallelFor
	{
		[ReadOnly]
		public ComponentDataArray<ArrowData> arrows;
		[NativeFixedLength(ArrowCapacity)]
		public NativeArray<Matrix4x4> transformationMatrices;

		public void Execute(int index)
		{
			var arrow = arrows[index];

			float3 f = math.normalize(arrow.velocity);
			float3 r = math.cross(f, new float3(0, 1, 0));
			float3 u = math.cross(f, r);
			float3 p = arrow.position;

			// Just add some scale to the projectiles, later remove this

			var transform = new Matrix4x4(	new Vector4(r.x, r.y, r.z, 0),
											new Vector4(u.x, u.y, u.z, 0),
											new Vector4(f.x, f.y, f.z, 0),
											new Vector4(p.x, p.y, p.z, 1f));

			transformationMatrices[index] = transform;
		}
	}
}
