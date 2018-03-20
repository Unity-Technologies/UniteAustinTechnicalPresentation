using Unity.Mathematics;

public class GeometryUtils
{
    // Calculate the closest point of approach for line-segment vs line-segment.
    public static bool SegmentSegmentCPA(out float3 c0, out float3 c1, float3 p0, float3 p1, float3 q0, float3 q1)
    {
        var u = p1 - p0;
        var v = q1 - q0;
        var w0 = p0 - q0;

        float a = math.dot(u, u);
        float b = math.dot(u, v);
        float c = math.dot(v, v);
        float d = math.dot(u, w0);
        float e = math.dot(v, w0);

        float den = (a * c - b * b);
        float sc, tc;

        if (den == 0)
        {
            sc = 0;
            tc = d / b;

            // todo: handle b = 0 (=> a and/or c is 0)
        }
        else
        {
            sc = (b * e - c * d) / (a * c - b * b);
            tc = (a * e - b * d) / (a * c - b * b);
        }

        c0 = math.lerp(p0, p1, sc);
        c1 = math.lerp(q0, q1, tc);

        return den != 0;
    }
}
