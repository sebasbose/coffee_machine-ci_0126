namespace coffee_machine_backend.Application.Managers;

using coffee_machine_backend.Application.Helpers;
using coffee_machine_backend.Application.Interfaces;
using coffee_machine_backend.Domain.Models;

public class CoffeeManager : ICoffeeManager
{
    public List<CoffeeType> CoffeeInventory = new()
    {
        new CoffeeType {Name = "Americano", Stock = 10, Price = 950},
        new CoffeeType {Name = "Capuchino", Stock = 8, Price = 1200},
        new CoffeeType {Name = "Late", Stock = 10, Price = 1350},
        new CoffeeType {Name = "Mocachino", Stock = 15, Price = 1500},
    };

    public Dictionary<int, int> CoinInventory = new()
    {
        { 500, 2 },
        { 100, 30 },
        { 50, 50 },
        { 25, 25 }
    };

    public List<CoffeeType> GetAvailableCoffees() => CoffeeInventory;

    public string PurchaseCoffee(Dictionary<string, int> order, Payment payment)
    {
        var totalCost = order.Sum(o => CoffeeInventory.First(c => c.Name == o.Key).Price * o.Value);

        if (payment.TotalAmount < totalCost) return "Fondos insuficientes.";

        foreach (var coffee in order)
        {
            var selected = CoffeeInventory.First(c => c.Name == coffee.Key);
            if (coffee.Value > selected.Stock) return $"No hay suficientes {coffee.Key} en stock.";
            selected.Stock -= coffee.Value;
        }

        var change = ChangeHelper.CalculateChange(payment.TotalAmount - totalCost, CoinInventory);
        if (change == null) return "Fuera de servicio: No hay cambio.";

        foreach (var coin in change.CoinBreakdown) CoinInventory[coin.Key] -= coin.Value;
        return $"Su vuelto es de: {change.Amount} colones. Desglose: {string.Join(", ", change.CoinBreakdown.Select(c => $"{c.Value} moneda de {c.Key}"))}";
    }
}
