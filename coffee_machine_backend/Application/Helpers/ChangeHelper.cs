namespace coffee_machine_backend.Application.Helpers;

using coffee_machine_backend.Application.Interfaces;
using coffee_machine_backend.Domain.Models;

public class ChangeHelper : IChangeHelper
{
    public Change CalculateChange(int changeAmount, Dictionary<int, int> availableCoins)
    {
        return null;
    }
}
