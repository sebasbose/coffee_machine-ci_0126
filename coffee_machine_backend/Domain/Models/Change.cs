namespace coffee_machine_backend.Domain.Models;

public class Change
{
    public int Amount { get; set; }
    public Dictionary<int, int> CoinBreakdown { get; set; } = new();
}
