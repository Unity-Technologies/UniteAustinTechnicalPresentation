using UnityEngine;
using UnityEngine.Audio;
using Unity.Entities;

public class InteractiveSentinel : MonoBehaviour
{
	private bool reallyEnabled;

	public AudioMixer mixer;

	// Use this for initialization
	void Start()
	{

	}

	void OnEnable()
	{
		if (!reallyEnabled)
		{
			reallyEnabled = true;
		}
		else
		{
			World.Active.GetExistingManager<SpawnerSystem>().SpawnAdditionalUnits();

			FindObjectOfType<TextureAnimatorSystemGui>().Enabled = true;

			CameraController c = FindObjectOfType<CameraController>();

			Plane ground = new Plane(Vector3.up, 0);
			Ray r = new Ray(c.transform.position, c.transform.forward);

			float t;
			if (ground.Raycast(r, out t))
			{
				Vector3 p = r.origin + t * r.direction;

				c.anchorPosition = p;
				c.anchorDirection = -r.direction;
				c.zoom = t;
			}

			mixer.SetFloat("AmbienceVolume", -12f);
			mixer.SetFloat("IngameMusicVolume", -23f);
			mixer.SetFloat("PortalVolume", -19f);
			mixer.SetFloat("MinionVolume", -19f);
		}
	}

	// Update is called once per frame
	void Update()
	{

	}
}
