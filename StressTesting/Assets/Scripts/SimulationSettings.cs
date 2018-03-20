using System;
using System.Collections.Generic;
using System.IO;
using UnityEditor;
using UnityEngine;

public class SimulationSettings : ScriptableObject
{
	[Serializable]
	public class FormationTypeAudioClip
	{
		public UnitType UnitType;
		public AudioClip MovingClip;
		public AudioClip FightingClip;
	}

	public const string FolderPath = "Assets/Walking/Resources";

	private static SimulationSettings instance;

	public static SimulationSettings Instance
	{
		get
		{
			if (instance == null)
			{
				instance = Resources.Load<SimulationSettings>(typeof(SimulationSettings).Name);

#if UNITY_EDITOR
				if (instance == null)
				{
					SimulationSettings asset = CreateInstance<SimulationSettings>();
					AssetDatabase.CreateAsset(asset, Path.Combine(FolderPath, typeof(SimulationSettings).Name + ".asset"));
					AssetDatabase.SaveAssets();
				}
#endif
			}

			return instance;
		}
	}

	public int UnitsPerFormation = 1024;
	public int FormationWidth = 64;
	public int IfBurstIsNotSupportedSpawnFormationsDividedBy = 5;

	public float MinionSpeed = 2;
	public float BlastRadius = 10f;

	public float ArcherHitTime = 1.7f;

	public GameObject FormationAudioSource;
	public List<FormationTypeAudioClip> FormationClips;
	public bool EnableSpawners = false;
	public System.Collections.Generic.List<float> SpawnTimesPerUnit;

	//public bool AutoMoveFormaiton;
	public int FormationUpdateFrequency = 20;

	public float ArcherAttackTime = 7;
	public float TimeToSpawnBatch = 3f;

	public static int countPerSpawner = 4;
	public float MinionScaleMin = 0.8f;
	public float MinionScaleMax = 1.2f;

	public float MinionAnimationSpeedMin = 0.8f;
	public float MinionAnimationSpeedMax = 1.2f;

	public float MinionHeightOffsetMin = 0.1f;
	public float MinionHeightOffsetMax = 0.3f;

	public bool DisableRendering = false;

	// I had to decouple spell settings data from prefab
	// This is used as dictionary where spell type is key
	public List<SpellSystem.SpellSettings> SpellSettings;
}
