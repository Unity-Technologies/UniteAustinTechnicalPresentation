using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public enum PoolType
{
	None,
    FireLance
};

/// <summary>
/// Contains object pool information.
/// </summary>

[System.Serializable]
public class PooledObject
{
	public string name = "Pool Name";
	public PoolType poolType = PoolType.None;
	public GameObject prefab;
	public int poolCount;
	public List<GameObject> objectPool = new List<GameObject> ();
}

/// <summary>
/// Object pooler.
/// </summary>

public class ObjectPooler : MonoBehaviour
{

	public PooledObject[] pool;
    private Transform parentTransform;

	[HideInInspector]
	public static ObjectPooler _this;

	private void Awake ()
	{
		_this = this;
	}

	void Start ()
	{
        Initialize ();
	}

    public void Reset()
    {
        foreach(PooledObject x in pool)
        {
            x.objectPool.Clear();
        }
        Initialize();
    }

    // Use this for initialization
    void Initialize ()
	{
        //make an empty game object to serve as a "folder" for all instantiated objects
        if (parentTransform == null)
            parentTransform = new GameObject("PooledObjects").transform;
        //initialize pool
        for (int i = 0; i < pool.Length; i++) {
			PooledObject po = pool [i];

			for (int j = 0; j < po.poolCount; j++) {
				InstantiateGO (po);
			}
		}
	}

    //instantiate a new game object
	private GameObject InstantiateGO (PooledObject po)
	{
		GameObject go = Instantiate (po.prefab);
		po.objectPool.Add (go);
        go.transform.SetParent(parentTransform);
		go.SetActive (false);
		return go;
	}

    //get existing pooled object
	public GameObject Get (PoolType type)
	{

		GameObject returnObj = null;

		for (int i = 0; i < pool.Length; i++) {
			PooledObject po = pool [i];

			if (po.poolType == type) {        
				for (int j = 0; j < po.objectPool.Count; j++) {
					if (po.objectPool[j] != null && !po.objectPool [j].activeSelf) {
						returnObj = po.objectPool [j];
						break;
					}
				}
			}
		}

		if (returnObj != null)
			return returnObj;
		else
			return AddNew (type);
	}

    //add new object to the pool if there are no available ones
	public GameObject AddNew (PoolType type)
	{
		GameObject returnObj = null;

		for (int i = 0; i < pool.Length; i++) {
			PooledObject po = pool [i];

			if (po.poolType == type) {
				returnObj = InstantiateGO (po);
			}
		}

		return returnObj;
	}
	
}
