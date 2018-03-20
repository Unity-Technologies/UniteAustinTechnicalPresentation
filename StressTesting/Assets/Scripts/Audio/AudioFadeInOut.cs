using Unity.Mathematics;
using UnityEngine;

public class AudioFadeInOut : MonoBehaviour
{
	private enum State
	{
		Idle,
		FadingIn,
		FadingOut,
	}

	[Header("Fade In")]
	public float FadeInDuration;
	public float FadeInStartingVolume;

	[Header("Fade Out")]
	public string FadeOutEvent;
	public float FadeOutDuration;
	public float FadeOutEndingVolume;

	private AudioSource audioSource;
	private State state;
	private float fadeInEndingVolume;
	private float fadeOutStartingVolume;
	private float startTime;

	private void Start()
	{
		audioSource = GetComponent<AudioSource>();
		if (audioSource == null) return;

		state = State.FadingIn;
		fadeInEndingVolume = audioSource.volume;
		audioSource.volume = FadeInStartingVolume;
		startTime = Time.time;

		if (string.IsNullOrEmpty(FadeOutEvent)) return;
		AudioSystem.Subscribe(FadeOutEvent, OnFadeOut);
	}

	private void OnDestroy()
	{
		AudioSystem.Unsubscribe(FadeOutEvent, OnFadeOut);
	}

	private void OnFadeOut(string eventName)
	{
		state = State.FadingOut;
		fadeOutStartingVolume = audioSource.volume;
		startTime = Time.time;
	}

	private void Update()
	{
		if (state == State.Idle) return;

		if (state == State.FadingIn)
		{
			var factor = (Time.time - startTime) / FadeInDuration;
			if (factor >= 1f)
			{
				factor = 1f;
				state = State.Idle;
			}
			audioSource.volume = math.lerp(FadeInStartingVolume, fadeInEndingVolume, factor);
		}
		else
		{
			var factor = (Time.time - startTime) / FadeOutDuration;
			if (factor >= 1f)
			{
				factor = 1f;
				state = State.Idle;
				audioSource.Stop();
				return;
			}
			audioSource.volume = math.lerp(fadeOutStartingVolume, FadeOutEndingVolume, factor);
		}
	}
}
