using System;
using System.Collections.Generic;
using UnityEngine;

public class AudioPlayOnEvent : MonoBehaviour
{

	[Serializable]
	public struct AudioEventData
	{
		public string EventName;
		public AudioClip Clip;
		public float Volume;
	}

	public List<AudioEventData> EventSounds;

	private AudioSource audioSource;
	
	private void Start () {
		audioSource = GetComponent<AudioSource>();
		if (audioSource == null || EventSounds == null || EventSounds.Count == 0) return;

		for (var i = 0; i < EventSounds.Count; i++)
		{
			var eventSound = EventSounds[i];
			AudioSystem.Subscribe(eventSound.EventName, PlayEventSound);
		}
	}

	private void OnDestroy()
	{
		if (EventSounds == null || EventSounds.Count == 0) return;
		for (var i = 0; i < EventSounds.Count; i++)
		{
			var eventSound = EventSounds[i];
			AudioSystem.Unsubscribe(eventSound.EventName, PlayEventSound);
		}
	}

	private void PlayEventSound(string eventName)
	{
		for (var i = 0; i < EventSounds.Count; i++)
		{
			var eventSound = EventSounds[i];
			if (eventSound.EventName == eventName)
			{
				audioSource.volume = eventSound.Volume;
				audioSource.clip = eventSound.Clip;
				audioSource.Play();
				break;
			}
		}
	}
}
