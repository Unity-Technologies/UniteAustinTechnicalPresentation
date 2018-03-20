using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Unity.Entities;

public class TextureAnimatorSystemGui : MonoBehaviour
{
	private TextureAnimatorSystem textureAnimatorSystem;
	private ArrowSystem arrowSystem;

	public bool Enabled = false;

	public void OnGUI()
	{
		if (textureAnimatorSystem == null) textureAnimatorSystem = World.Active.GetExistingManager<TextureAnimatorSystem>();

		int totalUnits = textureAnimatorSystem.lod0Count + textureAnimatorSystem.lod1Count + textureAnimatorSystem.lod2Count + textureAnimatorSystem.lod3Count;
		var oldSize = GUI.skin.label.fontSize;
		GUI.skin.label.fontSize = 28;

		GUILayout.BeginHorizontal();
		GUILayout.Label("FPS: " + fps.ToString("0.00") + "\nUnits: " + totalUnits, GUILayout.Width(300f), GUILayout.Height(800f));
		GUILayout.EndHorizontal();
		GUI.skin.label.fontSize = oldSize;
	}

	#region Field

	[SerializeField]
	private float updateInterval = 0.5f;


	private float bestDeltaTime = 1000f;
	/// <summary>
	/// FPS accumulated over the interval.
	/// </summary>
	private float accumulated = 0f;

	/// <summary>
	/// Frames drawn over the interval.
	/// </summary>
	private int frames = 0;

	/// <summary>
	/// Left time for current interval.
	/// </summary>
	private float timeleft;

	/// <summary>
	/// Current FPS.
	/// </summary>
	private float fps = 15f;

	/// <summary>
	/// A field that keeps realtimeSinceStartup from the previous frame.
	/// </summary>
	private float lastSample;

	#endregion

	#region Properties

	/// <summary>
	/// Current FPS
	/// </summary>
	public float Fps
	{
		get { return fps; }
	}

	/// <summary>
	/// Sets and gets the update interval. Set values are in seconds.
	/// </summary>
	public float UpdateInterval
	{
		get { return updateInterval; }
		set { updateInterval = value; }
	}
	#endregion

	#region Inner classes

	/// <summary>
	/// Arguments for fps updated event.
	/// </summary>

	#endregion

	#region Methods


	public void Start()
	{
		timeleft = updateInterval;
		lastSample = Time.realtimeSinceStartup;
	}

	private float dt;

	public void Update()
	{
		frames++;
		float now = Time.realtimeSinceStartup;
		float delta = (now - lastSample);
		if (delta > 0.001f && delta < bestDeltaTime) bestDeltaTime = delta;
		dt += (now - lastSample);
		lastSample = now;
		if (dt > updateInterval)
		{
			//fps = frames / dt;
			fps = 1f / (bestDeltaTime);
			//if (fps > 60) fps = 60;
			frames = 0;
			bestDeltaTime = 1000f;
			dt -= updateInterval;
		}
	}

	#endregion
}