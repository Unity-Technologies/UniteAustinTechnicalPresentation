using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

public class DynamicSettings : EditorWindow
{
	[MenuItem("Tools/Dynamic Settings")]
	public static void OpenWindow()
	{
		var window = EditorWindow.GetWindow<DynamicSettings>();
		window.Show();
	}

	public bool enableMovement;
	public bool enableAgro;
	public bool enableHighLevelPath;

	public void OnEnable() { }

	public void OnGUI()
	{
		GUILayout.BeginVertical("Box");
		GUILayout.Label("Formations");
		EditorGUI.BeginChangeCheck();
		enableMovement = EditorGUILayout.ToggleLeft("Enable movement", enableMovement);
		enableAgro = EditorGUILayout.ToggleLeft("Aggro", enableAgro);
		enableHighLevelPath = EditorGUILayout.ToggleLeft("High pevel path", enableHighLevelPath);
		if (EditorGUI.EndChangeCheck() && Application.isPlaying) EditorHelperSystem.I.work.Enqueue(UpdateFormations);

		GUILayout.EndVertical();
		GUILayout.BeginVertical("Box");

		if (GUILayout.Button("Kill All"))
		{
			EditorHelperSystem.I.work.Enqueue(KillAll);
		}

		GUILayout.EndVertical();
	}

	public void UpdateFormations()
	{
		var e = EditorHelperSystem.I;

		e.CompleteDependency();

		for (int i = 0; i < e.formations.Length; i++)
		{
			var f = e.formations.data[i];

			f.EnableMovement = enableMovement;
			f.EnableAgro = enableAgro;
			f.EnableHighLevelPath = enableHighLevelPath;

			e.formations.data[i] = f;
		}
	}

	public void KillAll()
	{
		var e = EditorHelperSystem.I;

		e.CompleteDependency();

		for (int i = 0; i < e.minions.Length; i++)
		{
			var d = e.minions.data[i];
			d.Health = 0;
			e.minions.data[i] = d;
		}
	}
}