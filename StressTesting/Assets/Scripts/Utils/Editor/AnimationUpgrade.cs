using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEditor;
using UnityEngine;

public static class AnimationUpgrade
{
	public static string[] vectors = new string[]
	{
		"_FadeParams",
		"_Scroll",
		"_SheetParams",
		"_SecondAlphaTiling",
		"_SecondSheetParams",
	};

	[MenuItem("Tools/Upgrade Animation Clips")]
	public static void UpgradeAllAnimationClips()
	{
		var assets = AssetDatabase.GetAllAssetPaths();

		int i = 0;
		foreach (var a in assets)
		{
			i++;
			if (!a.EndsWith(".anim", StringComparison.OrdinalIgnoreCase)) continue;

			if (EditorUtility.DisplayCancelableProgressBar("Updating Animation Clips", a, (float)i / assets.Length))
			{
				break;
			}

			string original = File.ReadAllText(a);
			string file = original;

			foreach (var v in vectors)
			{
				file = file.Replace(v + ".r", v + ".x");
				file = file.Replace(v + ".g", v + ".y");
				file = file.Replace(v + ".b", v + ".z");
				file = file.Replace(v + ".a", v + ".w");
			}

			if (file != original) File.WriteAllText(a, file);
		}

		EditorUtility.ClearProgressBar();
		AssetDatabase.Refresh();
	}
}