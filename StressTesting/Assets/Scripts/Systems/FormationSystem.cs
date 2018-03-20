using Unity.Collections;
using Unity.Jobs;
using Unity.Mathematics;
using UnityEngine;
using Unity.Entities;
using UnityEngine.Profiling;

// This system should depend on the crowd system, but as systems can depend only on one thing, then all the formation
// systems will execute before the prepare buckets system, which is bad. That is why this system depends on the buckets
// system, to ensure the buckets system begins execution.
[UpdateAfter(typeof(PrepareBucketsSystem))]
public class FormationSystem : JobComponentSystem
{
	public struct Formations
	{
		public ComponentDataArray<FormationData> data;
		public FixedArrayArray<EntityRef> unitData;
		public ComponentDataArray<FormationNavigationData> navigationData;
		public ComponentDataArray<FormationClosestData> closestFormations;
		public ComponentDataArray<CrowdAgentNavigator> navigators;
		public ComponentDataArray<CrowdAgent> agents;
		public ComponentDataArray<FormationHighLevelPath> highLevelPaths;
		public EntityArray entities;

		public int Length;
	}

	[Inject]
	private Formations formations;

	[Inject]
	private ComponentDataFromEntity<IndexInFormationData> indicesInFormation;


	//public static readonly int GroundLayermask = 1 << LayerMask.NameToLayer("Ground");
	public const int GroundLayermask = 1 << 8;

	protected override JobHandle OnUpdate(JobHandle inputDeps)
	{
		// Realloc();
		if (formations.Length == 0) return inputDeps;
		
		//NativeArrayExtensions.ResizeNativeArray(ref raycastHits, math.max(raycastHits.Length,minions.Length));
		//NativeArrayExtensions.ResizeNativeArray(ref raycastCommands, math.max(raycastCommands.Length, minions.Length));
		
		var copyNavigationJob = new CopyNavigationPositionToFormation
		{
			formations = formations.data,
			agents = formations.agents,
			navigators = formations.navigators,
			navigationData = formations.navigationData,
			dt = Time.deltaTime
		};
		
		var updateFormationsJob = new UpdateFormations
		{
			closestFormations = formations.closestFormations,
			formationNavigators = formations.navigators,
			formationHighLevelPath = formations.highLevelPaths,
			formations = formations.data,
		};

		var closestSearchJob = new SearchClosestFormations
		{
			formations = formations.data,
			closestFormations = formations.closestFormations,
			formationEntities = formations.entities
		};
		
		// ==== Schedule Formation jobs ======
		var copyJobFence = copyNavigationJob.Schedule(formations.Length, SimulationState.SmallBatchSize, inputDeps);
		var closestSearchFence = closestSearchJob.Schedule(formations.Length, SimulationState.HugeBatchSize, copyJobFence);
		
		var updateFormationsFence = updateFormationsJob.Schedule(formations.Length, SimulationState.SmallBatchSize,
			closestSearchFence);
		// Pass two, rearrangeing the minion indices
		// TODO Split this system into systems that make sense 
		
		//AddDependency(rearrangeFence);

		// calculate formation movement
		// advance formations
		// calculate minion position and populate the array
		return updateFormationsFence;
	}
	
	[ComputeJobOptimization]
	private struct UpdateFormations : IJobParallelFor
	{
		public ComponentDataArray<FormationData> formations;
		[ReadOnly]
		public ComponentDataArray<FormationClosestData> closestFormations;
		[ReadOnly]
		public ComponentDataArray<FormationHighLevelPath> formationHighLevelPath;

		public ComponentDataArray<CrowdAgentNavigator> formationNavigators;

		public void Execute(int index)
		{
			var navigator = formationNavigators[index];

			var formation = formations[index];

#if DEBUG_CROWDSYSTEM && !ENABLE_HLVM_COMPILER
			Debug.Assert(navigator.active || formation.FormationState == FormationData.State.AllDead);
#endif

			if (formation.FormationState == FormationData.State.AllDead)
			{
				if (navigator.active)
				{
					navigator.active = false;
					formationNavigators[index] = navigator;
				}
				return;
			}

			float3 targetPosition = formationNavigators[index].requestedDestination;
			bool foundTargetPosition = false;
			if (closestFormations[index].closestFormation != new Entity())
			{
				var closestPosition = closestFormations[index].closestFormationPosition;

				// Aggro distance of 75
				if (formation.EnableAgro && math.distance(closestPosition, formation.Position) < 75)
				{
					targetPosition = closestPosition;
					foundTargetPosition = true;
				}
			}

			if (!foundTargetPosition && formation.EnableHighLevelPath)
			{
				int nextPathIndex = formation.HighLevelPathIndex;

				do
				{
					targetPosition = formationHighLevelPath[index].GetTarget(nextPathIndex);
					nextPathIndex++;
				}
				while (math.distance(targetPosition.xz, formation.Position.xz) < 0.1f && nextPathIndex <= 3);
				formation.HighLevelPathIndex = nextPathIndex - 1;
			}

			if (math.distance(formationNavigators[index].requestedDestination.xz, targetPosition.xz) > 0.1f)
			{
				navigator.MoveTo(targetPosition);
			}

			formationNavigators[index] = navigator;
			formations[index] = formation;
		}
	}

	[ComputeJobOptimization]
	private struct SearchClosestFormations : IJobParallelFor
	{
		[ReadOnly]
		public ComponentDataArray<FormationData> formations;
		[ReadOnly]
		public EntityArray formationEntities;
		public ComponentDataArray<FormationClosestData> closestFormations;

		public void Execute(int index)
		{
			if (formations[index].FormationState == FormationData.State.AllDead) return;
			var data = closestFormations[index];
			float d = float.PositiveInfinity;
			int closestIndex = -1;

			for (int i = 0; i < formations.Length; i++)
			{
				if (!(i == index || formations[i].FormationState == FormationData.State.AllDead || formations[i].IsFriendly == formations[index].IsFriendly))
				{
					float3 relative = formations[index].Position - formations[i].Position;
					float newD = math.dot(relative, relative);

					if (newD < d)
					{
						d = newD;
						closestIndex = i;
					}
				}
			}

			if(closestIndex != -1) data.closestFormation = formationEntities[closestIndex]; else data.closestFormation = new Entity();
			if (closestIndex != -1) data.closestFormationPosition = formations[closestIndex].Position;

			closestFormations[index] = data;
		}
	}

	[ComputeJobOptimization]
	private struct CopyNavigationPositionToFormation : IJobParallelFor
	{
		public ComponentDataArray<FormationData> formations;
		[ReadOnly]
		public ComponentDataArray<CrowdAgent> agents;
		[ReadOnly]
		public ComponentDataArray<CrowdAgentNavigator> navigators;
		public ComponentDataArray<FormationNavigationData> navigationData;
		[ReadOnly]
		public float dt;

		public void Execute(int index)
		{
			var formation = formations[index];
			var prevPosition = formation.Position;

			formation.Position = agents[index].worldPosition;

			var forward = formation.Position - prevPosition;
			forward.y = 0;

			// If we are moving we should assign a new forward vector.
			if (!MathUtil.Approximately(math.dot(forward, forward), 0))
			{
				forward = math.normalize(forward);
				formation.Forward = Vector3.RotateTowards(formation.Forward, forward, 0.314f * dt, 1);
			}

			var navData = navigationData[index];

			var targetRelative = navData.TargetPosition - navigators[index].steeringTarget;
			if (!MathUtil.Approximately(math.dot(targetRelative, targetRelative), 0))
			{
				// We got a next corner
				navData.initialCornerDistance = math.length(formation.Position - navigators[index].steeringTarget);
				navData.prevFormationSide = formation.formationSide;
				navData.TargetPosition = navigators[index].steeringTarget;

				navigationData[index] = navData;
			}

			if (navData.initialCornerDistance != 0) formation.formationSide = math.lerp(navData.prevFormationSide, navigators[index].nextCornerSide,
																math.clamp(1 - math.length(formation.Position - navData.TargetPosition) / navData.initialCornerDistance, 0, 1));


			formations[index] = formation;
		}
	}
}