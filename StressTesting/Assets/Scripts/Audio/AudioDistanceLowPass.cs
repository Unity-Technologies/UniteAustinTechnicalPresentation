using Unity.Mathematics;
using UnityEngine;

public class AudioDistanceLowPass : MonoBehaviour
{
	private AudioSource audioSource;
	private AudioLowPassFilter lowPassFilter;

	public float FrequencyOnMinDist;
	public float FrequencyOnMaxDist;

	private void Start () {
		lowPassFilter = GetComponent<AudioLowPassFilter>();
		audioSource = GetComponent<AudioSource>();
	}

	private void Update()
	{
		if (lowPassFilter == null || audioSource == null) return;

		var camera = Camera.main;
		if (camera == null) return;

		var distVec = camera.transform.position - transform.position;
		var dist = distVec.magnitude;

		if (dist <= audioSource.minDistance)
		{
			lowPassFilter.cutoffFrequency = FrequencyOnMinDist;
			return;
		}

		if (dist >= audioSource.maxDistance)
		{
			lowPassFilter.cutoffFrequency = FrequencyOnMaxDist;
			return;
		}

		var freq = math.lerp(FrequencyOnMinDist, FrequencyOnMaxDist, (dist - audioSource.minDistance) / audioSource.maxDistance);
		
		lowPassFilter.cutoffFrequency = freq;
	}
}
