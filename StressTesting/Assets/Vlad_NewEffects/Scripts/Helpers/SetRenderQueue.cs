using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SetRenderQueue : MonoBehaviour {

    private Material mat;
    public int renderQueue = 1000;
    
    
	// Update is called once per frame
	void Update () {
        if (mat == null)
            mat = GetComponent<ParticleSystemRenderer>().material;

        mat.renderQueue = renderQueue;

    }
}
