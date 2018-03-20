
public struct SimulationState
{
	// TODO look at batch sizes, huge batch size == 32
	public const int HumongousBatchSize = 1;
	public const int HugeBatchSize = 2;
	public const int BigBatchSize = 4;
	public const int SmallBatchSize = 8;
	public const int MaxPathSize = 20;
	public const float Gravity = -20;
	public static float Epsilon = 0.00001f;
}
