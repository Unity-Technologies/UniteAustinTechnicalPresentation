using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Unity.Entities;
using UnityEngine.UI;

public class UIController : MonoBehaviour
{
	public Camera UICamera;

	public RectTransform cardsPanel;

	public Image smallLogoImage;

	public Vector3 normalSize = new Vector3 (1f, 1f, 1f);
	public Vector3 selectedSize  = new Vector3 (1.3f, 1.3f, 1.3f);

	float timeToBeSelected = 0.3f;
	float currentpassedTime;

	int selectedCardId = -1;

	private Camera mainCamera;

	void Awake()
	{
		smallLogoImage.material.color = new Color(smallLogoImage.material.color.r, smallLogoImage.material.color.g,
												smallLogoImage.material.color.b, 1);
	}

	public void Update()
	{
		if (GameManager.Instance == null) return;

		bool selectedCard = false;
		if (Input.GetKey (KeyCode.Alpha1) || Input.GetKey (KeyCode.Alpha2) || Input.GetKey (KeyCode.Alpha3)) 
		{
			selectedCard = true;

			if (Input.GetKey (KeyCode.Alpha1)) {
				selectedCardId = 1;
			}
			else if (Input.GetKey (KeyCode.Alpha2)) {
				selectedCardId = 2;
			}
			else if (Input.GetKey (KeyCode.Alpha3)) {
				selectedCardId = 3;
			}
		}

		currentpassedTime += Time.deltaTime;
		if (selectedCard) 
		{
			currentpassedTime = 0f;
		}
	}
}
