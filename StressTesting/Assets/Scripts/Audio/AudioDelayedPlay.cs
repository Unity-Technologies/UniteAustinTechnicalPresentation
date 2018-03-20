using UnityEngine;

public class AudioDelayedPlay : MonoBehaviour
{
	public float SecondsToDelay;
	private AudioSource audioSource;
	
	private void Start () {
		audioSource = GetComponent<AudioSource>();
		if (audioSource == null) return;

		audioSource.PlayDelayed(SecondsToDelay);
	}
}
