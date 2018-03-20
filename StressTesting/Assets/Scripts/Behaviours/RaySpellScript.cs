using Unity.Mathematics;
using UnityEngine;

public class RaySpellScript : SpellScript
{
	public GameObject Blast;
	public GameObject Ray;

	public override float3 Position
	{
		get
		{
			return Blast.transform.position;
		}
	}

	public override void InitPositions(float3 hitPosition)
	{
		var rayPosition = (float3)Ray.transform.position;
		var defRayDirection = (float3)Blast.transform.position - rayPosition;
		var neededRayDirection = hitPosition - rayPosition;
		var neededBlastDirection = neededRayDirection;
		neededBlastDirection.y = 0;
		Blast.transform.position = hitPosition;
		Blast.transform.rotation = Quaternion.LookRotation(neededBlastDirection) * Quaternion.Euler(0f, 90f, 0f);
		Ray.transform.rotation = Quaternion.LookRotation(neededRayDirection) * Quaternion.Euler(0f, -90f, 0f);
		var scale = math.length(neededRayDirection) / math.length(defRayDirection);
		Ray.transform.localScale = scale * Ray.transform.localScale;
	}

	protected override float2 BlastDirectionModifier
	{
		get
		{
			var res = 2.1f * math.normalize(Blast.transform.position - Ray.transform.position);
			return res.xz;
		}
	}
	
}