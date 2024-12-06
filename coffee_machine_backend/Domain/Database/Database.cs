using coffee_machine_backend.Domain.Models;

namespace coffee_machine_backend.Domain.Database
{
    public class Database
    {
        public Database() {}

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
    }
}
