using Unity.Mathematics;
using UnityEngine;

public class CameraController : MonoBehaviour
{
	public float MaxTranslationPerSecond = 10f;
	public float FovDegreesPerSecond = 10f;

	//public Vector3 currentAnchorPosition;
	//public Vector3 previousAnchorPosition;
	//public Vector3 targetPosition;
	//public Vector3 targetOrientation;

	public float3 anchorPosition = 0;
	public float3 anchorDirection = 0;
	public float zoom = 40;

	public float MouseDragSpeed = 1f;

	private float2? previousMousePosition;

	public bool lockDirectionToTarget = false;

	public float3 TargetPosition
	{
		get { return anchorPosition + anchorDirection * zoom; }
	}

	public void Awake()
	{
		anchorDirection = new float3(0.77f, 0.77f, 0);
	}

	public void LateUpdate()
	{

		float prevZoom = zoom;
		zoom -= Input.GetAxis("Mouse ScrollWheel") * 125;
		if (zoom < 10) zoom = 10;
		if (zoom > 350) zoom = 350;

		float3 target = TargetPosition;
		
		transform.position = Vector3.MoveTowards(transform.position, target,
			math.distance(transform.position, target) * Time.deltaTime * 6);
		if (math.distance(transform.position, target) < 0.01f) transform.position = target;

		if (lockDirectionToTarget) transform.forward = math.normalize(anchorPosition - (float3)transform.position);
		else transform.forward = -anchorDirection;

		if (prevZoom != zoom)
		{
			AudioSystem.setZoomLevel(zoom - 10, 340f);

			if (prevZoom < zoom) AudioSystem.PostEvent("ZOOMOUT_STARTED");
			else AudioSystem.PostEvent("ZOOMIN_STARTED");
		}

		//if (currentZoomLevelIndex > previousZoomLevelIndex)
		//{
		//	isZoomingIn = false;
		//	AudioSystem.setZoomLevel (currentZoomLevelIndex, zoomLevels.Length - 1);
		//	AudioSystem.PostEvent("ZOOMOUT_STARTED");
		//}
		//else if (currentZoomLevelIndex < previousZoomLevelIndex)
		//{
		//	isZoomingIn = true;
		//	AudioSystem.setZoomLevel (currentZoomLevelIndex, zoomLevels.Length - 1);
		//	AudioSystem.PostEvent("ZOOMIN_STARTED");
		//}

		//if (currentZoomLevelIndex != previousZoomLevelIndex)
		//{
		//	Debug.Log(zoomLevels[currentZoomLevelIndex].EulerOrientation);
		//	previousZoomLevel = zoomLevels[previousZoomLevelIndex];
		//	zoomStartedTime = Time.time;
		//}

		bool move = Input.GetMouseButton(1);
		bool rotate = Input.GetMouseButton(2);

		if (move || rotate)
		{
			if (previousMousePosition == null) previousMousePosition = ((float3)Input.mousePosition).xy;
			else
			{
				float2 mouseDelta = new float2(Input.mousePosition.x, Input.mousePosition.y) - previousMousePosition.Value;

				float3 f = transform.forward;
				f.y = 0;
				f = math.normalize(f);
				if (math.any(f))
				{
					float3 s = math.cross(f, new float3(0, 1, 0));

					if (move)
					{
						float2 movement = mouseDelta * Time.deltaTime * MouseDragSpeed * (zoom / 275);
						movement.y = -movement.y;

						anchorPosition += f * movement.y + s * movement.x;
						lockDirectionToTarget = false;
					}

					if (rotate)
					{
						Quaternion yaw = Quaternion.AngleAxis(mouseDelta.x * 0.25f, Vector3.up);
						Quaternion pitch = Quaternion.AngleAxis(mouseDelta.y * 0.25f, s);

						float3 newDirection = -(pitch * (yaw * -anchorDirection)).normalized;
						if (newDirection.y < 0.1f) newDirection.y = 0.1f;
						if (newDirection.y > 0.75f) newDirection.y = 0.75f;

						newDirection = math.normalize(newDirection);

						anchorDirection = newDirection;

						lockDirectionToTarget = true;
					}
				}

				previousMousePosition = ((float3)Input.mousePosition).xy;
			}
		}
		else
		{
			previousMousePosition = null;
		}
	}
}