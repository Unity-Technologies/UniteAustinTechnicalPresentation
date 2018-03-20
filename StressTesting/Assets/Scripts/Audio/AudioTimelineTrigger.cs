using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Playables;

public class AudioTimelineTrigger : MonoBehaviour
{
	[Serializable]
	public struct TimelineAudioEvent
	{
		public float AfterTime;
		public string EventName;
	}

	public PlayableDirector Director;

	public List<TimelineAudioEvent> TimelineEvents;

	private void OnEnable()
	{
		if (TimelineEvents == null || TimelineEvents.Count == 0 || Director == null) return;

		var eventToTrigger = "";
		for (var i = 0; i < TimelineEvents.Count; i++)
		{
			if (TimelineEvents[i].AfterTime > Director.time) break;
			eventToTrigger = TimelineEvents[i].EventName;
		}
		if (eventToTrigger != "") AudioSystem.PostEvent(eventToTrigger);
	}
}
