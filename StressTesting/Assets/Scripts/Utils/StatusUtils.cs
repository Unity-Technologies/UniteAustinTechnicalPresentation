using UnityEngine.Experimental.AI;

public static class StatusUtils
{
    public static bool IsSuccess(this PathQueryStatus status)
    {
        return (status & PathQueryStatus.Success) != 0;
    }

    public static bool IsFailure(this PathQueryStatus status)
    {
        return (status & PathQueryStatus.Failure) != 0;
    }

    public static bool IsInProgress(this PathQueryStatus status)
    {
        return (status & PathQueryStatus.InProgress) != 0;
    }
}
