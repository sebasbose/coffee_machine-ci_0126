namespace coffee_machine_backend.Domain.Models;

public class PurchaseRequest
{
    public Dictionary<string, int> Order { get; set; }
    public Payment Payment { get; set; }
}
