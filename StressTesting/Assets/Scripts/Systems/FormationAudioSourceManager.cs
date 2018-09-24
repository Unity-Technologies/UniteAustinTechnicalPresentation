using System.Collections.Generic;
using Unity.Collections;
using UnityEngine;
using Unity.Entities;
using Unity.Jobs;

[UpdateAfter(typeof(UnitLifecycleManager))]
public class FormationAudioSourceManager : JobComponentSystem
{
	private class AudioSourceFormation
	{
		public AudioSource AudioSource;
		public Entity FormationEntity;
	}

	private struct FormationDistance
	{
		public float Dist;
		public Entity FormationEntity;
	}

	public struct Formations
	{
		[ReadOnly]
		public ComponentDataArray<FormationData> data;
		[ReadOnly]
		public EntityArray entities;

		public readonly int Length;
	}

	[Inject]
	private Formations formations;

	[Inject]
	private ComponentDataFromEntity<FormationIntegrityData> formationIntegrityDataFromEntity;

	[Inject]
	private ComponentDataFromEntity<FormationData> formationDataFromEntity;

	private const int AudioSourcePoolSize = 6;

	private bool isInitialized;
	private bool isFormationSoundEnabled;

	private List<AudioSourceFormation> audioSources;
	private readonly List<AudioSourceFormation> usedAudioSources = new List<AudioSourceFormation>();
	private float maxDist;

	private readonly List<FormationDistance> closestFormations = new List<FormationDistance>();

	private const string IntroEndedEvent = "INTRO_ENDED";
	private const string OutroStartedEvent = "OUTRO_STARTED";
	private const string OutroEndedEvent = "OUTRO_ENDED";

	private void EnableFormationSounds(string eventName)
	{
		isFormationSoundEnabled = true;
	}

	private void DisableFormationSounds(string eventName)
	{
		isFormationSoundEnabled = false;
		for (var i = usedAudioSources.Count - 1; i >= 0; i--)
		{
			var data = usedAudioSources[i];
			data.AudioSource.Stop();
			usedAudioSources.RemoveAt(i);
			audioSources.Add(data);
		}
	}

	protected override JobHandle OnUpdate(JobHandle inputDeps)
	{
		if (!isInitialized)
		{
			isInitialized = true;
			AudioSystem.SubscribeOnce(IntroEndedEvent, EnableFormationSounds);
			AudioSystem.SubscribeOnce(OutroStartedEvent, DisableFormationSounds);
			AudioSystem.SubscribeOnce(OutroEndedEvent, EnableFormationSounds);
		}

		if (!isFormationSoundEnabled || formations.Length == 0) return inputDeps;

		if (audioSources == null)
		{
			audioSources = new List<AudioSourceFormation>();
			for (var i = 0; i < AudioSourcePoolSize; i++)
			{
				var go = UnityEngine.Object.Instantiate(SimulationSettings.Instance.FormationAudioSource);
				audioSources.Add(new AudioSourceFormation() {AudioSource = go.GetComponent<AudioSource>(), FormationEntity = new Entity()});
			}
			maxDist = audioSources[0].AudioSource.maxDistance;
			maxDist *= maxDist;
		}

		var curCamera = Camera.main;
		if (curCamera == null) return inputDeps;
		var curCameraPos = curCamera.transform.position;

		// Might want to consider jobifying this instead
		inputDeps.Complete();

		closestFormations.Clear();
		for (var i = 0; i < formations.Length; i++)
		{
			var formation = formations.data[i];
			if (formation.FormationState == FormationData.State.AllDead) continue;
			var dist = (curCameraPos - (Vector3)formation.Position).sqrMagnitude;
			if (dist < maxDist) closestFormations.Add(new FormationDistance() {Dist = dist, FormationEntity = formations.entities[i] });
		}

		closestFormations.Sort((fd1, fd2) => (fd1.Dist < fd2.Dist) ? -1 : ((fd1.Dist > fd2.Dist) ? 1 : 0));
		
		for (var i = usedAudioSources.Count - 1; i >= 0; i--)
		{
			var index = -1;
			for (var n = 0; (n < closestFormations.Count) && (n < AudioSourcePoolSize); n++)
			{
				if (closestFormations[n].FormationEntity == usedAudioSources[i].FormationEntity)
				{
					index = n;
					break;
				}
			}
			if (index < 0 || index >= AudioSourcePoolSize)
			{
				var data = usedAudioSources[i];
				data.AudioSource.Stop();
				audioSources.Add(data);
				usedAudioSources.RemoveAt(i);
			}
		}
		
		for (var i = 0; (i < closestFormations.Count) && (i < AudioSourcePoolSize); i++)
		{
			AudioSourceFormation found = null;
			var formationEntity = closestFormations[i].FormationEntity;
			for (var n = 0; n < usedAudioSources.Count; n++)
			{
				if (usedAudioSources[n].FormationEntity == formationEntity)
				{
					found = usedAudioSources[n];
					break;
				}
			}
			bool doPlay = false;
			if (found == null)
			{
				found = audioSources[0];
				audioSources.RemoveAt(0);
				found.FormationEntity = formationEntity;
				usedAudioSources.Add(found);
				doPlay = true;
			}

			if(formationDataFromEntity.Exists(found.FormationEntity))
			{
				var formation =formationDataFromEntity[found.FormationEntity];
				var formationIntegrityData = formationIntegrityDataFromEntity[found.FormationEntity];
				var percent = (float)formationIntegrityData.unitsAttacking / formation.UnitCount;
				var isAttacking = percent > 0.1f;
				
				var clip = GetClipForUnitTypeAndState((UnitType)formation.UnitType, isAttacking);
				if (found.AudioSource.clip != clip) found.AudioSource.clip = clip;

				found.AudioSource.transform.position = formationDataFromEntity[formationEntity].Position;
				if (doPlay) found.AudioSource.Play();
			}
		}
		return new JobHandle();
	}

	private static AudioClip GetClipForUnitTypeAndState(UnitType unitType, bool isAttacking)
	{
		var fclips = SimulationSettings.Instance.FormationClips;
		for (var i = 0; i < fclips.Count; i++)
		{
			if (fclips[i].UnitType == unitType)
			{
				if (isAttacking) return fclips[i].FightingClip;
				return fclips[i].MovingClip;
			}
		}
		return null;
	}
}