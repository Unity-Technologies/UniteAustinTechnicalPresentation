using System;
using System.Collections.Generic;

public static class AudioSystem
{
	private static readonly Dictionary<string, List<Action<string>>> EventListeners = new Dictionary<string, List<Action<string>>>();
	private static readonly Dictionary<string, List<Action<string>>> OnceEventListeners = new Dictionary<string, List<Action<string>>>();

	private static float ZoomLevel;

	public static void PostEvent(string eventName)
	{
		List<Action<string>> listeners;
		if (EventListeners.TryGetValue(eventName, out listeners))
		{
			for (var i = 0; i < listeners.Count; i++) listeners[i](eventName);
		}
		if (OnceEventListeners.TryGetValue(eventName, out listeners))
		{
			for (var i = 0; i < listeners.Count; i++) listeners[i](eventName);
			OnceEventListeners.Remove(eventName);
		}
	}

	public static void Subscribe(string eventName, Action<string> listener)
	{
		List<Action<string>> listeners;
		if (!EventListeners.TryGetValue(eventName, out listeners))
		{
			listeners = new List<Action<string>>();
			EventListeners.Add(eventName, listeners);
		}
		listeners.Add(listener);
	}

	public static void SubscribeOnce(string eventName, Action<string> listener)
	{
		List<Action<string>> listeners;
		if (!OnceEventListeners.TryGetValue(eventName, out listeners))
		{
			listeners = new List<Action<string>>();
			OnceEventListeners.Add(eventName, listeners);
		}
		listeners.Add(listener);
	}

	public static void Unsubscribe(string eventName, Action<string> listener)
	{
		List<Action<string>> listeners;
		if (!EventListeners.TryGetValue(eventName, out listeners)) return;
		listeners.Remove(listener);
	}

	public static void setZoomLevel(float zoomLevel, float zoomLevels)
	{
		ZoomLevel = zoomLevel / zoomLevels;
	}

	public static float getZoomLevel()
	{
		return ZoomLevel;
	}
}
