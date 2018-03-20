using Unity.Entities;

namespace Assets.Instancing.Skinning.Scripts.ECS
{
    public struct DyingUnitData : IComponentData
    {
        public float TimeAtWhichToExpire;
	    public float StartingYCoord;

        public DyingUnitData(float timeAtWhichToExpire, float yCoord)
        {
            TimeAtWhichToExpire = timeAtWhichToExpire;
	        StartingYCoord = yCoord;
        }
    }
}
