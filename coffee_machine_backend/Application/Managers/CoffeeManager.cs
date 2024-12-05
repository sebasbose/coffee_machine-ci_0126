namespace coffee_machine_backend.Application.Managers;

using coffee_machine_backend.Application.Interfaces;
using coffee_machine_backend.Domain.Models;

public class CoffeeManager: ICoffeeManager
{
    private List<CoffeeType> CoffeeInventory = new()
    {
        new CoffeeType {Name = "Americano", Stock = 10, Price = 950},
        new CoffeeType {Name = "Capuchino", Stock = 8, Price = 1200},
        new CoffeeType {Name = "Late", Stock = 10, Price = 1350},
        new CoffeeType {Name = "Mocachino", Stock = 15, Price = 1500},

    };

    public List<CoffeeType> GetAvailableCoffees() => CoffeeInventory;

    public string PurchaseCoffee(Dictionary<string, int> order, Payment payment)
    {
        return "";
    }
}
