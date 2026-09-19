namespace LongestIncreasingSubsequence;

public static class Solver
{
    public static string Find(string input)
    {
        ArgumentNullException.ThrowIfNull(input);

        if (string.IsNullOrWhiteSpace(input))
        {
            return string.Empty;
        }

        int[] values = input
            .Split((char[]?)null, StringSplitOptions.RemoveEmptyEntries)
            .Select(int.Parse)
            .ToArray();

        int bestStart = 0;
        int bestLength = 1;
        int currentStart = 0;
        int currentLength = 1;

        for (int index = 1; index < values.Length; index++)
        {
            if (values[index - 1] < values[index])
            {
                currentLength++;
            }
            else
            {
                currentStart = index;
                currentLength = 1;
            }

            if (currentLength > bestLength)
            {
                bestStart = currentStart;
                bestLength = currentLength;
            }
        }

        return string.Join(' ', values.Skip(bestStart).Take(bestLength));
    }
}