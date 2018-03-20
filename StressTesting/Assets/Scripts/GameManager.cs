using System;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;
using UnityEngine.Audio;
using Unity.Entities;
using UnityEngine.Playables;

public class GameManager : MonoBehaviour
{
	private CameraController controller;

	public AudioMixer audiomixer;

	private int numPlayingAudioSources = 0;
	private AudioSource[] playingAudioSources = new AudioSource[1000];

	public static GameManager Instance;
	void Awake()
	{
		Instance = this;
	}

	void Start ()
	{
		// audiomixer.SetFloat("SpellsVolume", -80.0f);
		Application.targetFrameRate = 60;

		InitializeSpells();
	}

	private void InitializeSpells()
	{
		List<SpellScript> spellScripts = new List<SpellScript>();
		var spellSystem = World.Active.GetExistingManager<SpellSystem>();
		/*for (int i = 0; i < 50; i++)
		{
			spellScripts.Add(spellSystem.CastFireball(Vector3.zero).GetComponentInChildren<SpellScript>());
			spellScripts.Add(spellSystem.CastHolyNova(Vector3.zero).GetComponentInChildren<SpellScript>());
			spellScripts.Add(spellSystem.CastLightning(Vector3.zero).GetComponentInChildren<SpellScript>());
			spellScripts.Add(spellSystem.CastMeteor(Vector3.zero).GetComponentInChildren<SpellScript>());
			spellScripts.Add(spellSystem.CastSpikes(Vector3.zero).GetComponentInChildren<SpellScript>());
			spellScripts.Add(spellSystem.CastWings(Vector3.zero).GetComponentInChildren<SpellScript>());
		}

		foreach (var spell in spellScripts)
		{
			spell.Deactivate();
		}*/
	}

	void Update()
	{
		UpdateAudioSources();
	}
	

	public void RegisterAudioSource(AudioSource source)
	{
		for (int n = 0; n < numPlayingAudioSources; n++)
		{
			if (playingAudioSources[n] == source)
				return;
		}
		playingAudioSources[numPlayingAudioSources++] = source;
	}

	public void UnregisterAudioSource(AudioSource source)
	{
		for (int n = 0; n < numPlayingAudioSources; n++)
		{
			if (playingAudioSources[n] == source)
			{
				playingAudioSources[n] = playingAudioSources[--numPlayingAudioSources];
				break;
			}
		}
	}

	public void UpdateAudioSources()
	{
		for (int n = 0; n < numPlayingAudioSources; n++)
		{
			if (!playingAudioSources[n].isPlaying)
			{
				playingAudioSources[n].enabled = false;
				playingAudioSources[n] = playingAudioSources[--numPlayingAudioSources];
				break;
			}
		}
	}
}
