using UnityEngine;

public class AudioParamsRandomizer : MonoBehaviour
{
	private AudioSource audioSource;

	[MinMaxSlider(0f, 1f)]
	public Vector2 VolumeRandomRange = Vector2.one;

	[MinMaxSlider(-3f, 3f)]
	public Vector2 PitchRandomRange = Vector2.one;

	private void Start()
	{
		audioSource = GetComponent<AudioSource>();
		if (audioSource == null) return;

		audioSource.volume = Random.Range(VolumeRandomRange.x, VolumeRandomRange.y);
		audioSource.pitch = Random.Range(PitchRandomRange.x, PitchRandomRange.y);
	}
}
