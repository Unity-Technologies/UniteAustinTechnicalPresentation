using UnityEngine;
using Unity.Entities;
using System.Collections.Generic;
using Unity.Collections;
using Unity.Jobs;
using Unity.Mathematics;
using UnityEngine.Profiling;

// TODO there will be a sexy events system
[UpdateAfter(typeof(CommandSystem))]
public class SpellSystem : JobComponentSystem
{
	private static GameObject SpellObject;

	public class SpellPool
	{
		private Queue<GameObject> pooledObjects = new Queue<GameObject>();

		public GameObject Original;

		public GameObject Get()
		{
			if (pooledObjects.Count == 0)
			{
				if (SpellObject == null) SpellObject = new GameObject("PooledSpells");

				var newGo = Object.Instantiate(Original, SpellObject.transform);
				newGo.GetComponentInChildren<SpellScript>().SpellPool = this;
				return newGo;
			}
			var go = pooledObjects.Dequeue();
			var spellScript = go.GetComponentInChildren<SpellScript>();
			spellScript.OnFetch();
			spellScript.explode = false;
			spellScript.SpellPool = this;
			return go;
		}

		public void Release(GameObject go)
		{
			go.GetComponentInChildren<SpellScript>().OnRelease();
			pooledObjects.Enqueue(go);
		}
	}

	public struct Rigidbodies
	{
		public ComponentDataArray<UnitTransformData> transforms;
		public ComponentDataArray<RigidbodyData> rigidbodies;
		public EntityArray entities;
		public int Length;
	}

	//public struct Formations
	//{
	//	public ComponentDataArray<FormationData> formations;
	//}

	[Inject]
	private Rigidbodies rigidbodies;

	//[Inject]
	//private Formations formations;

	private GameObject currentSpell = null;//SimulationSettings.Instance.MeteorStrike;

	private Dictionary<SpellType, SpellPool> spellPools = new Dictionary<SpellType, SpellPool>();

	[System.Serializable]
	public struct SpellSettings
	{
		public SpellType spell;
		public float explosionDistance;
		public float2 blastDirectionModifier;
		public float2 blastDirectionFactor;
		public float verticalComponentFactor;
		public float randomHorizontal;
		public bool useInvertedDistance;
	}

	public enum SpellType
	{
		Ray,
		Meteor,
		Spikes,
		HolyNova,
		Wings,
		Lightning,
		MegaMeteorOfDooooom
	}

	public struct SpellExplosion
	{
		public SpellExplosion(SpellSettings s, float3 p)
		{
			settings = s;
			position = p;
		}
		public SpellSettings settings;
		public float3 position;
	}
	public static List<SpellExplosion> SpellExplosionsQueue;

	private NativeList<SpellData> spellData;

	public JobHandle CombinedExplosionHandle;

	[Inject]
	private UnitLifecycleManager unitLifecycleManager;

	protected override void OnCreateManager()
	{
		base.OnCreateManager();

		if (SpellExplosionsQueue == null)
			SpellExplosionsQueue = new List<SpellExplosion>();
		else
			SpellExplosionsQueue.Clear();

		spellData = new NativeList<SpellData>(20, Allocator.Persistent);
	}

	protected override void OnDestroyManager()
	{
		if (spellData.IsCreated) spellData.Dispose();
		base.OnDestroyManager();
	}

	public static HashSet<Entity> EntitiesForFlying;

	public GameObject CastFireball(Vector3 position)
	{
		//currentSpell = SimulationSettings.Instance.Ray;

		//return CreateSpellPooled(SpellType.Ray, currentSpell, position);
		return null;
	}

	public GameObject CastMeteor(Vector3 position)
	{
		//currentSpell = SimulationSettings.Instance.MeteorStrike;

		//return CreateSpellPooled(SpellType.Meteor, currentSpell, position);
		return null;
	}

	public GameObject CastSpikes(Vector3 position)
	{
		//currentSpell = SimulationSettings.Instance.GravityField;

		//return CreateSpellPooled(SpellType.Spikes, currentSpell, position);
		return null;
	}

	public GameObject CastLightning(Vector3 position)
	{
		//currentSpell = SimulationSettings.Instance.Lightning;

		//return CreateSpellPooled(SpellType.Lightning, currentSpell, position);
		return null;
	}

	public GameObject CastWings(Vector3 position)
	{
		//currentSpell = SimulationSettings.Instance.Wings;

		//return CreateSpellPooled(SpellType.Wings, currentSpell, position);
		return null;
	}

	public GameObject CastHolyNova(Vector3 position)
	{
		//currentSpell = SimulationSettings.Instance.HolyNova;

		//return CreateSpellPooled(SpellType.HolyNova, currentSpell, position);
		return null;
	}

	public struct SpellData
	{
		public float2 blastDirectionFactor;
		public float2 blastDirectionModifier;
		public float3 explosionPosition;
		public float explosionDistance;
		public bool1 useInvertedDistance;
		public float verticalComponentFactor;
		public float randomHorizontal;
	}

	[ComputeJobOptimization]
	public struct ApplyExplosionJob : IJobParallelFor
	{
		[ReadOnly]
		public ComponentDataArray<UnitTransformData> transforms;

		public ComponentDataArray<RigidbodyData> rigidbodies;

		[ReadOnly]
		public EntityArray entities;

		[ReadOnly]
		public NativeArray<SpellData> spells;

		public int frameCount;

		public NativeQueue<Entity>.Concurrent entitiesForFlying;

		public void Execute(int index)
		{
			long seed = frameCount * index;
			for (int spellIndex = 0; spellIndex < spells.Length; spellIndex++)
			{
				var spell = spells[spellIndex];
				var dirFactor = new float2(spell.blastDirectionFactor.x, spell.blastDirectionFactor.y);

				var t = transforms[index];
				var r = rigidbodies[index];
				var distance = math.distance(t.Position.xz, spell.explosionPosition.xz);

				if (distance < spell.explosionDistance)
				{
					var direction = math.normalize(t.Position.xz - spell.explosionPosition.xz) + spell.blastDirectionModifier.xy;
					direction *= dirFactor;

					entitiesForFlying.Enqueue(entities[index]);

					const float explosionIntensity = 20f;

					var normalizedDistance = distance / spell.explosionDistance;
					if (spell.useInvertedDistance) normalizedDistance = 1f - normalizedDistance;
					var verticalComponent = math.max(explosionIntensity * 0.5f,
													(1f - normalizedDistance) * explosionIntensity * Randomizer.Float(0.8f, 1f, ref seed)) * spell.verticalComponentFactor;
					float horizontalComponent;
					if (spell.useInvertedDistance)
					{
						horizontalComponent = verticalComponent * Randomizer.Float(1f - spell.randomHorizontal, 1, ref seed);
					}
					else
					{
						horizontalComponent = (explosionIntensity - verticalComponent) * Randomizer.Float(1f - spell.randomHorizontal, 1, ref seed);
					}

					r.Velocity += new float3(horizontalComponent * direction.x, verticalComponent, horizontalComponent * direction.y);
				}

				rigidbodies[index] = r;
			}
		}
	}

	protected override JobHandle OnUpdate(JobHandle inputDeps)
	{
		if (rigidbodies.Length == 0) return inputDeps;

		if (Input.GetKeyDown(KeyCode.Alpha1))
		{
			RaycastHit lastHit;
			Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
			if (Physics.Raycast(ray, out lastHit, Mathf.Infinity, FormationSystem.GroundLayermask))
			{
				GameObject go = ObjectPooler._this.Get(PoolType.FireLance);
				FireLance fireLance = go.GetComponent<FireLance>();
				go.SetActive(true);
				fireLance.PlayEffect(go.transform.position, lastHit.point);
			}
		}
		else if (Input.GetKeyDown(KeyCode.Alpha2))
		{
			RaycastHit lastHit;
			Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
			if (Physics.Raycast(ray, out lastHit, Mathf.Infinity, FormationSystem.GroundLayermask))
			{
				for (int i = 0; i < 1024; ++i)
				{
					float3 srcPos = new float3(-30, 22, 295);
					float3 targetPosition = lastHit.point;
					targetPosition += new float3(Random.Range(-20, 20), 0, Random.Range(-20, 20));

					float3 relativeVector = targetPosition - srcPos;
					float distance = math.length(relativeVector.xz);
					float3 arrowStartingPosition = srcPos + new float3(0f, 3f, 0f);

					//if (math.all(math.abs(t.Position) < new float3(2, 2, 2)))
					//{
					//	Debug.Log(index + " " + t.FormationIndex + " " + t.IndexInFormation + " " + t.Position);
					//}

					float spellVelocityScale = 0.1f;
					float angle = Mathf.PI * spellVelocityScale * math.lerp(0.36f, 0.2f, math.saturate(distance / RangedUnitData.ArcherAttackRange));
					float variant = Mathf.PI * spellVelocityScale * 0.05f;
					angle = Random.Range(angle - variant, angle + variant);

					float velocity = ArcherJob.GetArrowVelocity(distance, angle, arrowStartingPosition.y - targetPosition.y);

					float3 shootingVector = math.normalize(new float3(relativeVector.x, 0, relativeVector.z));

					// rotate the vector
					float3 rotAxis = math.cross(shootingVector, new float3(0, 1, 0));
					Quaternion rotation = ArcherJob.AngleAxis(angle, rotAxis);

					shootingVector = rotation * shootingVector;
					var arrow = new ArrowData() {IsFriendly = 1};
					// FIREEE!!!
					arrow.position = arrowStartingPosition;
					arrow.velocity = shootingVector * velocity;
					arrow.active = true;

					unitLifecycleManager.createdArrows.Enqueue(arrow);
				}
			}
		}


		inputDeps.Complete();

		CombinedExplosionHandle.Complete();
		spellData.Clear();
		foreach (var explosion in SpellExplosionsQueue)
		{
			spellData.Add(new SpellData()
			{
				randomHorizontal = explosion.settings.randomHorizontal,
				blastDirectionFactor = explosion.settings.blastDirectionFactor,
				blastDirectionModifier = explosion.settings.blastDirectionModifier,
				useInvertedDistance = explosion.settings.useInvertedDistance,
				explosionDistance = explosion.settings.explosionDistance,
				verticalComponentFactor = explosion.settings.verticalComponentFactor,
				explosionPosition = explosion.position
			});
		}
		SpellExplosionsQueue.Clear();

		if (spellData.Length > 0)
		{
			var explosionJob = new ApplyExplosionJob()
			{
				entities = rigidbodies.entities,
				entitiesForFlying = unitLifecycleManager.entitiesForFlying.ToConcurrent(),
				transforms = rigidbodies.transforms,
				frameCount = Time.frameCount,
				rigidbodies = rigidbodies.rigidbodies,
				spells = spellData
			};

			CombinedExplosionHandle = explosionJob.Schedule(rigidbodies.Length, SimulationState.HumongousBatchSize, inputDeps);
		}
		else CombinedExplosionHandle = default(JobHandle);

		return CombinedExplosionHandle;
	}

	private void CreateSpell(RaycastHit castPoint)
	{
		var instance = GameObject.Instantiate<GameObject>(currentSpell);
		var spell = instance.GetComponentInChildren<SpellScript>();
		spell.InitPositions(castPoint.point);
	}

	private GameObject CreateSpellPooled(SpellType type, GameObject original, Vector3 position)
	{
		SpellPool pool;

		if (!spellPools.TryGetValue(type, out pool))
		{
			pool = new SpellPool();
			pool.Original = original;
			spellPools[type] = pool;
		}

		var go = pool.Get();
		go.GetComponentInChildren<SpellScript>().InitPositions(position);
		return go;
	}
}
