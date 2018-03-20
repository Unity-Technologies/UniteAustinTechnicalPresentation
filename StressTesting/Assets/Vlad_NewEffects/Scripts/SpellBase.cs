using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public enum SpellType
{
    FireLance
}

public class SpellBase : MonoBehaviour {

    public SpellType spellType = SpellType.FireLance;
    public float impactTime = 0f; //time it takes for the spell to hit (0 for instant)

    public virtual void PlayEffect(Vector3 startPos, Vector3 hitPos)
    {
        transform.position = startPos;
    }

}
