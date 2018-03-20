using Unity.Collections;

public static class NativeArrayExtensions
{
	public static void ResizeNativeArray<T>(ref NativeArray<T> array, int length) where T : struct
	{
		if (array.Length != length)
		{
			if (array.IsCreated) array.Dispose();
			array = new NativeArray<T>(length, Allocator.Persistent);
		}
	}
}