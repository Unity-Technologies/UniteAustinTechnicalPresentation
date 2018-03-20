using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ViewSettings : ScriptableObject
{
	public GameObject MeleePrefab;
	public GameObject SkeletonPrefab;

	private static ViewSettings instance;

	public static ViewSettings Instance
	{
		get
		{
			if (instance == null) instance = Resources.Load<ViewSettings>("ViewSettings");
			return instance;
		}
	}
}
