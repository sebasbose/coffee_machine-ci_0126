namespace coffee_machine_backend.Domain.Models;

public class Payment
{
    public int TotalAmount { get; set; }
    public List<int> Coins { get; set; }
    public List<int> Bills { get; set; }
}
