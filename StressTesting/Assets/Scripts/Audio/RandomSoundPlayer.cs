using System.Collections.Generic;
using UnityEngine;

public class RandomSoundPlayer : MonoBehaviour
{
	[Tooltip("One of these sound clips will be played through the AudioSource component on this game object")]
	public List<AudioClip> Clips;

	private AudioSource audioSource;
	
	private void Start()
	{
		audioSource = GetComponent<AudioSource>();
		audioSource.enabled = false;
	}

	public void PlaySound()
	{
		if (audioSource == null || Clips == null || Clips.Count == 0)
			return;

		audioSource.enabled = true;

		var clipToPlay = Random.Range(0, Clips.Count);
		audioSource.PlayOneShot(Clips[clipToPlay]);
		GameManager.Instance.RegisterAudioSource(audioSource);
	}

	public void OnDestroy()
	{
		GameManager.Instance.UnregisterAudioSource(audioSource);
	}
}
