using Unity.Entities;

// struct that lets the system know it should apply the results into the transform component
public struct WriteToTransformMarker : IComponentData
{
}

public class WriteToTransformMarkerComponent : ComponentDataWrapper<WriteToTransformMarker>
{
}
