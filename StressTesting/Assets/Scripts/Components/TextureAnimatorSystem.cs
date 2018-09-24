#define USE_SAFE_JOBS

using System;
using System.Collections.Generic;
using System.Threading;
using Unity.Collections;
using Unity.Collections.LowLevel.Unsafe;
using Unity.Jobs;
using Unity.Mathematics;
using Unity.Entities;
using UnityEngine;
using UnityEngine.Profiling;
using UnityEngine.Rendering;

public enum UnitType
{
	Melee = 0,
	Skeleton = 1
}

public struct AnimationName
{
	public const int Attack1 = 0;
	public const int Attack2 = 1;
	public const int AttackRanged = 2;
	public const int Death = 3;
	public const int Falling = 4;
	public const int Idle = 5;
	public const int Walk = 6;
}

[UpdateAfter(typeof(CrowdAgentsToTransformSystem))]
public class TextureAnimatorSystem : JobComponentSystem
{
	private const int NumberOfAnimations = 25;

	public class DataPerUnitType
	{
		public UnitType UnitType;
		public int TotalCount;
		public KeyframeTextureBaker.BakedData BakedData;

		public InstancedSkinningDrawer Drawer;
		public InstancedSkinningDrawer Lod1Drawer;
		public InstancedSkinningDrawer Lod2Drawer;
		public InstancedSkinningDrawer Lod3Drawer;
		public NativeArray<IntPtr> BufferPointers;

		public Material Material;
		public int Count;

		public void Dispose()
		{
			if (Drawer != null) Drawer.Dispose();
			if (Lod1Drawer != null) Lod1Drawer.Dispose();
			if (Lod2Drawer != null) Lod2Drawer.Dispose();
			if (Lod3Drawer != null) Lod3Drawer.Dispose();

			if (BufferPointers.IsCreated) BufferPointers.Dispose();
		}
	}

	public struct AnimationClipDataBaked
	{
		public float TextureOffset;
		public float TextureRange;
		public float OnePixelOffset;
		public int TextureWidth;

		public float AnimationLength;
		public bool1 Looping;
	}

	#region Per unit type tuples

	public struct AllUnits
	{
		public ComponentDataArray<TextureAnimatorData> animationData;
		[ReadOnly]
		public ComponentDataArray<UnitTransformData> transforms;

		public int Length;

	}

	public struct MeleeUnits
	{
		[ReadOnly]
		public ComponentDataArray<MeleeUnitData> meleeUnitFilter;
		public ComponentDataArray<TextureAnimatorData> animationData;
		[ReadOnly]
		public ComponentDataArray<UnitTransformData> transforms;

		public int Length;
	}

	public struct TankUnits
	{
		[ReadOnly]
		public ComponentDataArray<TankUnitData> tankUnitFilter;
		public ComponentDataArray<TextureAnimatorData> animationData;
		[ReadOnly]
		public ComponentDataArray<UnitTransformData> transforms;

		public int Length;
	}


	public struct RangedUnits
	{
		[ReadOnly]
		public ComponentDataArray<RangedUnitData> rangedUnitsSelector;
		public ComponentDataArray<TextureAnimatorData> animationData;
		[ReadOnly]
		public ComponentDataArray<UnitTransformData> transforms;

		public int Length;
	}

	public struct SkeletonUnits
	{
		public ComponentDataArray<SkeletonUnitData> skeletonUnitsSelector;
		public ComponentDataArray<TextureAnimatorData> animationData;
		[ReadOnly]
		public ComponentDataArray<UnitTransformData> transforms;

		public int Length;
	}

	[Inject]
	private AllUnits units;

	[Inject]
	private MeleeUnits meleeUnits;
	[Inject]
	private TankUnits tankUnits;
	[Inject]
	private RangedUnits rangedUnits;
	[Inject]
	private SkeletonUnits skeletonUnits;

	#endregion

	private NativeArray<AnimationClipDataBaked> animationClipData;

	//	[InjectTuples(1)]
	//private ComponentDataArray<TextureAnimatorSystemData> textureAnimatorSystemData;

	public Dictionary<UnitType, DataPerUnitType> perUnitTypeDataHolder;

	public bool initialized = false;

	#region Jobs

	[ComputeJobOptimization]
	struct PrepareAnimatorDataJob : IJobParallelFor
	{
		public ComponentDataArray<TextureAnimatorData> textureAnimatorData;

		[NativeFixedLength(100)]
		[ReadOnly]
		public NativeArray<AnimationClipDataBaked> animationClips;

		public float dt;

		public void Execute(int i)
		{
			// CHECK: We can't modify values inside of a struct directly?
			var animatorData = textureAnimatorData[i];

			if (animatorData.CurrentAnimationId != animatorData.NewAnimationId)
			{
				animatorData.CurrentAnimationId = animatorData.NewAnimationId;
				animatorData.AnimationNormalizedTime = 0f;
			}

			AnimationClipDataBaked clip = animationClips[(int)animatorData.UnitType * 25 + animatorData.CurrentAnimationId];
			float normalizedTime = textureAnimatorData[i].AnimationNormalizedTime + dt / clip.AnimationLength;
			if (normalizedTime > 1.0f)
			{
				if (clip.Looping) normalizedTime = normalizedTime % 1.0f;
				else normalizedTime = 1f;
			}

			animatorData.AnimationNormalizedTime = normalizedTime;

			textureAnimatorData[i] = animatorData;
		}
	}

#if !USE_SAFE_JOBS
	[ComputeJobOptimization]
	struct CullAndComputeParameters : IJobParallelFor
	{
		[ReadOnly]
		public ComponentDataArray<TextureAnimatorData> textureAnimatorData;

		[ReadOnly]
		public ComponentDataArray<UnitTransformData> unitTransformData;

		[NativeFixedLength(100)]
		[ReadOnly]
		public NativeArray<AnimationClipDataBaked> animationClips;

		[ReadOnly]
		public float dt;

		[ReadOnly]
		public float DistanceMaxLod0;

		[ReadOnly]
		public float DistanceMaxLod1;

		[ReadOnly]
		public float DistanceMaxLod2;

		[ReadOnly]
		public float3 CameraPosition;

		[ReadOnly]
		public IntHolder BufferCounterLod0;

		[ReadOnly]
		public IntHolder BufferCounterLod1;

		[ReadOnly]
		public IntHolder BufferCounterLod2;

		[ReadOnly]
		public IntHolder BufferCounterLod3;

		[ReadOnly]
		public NativeArray<IntPtr> BufferPointers;

		public void Execute(int i)
		{
			var unitTransform = unitTransformData[i];
			float distance = math.length(CameraPosition - unitTransform.Position);

			var animatorData = textureAnimatorData[i];

			AnimationClipDataBaked clip = animationClips[(int)animatorData.UnitType * 25 + animatorData.CurrentAnimationId];
			Quaternion rotation = Quaternion.LookRotation(unitTransform.Forward, new Vector3(0.0f, 1.0f, 0.0f));
			float texturePosition = textureAnimatorData[i].AnimationNormalizedTime * clip.TextureRange + clip.TextureOffset;
			float4 position = new float4(unitTransform.Position, unitTransform.Scale);

			if (distance < DistanceMaxLod0)
			{
				int writeIndex = BufferCounterLod0.Increment();

				//unitPositions[writeIndex] = unitTransform.Position;
				UnsafeUtility.WriteArrayElement(BufferPointers[0], writeIndex, position);

				//unitRotations[writeIndex] = Quaternion.LookRotation(unitTransform.Forward, new Vector3(0.0f, 1.0f, 0.0f) /* Vector3.up */);
				UnsafeUtility.WriteArrayElement(BufferPointers[1], writeIndex, rotation);

				//textureCoordinates[writeIndex] = animationData[i].AnimationNormalizedTime * clip.TextureRange + clip.TextureOffset;
				UnsafeUtility.WriteArrayElement(BufferPointers[2], writeIndex, texturePosition);
			}
			else if (distance < DistanceMaxLod1)
			{
				int writeIndex = BufferCounterLod1.Increment();

				//unitPositions[writeIndex] = unitTransform.Position;
				UnsafeUtility.WriteArrayElement(BufferPointers[3], writeIndex, position);

				//unitRotations[writeIndex] = Quaternion.LookRotation(unitTransform.Forward, new Vector3(0.0f, 1.0f, 0.0f) /* Vector3.up */);
				UnsafeUtility.WriteArrayElement(BufferPointers[4], writeIndex, rotation);

				//textureCoordinates[writeIndex] = animationData[i].AnimationNormalizedTime * clip.TextureRange + clip.TextureOffset;
				UnsafeUtility.WriteArrayElement(BufferPointers[5], writeIndex, texturePosition);
			}
			else if (distance < DistanceMaxLod2)
			{
				int writeIndex = BufferCounterLod2.Increment();

				//unitPositions[writeIndex] = unitTransform.Position;
				UnsafeUtility.WriteArrayElement(BufferPointers[6], writeIndex, position);

				//unitRotations[writeIndex] = Quaternion.LookRotation(unitTransform.Forward, new Vector3(0.0f, 1.0f, 0.0f) /* Vector3.up */);
				UnsafeUtility.WriteArrayElement(BufferPointers[7], writeIndex, rotation);

				//textureCoordinates[writeIndex] = animationData[i].AnimationNormalizedTime * clip.TextureRange + clip.TextureOffset;
				UnsafeUtility.WriteArrayElement(BufferPointers[8], writeIndex, texturePosition);
			}
			else
			{
				int writeIndex = BufferCounterLod3.Increment();

				//unitPositions[writeIndex] = unitTransform.Position;
				UnsafeUtility.WriteArrayElement(BufferPointers[9], writeIndex, position);

				//unitRotations[writeIndex] = Quaternion.LookRotation(unitTransform.Forward, new Vector3(0.0f, 1.0f, 0.0f) /* Vector3.up */);
				UnsafeUtility.WriteArrayElement(BufferPointers[10], writeIndex, rotation);

				//textureCoordinates[writeIndex] = animationData[i].AnimationNormalizedTime * clip.TextureRange + clip.TextureOffset;
				UnsafeUtility.WriteArrayElement(BufferPointers[11], writeIndex, texturePosition);
			}
		}
	}
#endif

#if USE_SAFE_JOBS
	[ComputeJobOptimization]
	struct CullAndComputeParametersSafe : IJob
	{
		[ReadOnly]
		public ComponentDataArray<TextureAnimatorData> textureAnimatorData;

		[ReadOnly]
		public ComponentDataArray<UnitTransformData> unitTransformData;

		[NativeFixedLength(100)]
		[ReadOnly]
		public NativeArray<AnimationClipDataBaked> animationClips;

		[ReadOnly]
		public float dt;

		[ReadOnly]
		public float DistanceMaxLod0;

		[ReadOnly]
		public float DistanceMaxLod1;

		[ReadOnly]
		public float DistanceMaxLod2;

		[ReadOnly]
		public float3 CameraPosition;

		public NativeList<float4> Lod0Positions;
		public NativeList<quaternion> Lod0Rotations;
		public NativeList<float3> Lod0TexturePositions;

		public NativeList<float4> Lod1Positions;
		public NativeList<quaternion> Lod1Rotations;
		public NativeList<float3> Lod1TexturePositions;

		public NativeList<float4> Lod2Positions;
		public NativeList<quaternion> Lod2Rotations;
		public NativeList<float3> Lod2TexturePositions;

		public NativeList<float4> Lod3Positions;
		public NativeList<quaternion> Lod3Rotations;
		public NativeList<float3> Lod3TexturePositions;

		public void Execute()
		{
			for (int i = 0; i < unitTransformData.Length; i++)
			{
				var unitTransform = unitTransformData[i];
				float distance = math.length(CameraPosition - unitTransform.Position);

				var animatorData = textureAnimatorData[i];

				AnimationClipDataBaked clip = animationClips[(int)animatorData.UnitType * 25 + animatorData.CurrentAnimationId];
				Quaternion rotation = Quaternion.LookRotation(unitTransform.Forward, new Vector3(0.0f, 1.0f, 0.0f));
				float texturePosition = textureAnimatorData[i].AnimationNormalizedTime * clip.TextureRange + clip.TextureOffset;
				int lowerPixelInt = (int)math.floor(texturePosition * clip.TextureWidth);
				//float lowerPixelCenter = (lowerPixelInt + 0.5f) / clip.TextureWidth;
				//float upperPixelCenter = lowerPixelCenter + clip.OnePixelOffset;

				float lowerPixelCenter = (lowerPixelInt * 1.0f) / clip.TextureWidth;
				float upperPixelCenter = lowerPixelCenter + clip.OnePixelOffset;
				float lerpFactor = (texturePosition - lowerPixelCenter) / clip.OnePixelOffset;
				float3 texturePositionData = new float3(lowerPixelCenter, upperPixelCenter, lerpFactor);
				//float3 texturePositionData = new float3(texturePosition, 0, -1);

				float4 position = new float4(unitTransform.Position, unitTransform.Scale);

				if (distance < DistanceMaxLod0)
				{
					Lod0Positions.Add(position);
					Lod0Rotations.Add(rotation);
					Lod0TexturePositions.Add(texturePositionData);
				}
				else if (distance < DistanceMaxLod1)
				{
					Lod1Positions.Add(position);
					Lod1Rotations.Add(rotation);
					Lod1TexturePositions.Add(texturePositionData);
				}
				else if (distance < DistanceMaxLod2)
				{
					Lod2Positions.Add(position);
					Lod2Rotations.Add(rotation);
					Lod2TexturePositions.Add(texturePositionData);
				}
				else
				{
					Lod3Positions.Add(position);
					Lod3Rotations.Add(rotation);
					Lod3TexturePositions.Add(texturePositionData);
				}
			}
		}
	}
#endif

	#endregion

	protected override void OnCreateManager()
	{
		base.OnCreateManager();

		// CHECK: Calling Initialize here causes a 100% reproducable crash on play
		//Initialize();
	}

	private void Initialize()
	{
		if (initialized) return;

		animationClipData = new NativeArray<AnimationClipDataBaked>(100, Allocator.Persistent);

		perUnitTypeDataHolder = new Dictionary<UnitType, DataPerUnitType>();
		InstantiatePerUnitTypeData(UnitType.Melee);
		InstantiatePerUnitTypeData(UnitType.Skeleton);

		initialized = true;
	}

	private void InstantiatePerUnitTypeData(UnitType type)
	{
		var minionPrefab = Spawner.GetMinionPrefab(type);
		var renderingData = minionPrefab.GetComponentInChildren<RenderingDataWrapper>().Value;
		var bakingObject = GameObject.Instantiate(renderingData.BakingPrefab);
		SkinnedMeshRenderer renderer = bakingObject.GetComponentInChildren<SkinnedMeshRenderer>();
		Material material = renderingData.Material;
		LodData lodData = renderingData.LodData;

		var dataPerUnitType = new DataPerUnitType
		{
			UnitType = type,
			BakedData = KeyframeTextureBaker.BakeClips(renderer,
														GetAllAnimationClips(renderer.GetComponentInParent<Animation>()), lodData),
			Material = material,
		};
		dataPerUnitType.Drawer = new InstancedSkinningDrawer(dataPerUnitType, dataPerUnitType.BakedData.NewMesh);
		dataPerUnitType.Lod1Drawer = new InstancedSkinningDrawer(dataPerUnitType, dataPerUnitType.BakedData.lods.Lod1Mesh);
		dataPerUnitType.Lod2Drawer = new InstancedSkinningDrawer(dataPerUnitType, dataPerUnitType.BakedData.lods.Lod2Mesh);
		dataPerUnitType.Lod3Drawer = new InstancedSkinningDrawer(dataPerUnitType, dataPerUnitType.BakedData.lods.Lod3Mesh);

#if !USE_SAFE_JOBS
		dataPerUnitType.BufferPointers = new NativeArray<IntPtr>(12, Allocator.Persistent);
		dataPerUnitType.BufferPointers[0] = dataPerUnitType.Drawer.BufferPointers[0];
		dataPerUnitType.BufferPointers[1] = dataPerUnitType.Drawer.BufferPointers[1];
		dataPerUnitType.BufferPointers[2] = dataPerUnitType.Drawer.BufferPointers[2];
		dataPerUnitType.BufferPointers[3] = dataPerUnitType.Lod1Drawer.BufferPointers[0];
		dataPerUnitType.BufferPointers[4] = dataPerUnitType.Lod1Drawer.BufferPointers[1];
		dataPerUnitType.BufferPointers[5] = dataPerUnitType.Lod1Drawer.BufferPointers[2];
		dataPerUnitType.BufferPointers[6] = dataPerUnitType.Lod2Drawer.BufferPointers[0];
		dataPerUnitType.BufferPointers[7] = dataPerUnitType.Lod2Drawer.BufferPointers[1];
		dataPerUnitType.BufferPointers[8] = dataPerUnitType.Lod2Drawer.BufferPointers[2];
		dataPerUnitType.BufferPointers[9] = dataPerUnitType.Lod3Drawer.BufferPointers[0];
		dataPerUnitType.BufferPointers[10] = dataPerUnitType.Lod3Drawer.BufferPointers[1];
		dataPerUnitType.BufferPointers[11] = dataPerUnitType.Lod3Drawer.BufferPointers[2];
#endif

		perUnitTypeDataHolder.Add(type, dataPerUnitType);
		TransferAnimationData(type);
		GameObject.Destroy(bakingObject);
	}

	private void TransferAnimationData(UnitType type)
	{
		var bakedData = perUnitTypeDataHolder[type].BakedData;
		for (int i = 0; i < bakedData.Animations.Count; i++)
		{
			AnimationClipDataBaked data = new AnimationClipDataBaked();
			data.AnimationLength = bakedData.Animations[i].Clip.length;
			GetTextureRangeAndOffset(bakedData, bakedData.Animations[i], out data.TextureRange, out data.TextureOffset, out data.OnePixelOffset, out data.TextureWidth);
			data.Looping = bakedData.Animations[i].Clip.wrapMode == WrapMode.Loop;
			animationClipData[(int)type * 25 + i] = data;
		}
	}

	private AnimationClip[] GetAllAnimationClips(Animation animation)
	{
		List<AnimationClip> animationClips = new List<AnimationClip>();
		foreach (AnimationState state in animation)
		{
			animationClips.Add(state.clip);
		}

		animationClips.Sort((x, y) => String.Compare(x.name, y.name, StringComparison.Ordinal));

		return animationClips.ToArray();
	}

	private void GetTextureRangeAndOffset(KeyframeTextureBaker.BakedData bakedData, KeyframeTextureBaker.AnimationClipData clipData, out float range, out float offset, out float onePixelOffset, out int textureWidth)
	{
		float onePixel = 1f / bakedData.Texture0.width;
		float start = (float)clipData.PixelStart / bakedData.Texture0.width + onePixel * 0.5f;
		float end = (float)clipData.PixelEnd / bakedData.Texture0.width + onePixel * 0.5f;
		onePixelOffset = onePixel;
		textureWidth = bakedData.Texture0.width;
		range = end - start;
		offset = start;
	}

	protected override void OnDestroyManager()
	{
		previousFrameFence.Complete();
		if (perUnitTypeDataHolder != null)
		{
			foreach (var data in perUnitTypeDataHolder) data.Value.Dispose();
		}

		if (animationClipData.IsCreated) animationClipData.Dispose();
		base.OnDestroyManager();
	}

	public int lod0Count,
				lod1Count,
				lod2Count,
				lod3Count;



	private JobHandle previousFrameFence;

	protected override JobHandle OnUpdate(JobHandle inputDeps)
	{
		Initialize();

		if (!initialized) return inputDeps;

		if (SimulationSettings.Instance.DisableRendering)
			return inputDeps;

		float dt = Time.deltaTime;

		if (perUnitTypeDataHolder != null)
		{
			previousFrameFence.Complete();
			previousFrameFence = inputDeps;

			lod0Count = lod1Count = lod2Count = lod3Count = 0;

			foreach (var data in perUnitTypeDataHolder)
			{
				data.Value.Drawer.Draw();
				data.Value.Lod1Drawer.Draw();
				data.Value.Lod2Drawer.Draw();
				data.Value.Lod3Drawer.Draw();

				lod0Count += data.Value.Drawer.UnitToDrawCount;
				lod1Count += data.Value.Lod1Drawer.UnitToDrawCount;
				lod2Count += data.Value.Lod2Drawer.UnitToDrawCount;
				lod3Count += data.Value.Lod3Drawer.UnitToDrawCount;
				data.Value.Count = lod0Count + lod1Count + lod2Count + lod3Count;
			}

			var prepareAnimatorJob = new PrepareAnimatorDataJob()
			{
				animationClips = animationClipData,
				dt = dt,
				textureAnimatorData = units.animationData,
			};

			var prepareAnimatorFence = prepareAnimatorJob.Schedule(units.Length, SimulationState.BigBatchSize, previousFrameFence);

			NativeArray<JobHandle> jobHandles = new NativeArray<JobHandle>(4, Allocator.Temp);
			jobHandles[0] = prepareAnimatorFence;

			foreach (var data in perUnitTypeDataHolder)
			{
				switch (data.Key)
				{
					case UnitType.Melee:
						ComputeFences(meleeUnits.animationData, dt, meleeUnits.transforms, data, prepareAnimatorFence, jobHandles, 0);
						data.Value.Count = meleeUnits.Length;
						break;
					case UnitType.Skeleton:
						ComputeFences(skeletonUnits.animationData, dt, skeletonUnits.transforms, data, prepareAnimatorFence, jobHandles, 3);
						data.Value.Count = skeletonUnits.Length;
						break;
				}
			}

			Profiler.BeginSample("Combine all dependencies");
			previousFrameFence = JobHandle.CombineDependencies(jobHandles);
			Profiler.EndSample();

			jobHandles.Dispose();
			return previousFrameFence;
		}
		return inputDeps;
	}

	private void ComputeFences(ComponentDataArray<TextureAnimatorData> textureAnimatorDataForUnitType, float dt, ComponentDataArray<UnitTransformData> unitTransformDataForUnitType, KeyValuePair<UnitType, DataPerUnitType> data, JobHandle previousFence, NativeArray<JobHandle> jobHandles, int i)
	{
		Profiler.BeginSample("Scheduling");
		// TODO: Replace this with more efficient search.
		Profiler.BeginSample("Create filtering jobs");
		var cameraPosition = Camera.main.transform.position;

#if !USE_SAFE_JOBS
		data.Value.Drawer.BufferCounter.Reset();
		data.Value.Lod1Drawer.BufferCounter.Reset();
		data.Value.Lod2Drawer.BufferCounter.Reset();
		data.Value.Lod3Drawer.BufferCounter.Reset();
		
		var cullAndComputeJob = new CullAndComputeParameters()
		{
			unitTransformData = unitTransformDataForUnitType,
			textureAnimatorData = textureAnimatorDataForUnitType,
			animationClips = animationClipData,
			dt = dt,
			CameraPosition = cameraPosition,
			DistanceMaxLod0 = data.Value.BakedData.lods.Lod1Distance,
			DistanceMaxLod1 = data.Value.BakedData.lods.Lod2Distance,
			DistanceMaxLod2 = data.Value.BakedData.lods.Lod3Distance,
			BufferCounterLod0 = data.Value.Drawer.BufferCounter,
			BufferCounterLod1 = data.Value.Lod1Drawer.BufferCounter,
			BufferCounterLod2 = data.Value.Lod2Drawer.BufferCounter,
			BufferCounterLod3 = data.Value.Lod3Drawer.BufferCounter,
			BufferPointers = data.Value.BufferPointers
		};

		Profiler.EndSample();

		Profiler.BeginSample("Schedule compute jobs");
		var computeShaderJobFence0 = cullAndComputeJob.Schedule(unitTransformDataForUnitType.Length, SimulationState.HumongousBatchSize, previousFence);
		Profiler.EndSample();

		Profiler.BeginSample("Create combined dependency");
		jobHandles[i] = computeShaderJobFence0;
		Profiler.EndSample();

		Profiler.EndSample();
#else
		data.Value.Drawer.ObjectPositions.Clear();
		data.Value.Lod1Drawer.ObjectPositions.Clear();
		data.Value.Lod2Drawer.ObjectPositions.Clear();
		data.Value.Lod3Drawer.ObjectPositions.Clear();

		data.Value.Drawer.ObjectRotations.Clear();
		data.Value.Lod1Drawer.ObjectRotations.Clear();
		data.Value.Lod2Drawer.ObjectRotations.Clear();
		data.Value.Lod3Drawer.ObjectRotations.Clear();

		data.Value.Drawer.TextureCoordinates.Clear();
		data.Value.Lod1Drawer.TextureCoordinates.Clear();
		data.Value.Lod2Drawer.TextureCoordinates.Clear();
		data.Value.Lod3Drawer.TextureCoordinates.Clear();

		var cullAndComputeJob = new CullAndComputeParametersSafe()
		{
			unitTransformData = unitTransformDataForUnitType,
			textureAnimatorData = textureAnimatorDataForUnitType,
			animationClips = animationClipData,
			dt = dt,
			CameraPosition = cameraPosition,
			DistanceMaxLod0 = data.Value.BakedData.lods.Lod1Distance,
			DistanceMaxLod1 = data.Value.BakedData.lods.Lod2Distance,
			DistanceMaxLod2 = data.Value.BakedData.lods.Lod3Distance,
			Lod0Positions = data.Value.Drawer.ObjectPositions,
			Lod0Rotations = data.Value.Drawer.ObjectRotations,
			Lod0TexturePositions = data.Value.Drawer.TextureCoordinates,
			Lod1Positions = data.Value.Lod1Drawer.ObjectPositions,
			Lod1Rotations = data.Value.Lod1Drawer.ObjectRotations,
			Lod1TexturePositions = data.Value.Lod1Drawer.TextureCoordinates,
			Lod2Positions = data.Value.Lod2Drawer.ObjectPositions,
			Lod2Rotations = data.Value.Lod2Drawer.ObjectRotations,
			Lod2TexturePositions = data.Value.Lod2Drawer.TextureCoordinates,
			Lod3Positions = data.Value.Lod3Drawer.ObjectPositions,
			Lod3Rotations = data.Value.Lod3Drawer.ObjectRotations,
			Lod3TexturePositions = data.Value.Lod3Drawer.TextureCoordinates,
		};

		Profiler.EndSample();

		Profiler.BeginSample("Schedule compute jobs");
		var computeShaderJobFence0 = cullAndComputeJob.Schedule(previousFence);
		Profiler.EndSample();

		Profiler.BeginSample("Create combined dependency");
		jobHandles[i] = computeShaderJobFence0;
		Profiler.EndSample();

		Profiler.EndSample();
#endif
	}
}

#if !USE_SAFE_JOBS
[NativeContainer]
public struct IntHolder
{
#if ENABLE_UNITY_COLLECTIONS_CHECKS
	public AtomicSafetyHandle m_Safety;
	public DisposeSentinel m_DisposeSentinel;
#endif

	[NativeContainer]
	public struct HolderData
	{
		public IntPtr InnerData;
	}

	[NativeContainer]
	public struct InnerData
	{
		public int Integer;
	}

	public IntPtr Data;

	public bool IsCreated { get { return Data != IntPtr.Zero; } }

	private Allocator allocator;

	public unsafe IntHolder(Allocator allocator)
	{
		this.allocator = allocator;
		Data = UnsafeUtility.Malloc(sizeof(HolderData), 4, this.allocator);
		((HolderData*)Data)->InnerData = UnsafeUtility.Malloc((ulong)sizeof(InnerData), 4, this.allocator);
		((InnerData*)((HolderData*)Data)->InnerData)->Integer = -1;

#if ENABLE_UNITY_COLLECTIONS_CHECKS
		DisposeSentinel.Create(Data, this.allocator, out m_Safety, out m_DisposeSentinel, 0, Deallocate);
#endif
	}

	public unsafe void Dispose()
	{
#if ENABLE_UNITY_COLLECTIONS_CHECKS
		DisposeSentinel.Dispose(m_Safety, ref m_DisposeSentinel);
#endif

		Deallocate(Data, allocator);
		Data = IntPtr.Zero;
	}

	private static unsafe void Deallocate(IntPtr data, Allocator alloc)
	{
		HolderData* holderData = (HolderData*)data;

		UnsafeUtility.Free(holderData->InnerData, alloc);
		holderData->InnerData = IntPtr.Zero;
		UnsafeUtility.Free(data, alloc);
	}

	public unsafe int Increment()
	{
		HolderData* holderData = (HolderData*)Data;
		InnerData* data = (InnerData*)holderData->InnerData;

		int current,
			next;
		do
		{
			current = data->Integer;
			next = current + 1;
		} while (Interlocked.CompareExchange(ref data->Integer, next, current) != current);

		return next;
	}

	public unsafe int Get()
	{
		HolderData* holderData = (HolderData*)Data;
		InnerData* data = (InnerData*)holderData->InnerData;

		return Interlocked.Exchange(ref data->Integer, data->Integer);
	}

	public unsafe void Reset()
	{
		HolderData* holderData = (HolderData*)Data;
		InnerData* data = (InnerData*)holderData->InnerData;

		Interlocked.Exchange(ref data->Integer, -1);
	}
}
#endif

public class InstancedSkinningDrawer : IDisposable
{
	private const int PreallocatedBufferSize = 32 * 1024;

	private ComputeBuffer argsBuffer;

	private readonly uint[] indirectArgs = new uint[5] { 0, 0, 0, 0, 0 };

	private ComputeBuffer textureCoordinatesBuffer;
	private ComputeBuffer objectRotationsBuffer;
	private ComputeBuffer objectPositionsBuffer;

#if !USE_SAFE_JOBS
	public NativeArray<float> TextureCoordinates;
	public NativeArray<float4> ObjectPositions;
	public NativeArray<quaternion> ObjectRotations;

	public NativeArray<IntPtr> BufferPointers;
	public IntHolder BufferCounter;

#else
	public NativeList<float3> TextureCoordinates;
	public NativeList<float4> ObjectPositions;
	public NativeList<quaternion> ObjectRotations;
#endif



	private Material material;

	private Mesh mesh;

	private TextureAnimatorSystem.DataPerUnitType data;


	public unsafe InstancedSkinningDrawer(TextureAnimatorSystem.DataPerUnitType data, Mesh meshToDraw)
	{
		this.data = data;
		this.mesh = meshToDraw;
		this.material = new Material(data.Material);

		argsBuffer = new ComputeBuffer(1, indirectArgs.Length * sizeof(uint), ComputeBufferType.IndirectArguments);
		indirectArgs[0] = mesh.GetIndexCount(0);
		indirectArgs[1] = (uint)0;
		argsBuffer.SetData(indirectArgs);

		objectRotationsBuffer = new ComputeBuffer(PreallocatedBufferSize, 16);
		objectPositionsBuffer = new ComputeBuffer(PreallocatedBufferSize, 16);
		textureCoordinatesBuffer = new ComputeBuffer(PreallocatedBufferSize, 12);

#if !USE_SAFE_JOBS
		TextureCoordinates = new NativeArray<float3>(PreallocatedBufferSize, Allocator.Persistent);
		ObjectPositions = new NativeArray<float4>(PreallocatedBufferSize, Allocator.Persistent);
		ObjectRotations = new NativeArray<float4>(PreallocatedBufferSize, Allocator.Persistent);
#else
		TextureCoordinates = new NativeList<float3>(PreallocatedBufferSize, Allocator.Persistent);
		ObjectPositions = new NativeList<float4>(PreallocatedBufferSize, Allocator.Persistent);
		ObjectRotations = new NativeList<quaternion>(PreallocatedBufferSize, Allocator.Persistent);
#endif

#if !USE_SAFE_JOBS
		BufferPointers = new NativeArray<IntPtr>(3, Allocator.Persistent);

		BufferPointers[0] = ObjectPositions.GetUnsafeBufferPointerWithoutChecks();
		BufferPointers[1] = ObjectRotations.GetUnsafeBufferPointerWithoutChecks();
		BufferPointers[2] = TextureCoordinates.GetUnsafeBufferPointerWithoutChecks();
		BufferCounter = new IntHolder(Allocator.Persistent);
#endif

		material.SetBuffer("textureCoordinatesBuffer", textureCoordinatesBuffer);
		material.SetBuffer("objectPositionsBuffer", objectPositionsBuffer);
		material.SetBuffer("objectRotationsBuffer", objectRotationsBuffer);
		material.SetTexture("_AnimationTexture0", data.BakedData.Texture0);
		material.SetTexture("_AnimationTexture1", data.BakedData.Texture1);
		material.SetTexture("_AnimationTexture2", data.BakedData.Texture2);

	}

	public void Dispose()
	{
		if (argsBuffer != null) argsBuffer.Dispose();
		if (objectPositionsBuffer != null) objectPositionsBuffer.Dispose();
		if (ObjectPositions.IsCreated) ObjectPositions.Dispose();

		if (objectRotationsBuffer != null) objectRotationsBuffer.Dispose();
		if (ObjectRotations.IsCreated) ObjectRotations.Dispose();

		if (textureCoordinatesBuffer != null) textureCoordinatesBuffer.Dispose();
		if (TextureCoordinates.IsCreated) TextureCoordinates.Dispose();

#if !USE_SAFE_JOBS
		if (BufferCounter.IsCreated) BufferCounter.Dispose();
		if (BufferPointers.IsCreated) BufferPointers.Dispose();
#endif
	}

	public void Draw()
	{
		if (objectRotationsBuffer == null || data.Count == 0) return;

		int count = UnitToDrawCount;
		if (count == 0) return;

		Profiler.BeginSample("Modify compute buffers");

		Profiler.BeginSample("Shader set data");

#if !USE_SAFE_JOBS
		objectPositionsBuffer.SetData(ObjectPositions, 0, 0, count);
		objectRotationsBuffer.SetData(ObjectRotations, 0, 0, count);
		textureCoordinatesBuffer.SetData(TextureCoordinates, 0, 0, count);
#else
		objectPositionsBuffer.SetData((NativeArray<float4>)ObjectPositions, 0, 0, count);
		objectRotationsBuffer.SetData((NativeArray<quaternion>)ObjectRotations, 0, 0, count);
		textureCoordinatesBuffer.SetData((NativeArray<float3>)TextureCoordinates, 0, 0, count);
#endif

		material.SetBuffer("textureCoordinatesBuffer", textureCoordinatesBuffer);
		material.SetBuffer("objectPositionsBuffer", objectPositionsBuffer);
		material.SetBuffer("objectRotationsBuffer", objectRotationsBuffer);
		material.SetTexture("_AnimationTexture0", data.BakedData.Texture0);
		material.SetTexture("_AnimationTexture1", data.BakedData.Texture1);
		material.SetTexture("_AnimationTexture2", data.BakedData.Texture2);
		Profiler.EndSample();

		Profiler.EndSample();

		// CHECK: Systems seem to be called when exiting playmode once things start getting destroyed, such as the mesh here.
		if (mesh == null || material == null) return;

		//indirectArgs[1] = (uint)data.Count;
		indirectArgs[1] = (uint)count;
		argsBuffer.SetData(indirectArgs);

		Graphics.DrawMeshInstancedIndirect(mesh, 0, material, new Bounds(Vector3.zero, 1000000 * Vector3.one), argsBuffer, 0, new MaterialPropertyBlock(), ShadowCastingMode.Off, true);
	}

	public int UnitToDrawCount
	{
		get
		{
#if !USE_SAFE_JOBS
				return BufferCounter.Get() + 1;
#else
			return ObjectPositions.Length;
#endif
		}
	}
}
