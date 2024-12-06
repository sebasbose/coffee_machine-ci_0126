namespace coffee_machine_backend.Application.Interfaces;

using coffee_machine_backend.Domain.Database;
using coffee_machine_backend.Domain.Models;

public interface ICoffeeManager
{
    List<CoffeeType> GetAvailableCoffees(Database database);
    string PurchaseCoffee(Database database, Dictionary<string, int> order, Payment payment);
}
