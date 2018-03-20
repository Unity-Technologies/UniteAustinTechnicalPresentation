using System;
using System.Collections.Generic;
using Unity.Mathematics;
using UnityEngine;
using Unity.Entities;

public class SpellScript : MonoBehaviour
{
	[NonSerialized]
	public Animator animator;

	public bool Inactive = false;

	[NonSerialized]
	public AnimatorControllerParameter[] parameters;

	[NonSerialized]
	public ParticleSystem[] particleSystems;

	[NonSerialized]
	public Renderer[] renderers;

	[NonSerialized]
	public Light[] lights;

	[NonSerialized]
	public bool[] defaultLightStatus;

	public bool hasReset;
	public HashSet<int> cachedAnimatorParams = new HashSet<int>();

	public bool DestroyParentEnabled = true;
	public bool explode = false;
	protected bool destroy = false;

	public SpellSystem.SpellPool SpellPool;

	public virtual float3 Position { get { return transform.position; } }

	public GameObject RootObject;

	protected virtual float2 BlastDirectionModifier
	{
		get
		{
			return new float2(settings.blastDirectionModifier.x, settings.blastDirectionModifier.y);
		}
	}

	public SpellSystem.SpellType Spell;
	private SpellSystem.SpellSettings settings;

	public int ResetId;

	public void OnFetch()
	{
		if (Inactive) return;
		for (int i = 0; i < particleSystems.Length; i++)
		{
			if (particleSystems[i] == null) continue;
			particleSystems[i].Play(false);
		}

		ActivateRenderers();

		for (int i = 0; i < lights.Length; i++)
		{
			if (lights[i] == null) continue;
			lights[i].enabled = defaultLightStatus[i];
		}

		if (animator != null)
		{
			animator.enabled = true;
			if (hasReset) { animator.SetTrigger(ResetId); }
		}

		var rsp = GetComponent<RandomSoundPlayer>();
		if (rsp != null)
			rsp.PlaySound();
	}

	public void Deactivate()
	{
		if (SpellPool != null) SpellPool.Release(RootObject);
	}

	public void OnRelease()
	{
		if (Inactive) return;
		if (animator != null)
		{
			animator.enabled = false;
			ResetAnimator();
		}

		DeactivateRenderers();

		for (int i = 0; i < particleSystems.Length; i++)
		{
			if (particleSystems[i] == null) continue;
			particleSystems[i].Stop(false);
		}
	}

	public void ResetAnimator()
	{
		if (Inactive) return;
		for (int i = 0; i < parameters.Length; i++)
		{
			var parameterType = parameters[i].type;
			var parameterHash = parameters[i].nameHash;

			if (parameterType == AnimatorControllerParameterType.Trigger)
			{
				if (parameterHash != 10) { animator.ResetTrigger(parameterHash); }
			}
			else if (parameterType == AnimatorControllerParameterType.Bool)
			{
				animator.SetBool(parameterHash, parameters[i].defaultBool);
			}
			else if (parameterType == AnimatorControllerParameterType.Float)
			{
				animator.SetFloat(parameterHash, parameters[i].defaultFloat);
			}
			else if (parameterType == AnimatorControllerParameterType.Int)
			{
				animator.SetInteger(parameterHash, parameters[i].defaultInt);
			}
		}
	}

	public void Awake()
	{
		if (Inactive) return;
		settings = SimulationSettings.Instance.SpellSettings.Find(x => x.spell == Spell);

		renderers = GetComponentsInChildren<Renderer>(true);
		particleSystems = gameObject.GetComponentsInChildren<ParticleSystem>(true);
		animator = GetComponentInChildren<Animator>(true);

		lights = GetComponentsInChildren<Light>(true);
		defaultLightStatus = new bool[lights.Length];
		for (int i = 0; i < defaultLightStatus.Length; i++) defaultLightStatus[i] = lights[i].enabled;

		if (animator != null)
		{
			ResetId = Animator.StringToHash("Reset");
			parameters = animator.parameters;
			for (int i = 0; i < parameters.Length; i++)
			{
				var hash = parameters[i].nameHash;
				cachedAnimatorParams.Add(hash);
				if (hash == ResetId) { hasReset = true; continue; }
			}
		}
	}

	public void Explode()
	{
		explode = true;
	}

	public void DestroyParent()
	{
        if(DestroyParentEnabled)
		    destroy = true; 
	}

	public virtual void InitPositions(float3 hitPosition)
	{
		if (Inactive) return;
		transform.position = hitPosition;
	}

	public void Update()
	{ 
		if (Inactive) return;
		
		if (explode)
		{
			explode = false;
			SpellSystem.SpellExplosionsQueue.Add(new SpellSystem.SpellExplosion(settings, Position));
		}
		if (destroy)
		{
			destroy = false;
			if (SpellPool != null) SpellPool.Release(RootObject);
		}
	}

	public void DeactivateRenderers()
	{
		foreach (Renderer rend in renderers)
		{
			if (rend == null) continue;
			rend.enabled = false;
		}
	}

	public void ActivateRenderers()
	{
		foreach (Renderer rend in renderers)
		{
			if (rend == null) continue;
			rend.enabled = true;
		}
	}
}
