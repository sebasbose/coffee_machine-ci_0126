namespace coffee_machine_backend.Application.Interfaces;

using coffee_machine_backend.Domain.Models;

public interface ICoffeeManager
{
    List<CoffeeType> GetAvailableCoffees();
    string PurchaseCoffee(Dictionary<string, int> order, Payment payment);
}
