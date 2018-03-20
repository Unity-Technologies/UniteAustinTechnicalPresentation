using Unity.Collections;
using Unity.Jobs;
using Unity.Entities;
using UnityEngine.Experimental.PlayerLoop;

[UpdateAfter(typeof(EarlyUpdate))]
public class CommandSystem : JobComponentSystem
{
	public static NativeQueue<AttackCommand> AttackCommands;
	public static NativeQueue<AttackCommand>.Concurrent AttackCommandsConcurrent;

	public static JobHandle AttackCommandsFence;
	public static JobHandle AttackCommandsConcurrentFence;

	private const int AttackCommandBufferSize = 10000;

	[Inject]
	private ComponentDataFromEntity<MinionData> minions;


	protected override void OnDestroyManager()
	{
		base.OnDestroyManager();

		if (AttackCommands.IsCreated) AttackCommands.Dispose();
	}

	protected override JobHandle OnUpdate(JobHandle inputDeps)
	{
		if (!AttackCommands.IsCreated)
		{
			AttackCommands = new NativeQueue<AttackCommand>(Allocator.Persistent);
			AttackCommandsConcurrent = AttackCommands;
		}

		AttackCommandsConcurrentFence.Complete();

		var attackCommandsJob = new AttackCommandsJob { minions = minions, attackCommands = AttackCommands };

		AttackCommandsFence = attackCommandsJob.Schedule(inputDeps);

		return AttackCommandsFence;
	}

	public struct AttackCommandsJob : IJob
	{
		public ComponentDataFromEntity<MinionData> minions;
		public NativeQueue<AttackCommand> attackCommands;

		public void Execute()
		{
			while (attackCommands.Count > 0)
			{
				var command = attackCommands.Dequeue();

				if (minions.Exists(command.DefenderEntity))
				{
					var minion = minions[command.DefenderEntity];
					minion.Health -= command.Damage;
					minions[command.DefenderEntity] = minion;
				}
			}
		}
	}
}
