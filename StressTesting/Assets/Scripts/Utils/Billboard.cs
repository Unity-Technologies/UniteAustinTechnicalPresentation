using UnityEngine;

[ExecuteInEditMode]
public class Billboard : MonoBehaviour
{
	public bool useLockAxis = false;
	public Vector3 lockAxis = Vector3.up;

	public bool allowRotation = false;

	private bool useUpdate = false;
	private Camera main = null;

	public void Start()
	{
		useUpdate = GetComponent<Renderer>() == null;
		if (useUpdate) main = Camera.main;
	}

	public void Update()
	{
		if (!useUpdate) return;
		DoBillboarding(main);
	}

	public void OnWillRenderObject()
	{
		if (useUpdate) return;
		DoBillboarding(Camera.current);
	}

	private void DoBillboarding(Camera cam)
	{
		if (allowRotation)
		{
			// Trail renderer like billboard
			Vector3 right = transform.right;
			Vector3 toCamera = cam.transform.position - transform.position;

			Vector3 up = Vector3.Cross(toCamera, right);
			Vector3 forward = Vector3.Cross(right, up);

			transform.rotation = Quaternion.LookRotation(forward, up);
		}
		else
		{
			if (useLockAxis)
			{
				// Locked axis billboard
				Vector3 camPos = cam.transform.position;
				Vector3 trueForward = (camPos - transform.position).normalized;
				Vector3 side = Vector3.Cross(trueForward, lockAxis);

				if (side.sqrMagnitude > 0) transform.forward = Vector3.Cross(lockAxis, side);
			}
			// Classical billboard
			else transform.LookAt(cam.transform);
		}
	}
}