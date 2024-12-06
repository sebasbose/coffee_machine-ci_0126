namespace coffee_machine_backend.Application.Interfaces;

using coffee_machine_backend.Domain.Models;

public interface IChangeHelper
{
    Change? CalculateChange(int changeAmount, Dictionary<int, int> availableCoins);
}
