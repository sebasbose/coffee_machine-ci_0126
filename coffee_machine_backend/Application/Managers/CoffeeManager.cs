namespace coffee_machine_backend.Application.Managers;

using coffee_machine_backend.Application.Helpers;
using coffee_machine_backend.Application.Interfaces;
using coffee_machine_backend.Domain.Database;
using coffee_machine_backend.Domain.Models;

public class CoffeeManager : ICoffeeManager
{
    public List<CoffeeType> GetAvailableCoffees(Database database) => database.CoffeeInventory;

    public string PurchaseCoffee(Database database, Dictionary<string, int> order, Payment payment)
    {
        var totalCost = order.Sum(o => database.CoffeeInventory.First(c => c.Name == o.Key).Price * o.Value);

        if (payment.TotalAmount < totalCost) return "Fondos insuficientes.";

        foreach (var coffee in order)
        {
            var selected = database.CoffeeInventory.First(c => c.Name == coffee.Key);
            if (coffee.Value > selected.Stock) return $"No hay suficientes {coffee.Key} en stock.";
            selected.Stock -= coffee.Value;
        }

        var change = ChangeHelper.CalculateChange(payment.TotalAmount - totalCost, database.CoinInventory);
        if (change == null) return "Fuera de servicio: Cannot provide change.";

        foreach (var coin in change.CoinBreakdown) database.CoinInventory[coin.Key] -= coin.Value;
        return $"Su vuelto es de: {change.Amount} colones. Desglose: {string.Join(", ", change.CoinBreakdown.Select(c => $"{c.Value} moneda de {c.Key}"))}";
    }
}
