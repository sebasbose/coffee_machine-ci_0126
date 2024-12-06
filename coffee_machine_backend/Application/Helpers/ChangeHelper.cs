namespace coffee_machine_backend.Application.Helpers;

using coffee_machine_backend.Application.Interfaces;
using coffee_machine_backend.Domain.Models;

public class ChangeHelper
{
    public static Change? CalculateChange(int changeAmount, Dictionary<int, int> availableCoins)
    {
        var change = new Change { Amount = changeAmount };
        foreach (var coin in availableCoins.Keys.OrderByDescending(c => c))
        {
            var count = Math.Min(changeAmount / coin, availableCoins[coin]);
            if (count > 0)
            {
                change.CoinBreakdown[coin] = count;
                changeAmount -= coin * count;
            }
        }
        return changeAmount == 0 ? change : null;
    }
}
