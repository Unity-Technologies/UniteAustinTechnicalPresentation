using Unity.Mathematics;

public static class Randomizer
{
	private const long multiplier = 0x5DEECE66DL;
	private const long addend = 0xBL;
	private const long mask = (1L << 48) - 1;

	public static int next(int bits, ref long seed)
	{
		long oldseed = seed;
		long nextseed = (oldseed * multiplier + addend) & mask;
		seed = nextseed;
		return (int)(nextseed >> (48 - bits));
	}

	public static int Int(ref long seed)
	{
		return next(32, ref seed);
	}

	public static int Int(int n, ref long seed)
	{
		if (n <= 0)
		{
			n = math.abs(n);
		}

		if ((n & -n) == n) // i.e., n is a power of 2
		{
			return (int)((n * (long)next(31, ref seed)) >> 31);
		}

		int bits,
			val;
		do
		{
			bits = next(31, ref seed);
			val = bits % n;
		}
		while (bits - val + (n - 1) < 0);
		return val;
	}

	public static long Long(ref long seed)
	{
		// it's okay that the bottom word remains signed.
		return ((long)(next(32, ref seed)) << 32) + next(32, ref seed);
	}

	public static float Float(float min, float max, ref long seed)
	{
		return min + (max - min) * (Range(0, 10000000, ref seed) / 10000000.0f);
	}

	public static bool Boolean(ref long seed)
	{
		return next(1, ref seed) != 0;
	}

	public static int Range(int min, int max, ref long seed)
	{
		if (min == max)
		{
			return min;
		}

		return min + Int(max - min, ref seed);
	}
}
