using UnityEngine;

public class AudioMixSnapshotsOnZoom : MonoBehaviour
{
	private AudioSource audioSource;

	private void Start () {
		audioSource = GetComponent<AudioSource>();
		if (audioSource == null) return;
		AudioSystem.Subscribe("ZOOMIN_STARTED", MixSnapshots);
		AudioSystem.Subscribe("ZOOMOUT_STARTED", MixSnapshots);
	}

	private void OnDestroy()
	{
		AudioSystem.Unsubscribe("ZOOMIN_STARTED", MixSnapshots);
		AudioSystem.Unsubscribe("ZOOMOUT_STARTED", MixSnapshots);
	}

	private void MixSnapshots(string eventName)
	{
		if (audioSource == null || audioSource.outputAudioMixerGroup == null) return;
		var mixer = audioSource.outputAudioMixerGroup.audioMixer;
		if (mixer == null) return;

		var zoomedIn = mixer.FindSnapshot("ZoomedIn");
		var zoomedOut = mixer.FindSnapshot("ZoomedOut");

		var zoomOutLevel = AudioSystem.getZoomLevel ();
		var zoomInLevel = 1f - zoomOutLevel;

		if (eventName == "ZOOMIN_STARTED")
		{
			mixer.TransitionToSnapshots(new [] {zoomedIn, zoomedOut}, new [] {zoomInLevel, zoomOutLevel}, 0.5f);
		}
		else
		{
			mixer.TransitionToSnapshots(new[] { zoomedIn, zoomedOut }, new[] {zoomInLevel, zoomOutLevel}, 0.5f);
		}
	}
	
}
