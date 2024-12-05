namespace coffee_machine_backend.Application.Managers;

using coffee_machine_backend.Application.Interfaces;
using coffee_machine_backend.Domain.Models;

public class CoffeeManager: ICoffeeManager
{
    public List<CoffeeType> GetAvailableCoffees() => [];

    public string PurchaseCoffee(Dictionary<string, int> order, Payment payment)
    {
        return "";
    }
}
