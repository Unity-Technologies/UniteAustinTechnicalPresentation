using Unity.Entities;

[System.Serializable]
public struct TextureAnimatorData : IComponentData
{
	public float AnimationNormalizedTime;

	public int CurrentAnimationId;
	public int NewAnimationId;

	public int UnitType;

	public float AnimationSpeedVariation;
}