using System.Collections;
using System.Collections.Generic;
using Unity.Entities;
using UnityEngine;

public class FireLance : SpellBase {

    public GameObject lanceHeadParent; //front point of the lance
    public GameObject lanceHeadVisual; //visuals of the lance head
    public ParticleSystem startEffect; //casting (begining of the effect)
    public ParticleSystem fireTrail;
    public ParticleSystem impact;

    [Range(0.1f,1f)]
    public float lanceFadeTime = 0.5f;
    private LineRenderer lr;
    private float startSize;
    private Color startColor;
    private ParticleSystem.EmissionModule fireTrailEmiss;

    private void Awake()
    {
        lr = GetComponent<LineRenderer>();
        startSize = lr.widthMultiplier;
        startColor = lr.startColor;
        fireTrailEmiss = fireTrail.emission;
        fireTrailEmiss.enabled = false;
    }

    public override void PlayEffect(Vector3 startPos, Vector3 hitPos)
    {
        base.PlayEffect(startPos, hitPos);

        lanceHeadVisual.SetActive(true); //enable the lance head visual
        lr.SetPosition(0, transform.position);
        lr.widthMultiplier = startSize;
        lr.startColor = lr.endColor = startColor;

        startEffect.transform.position = startPos;

        //if there's a delay to the impact, run coroutine
        if (impactTime > 0f)
            StartCoroutine(DelayedEffect(hitPos));
        //else, play impact effect
        else
            Impact();
    }

    //
    IEnumerator DelayedEffect(Vector3 hitPos)
    {
        float timer = 0.0f;

        //set the lance head
        lanceHeadParent.SetActive(true);
        fireTrail.Play();
        lanceHeadParent.transform.localPosition = Vector3.zero; //reset head position
        lanceHeadParent.transform.LookAt(hitPos);
        fireTrailEmiss.enabled = true; //enable trail emission after its parent is moved

        while (timer < impactTime)
        {
            timer += Time.deltaTime;
            float progress = timer / impactTime;

            Vector3 leadingEdge = Vector3.Lerp(transform.position, hitPos, progress);
            lr.SetPosition(1, leadingEdge);
            lanceHeadParent.transform.position = leadingEdge;

            yield return null;
        }
        Impact();
    }

    private void Impact()
    {
        lanceHeadVisual.SetActive(false); //disable lance head
        impact.Play();
        StartCoroutine(FadeLance());

        //ADD IMPACT INTERACTIONS HERE (i.e. damage to units)
        //Debug.Log("BOOM!");
        SpellSystem.SpellExplosionsQueue.Add(new SpellSystem.SpellExplosion(SimulationSettings.Instance.SpellSettings[0], lanceHeadParent.transform.position));
    }

    IEnumerator FadeLance()
    {
        float timer = 0.0f;
        Color fadeColor = Color.white;
        fadeColor.a = 0f;

        while (timer < lanceFadeTime)
        {
            timer += Time.deltaTime;
            //lr.widthMultiplier = Mathf.Lerp(startSize, 0f, timer/lanceFadeTime);
            lr.startColor = lr.endColor = Color.Lerp(startColor, fadeColor, timer / lanceFadeTime);
            yield return null;
        }

        yield return new WaitForSeconds(0.5f);

        startEffect.Stop();
        fireTrail.Stop();
        impact.Stop();

        yield return new WaitForSeconds(1.0f);

        fireTrailEmiss.enabled = false;
        gameObject.SetActive(false);
    }

}
