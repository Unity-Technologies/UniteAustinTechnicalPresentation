using Unity.Mathematics;
using UnityEngine;

public static class MathUtil
{
	private const float epsilon = 0;

	public static bool Approximately(float a, float b)
	{
		return Mathf.Abs(b - a) < Mathf.Max(0.000001f * Mathf.Max(Mathf.Abs(a), Mathf.Abs(b)), 1.17549435E-38f /* Mathf.Epsilon */ * 8);
	}

	public static float3 RotateTowards(float3 lhs, float3 rhs, float angleMove, float magnitudeMove)
	{
		float lhsMag = math.length(lhs);
		float rhsMag = math.length(rhs);

		if (lhsMag > epsilon && rhsMag > epsilon)
		{
			float3 lhsNorm = lhs / lhsMag;
			float3 rhsNorm = rhs / rhsMag;

			float dot = math.dot(lhsNorm, rhsNorm);

			if (dot > 1.0f - epsilon)
			{
				return MoveTowards(lhs, rhs, magnitudeMove);
			}
			else if (dot < -1.0f + epsilon)
			{
				float3 axis = OrthoNormalVectorFast(lhsNorm);
				float3x3 m;


			}
		}
		return new float3(0, 0, 0);
	}

	public static float3 MoveTowards(float3 lhs, float3 rhs, float clampedDistance)
	{
		float3 delta = rhs - lhs;
		float sqrDelta = mathx.lengthSqr(delta);
		float sqrClampedDistance = clampedDistance * clampedDistance;
		if (sqrDelta > sqrClampedDistance)
		{
			float deltaMag = math.sqrt(sqrDelta);
			if (deltaMag > epsilon) return lhs + delta / deltaMag * clampedDistance;
			else return lhs;
		}
		else return rhs;
	}

	public static float3 OrthoNormalVectorFast(float3 n)
	{
		float3 res;
		if (math.abs(n.z) > 0.707106781186547f)
		{
			float a = n.y * n.y + n.z * n.z;
			float k = 1.0f / math.sqrt(a);
			res.x = 0;
			res.y = -n.z * k;
			res.z = n.y * k;
		}
		else
		{
			float a = n.x * n.x + n.y * n.y;
			float k = 1.0f / math.sqrt(a);
			res.x = -n.y * k;
			res.y = n.x * k;
			res.z = 0;
		}
		return res;
	}
}

namespace Unity.Mathematics
{
	// math extended
	public static partial class mathx
	{
		public static float lengthSqr(float v) { return v * v; }

		public static float lengthSqr(float2 v) { return math.dot(v, v); }

		public static float lengthSqr(float3 v) { return math.dot(v, v); }

		public static float lengthSqr(float4 v) { return math.dot(v, v); }
	}
}
