using System.Collections.Generic;
using UnityEngine;

public class AudioStopOnEvent : MonoBehaviour
{
	public List<string> StopOnEvents;

	private AudioSource audioSource;
	
	private void Start () {
		audioSource = GetComponent<AudioSource>();
		if (audioSource == null || StopOnEvents == null || StopOnEvents.Count == 0) return;

		for (var i = 0; i < StopOnEvents.Count; i++)
		{
			AudioSystem.Subscribe(StopOnEvents[i], StopPlayingSound);
		}
	}

	private void OnDestroy()
	{
		if (StopOnEvents == null || StopOnEvents.Count == 0) return;
		for (var i = 0; i < StopOnEvents.Count; i++)
		{
			AudioSystem.Unsubscribe(StopOnEvents[i], StopPlayingSound);
		}
	}

	private void StopPlayingSound(string eventName)
	{
		audioSource.Stop();
	}
}
