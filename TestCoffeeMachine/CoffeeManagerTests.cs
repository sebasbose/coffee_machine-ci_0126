using coffee_machine_backend.Application.Managers;
using coffee_machine_backend.Domain.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TestCoffeeMachine
{
    internal class CoffeeManagerTests
    {
        private CoffeeManager _coffeeManager;

        [SetUp]
        public void Setup()
        {
            _coffeeManager = new CoffeeManager();
        }

        [Test]
        public void GetAvailableCoffees_ShouldReturnInitialStock()
        {
            // Act
            var coffees = _coffeeManager.GetAvailableCoffees();

            // Assert
            Assert.AreEqual(4, coffees.Count);
            Assert.AreEqual("Americano", coffees[0].Name);
            Assert.AreEqual(10, coffees[0].Stock);
        }

        [Test]
        public void PurchaseCoffee_ValidOrder_ShouldReduceStockAndReturnChange()
        {
            // Arrange
            var order = new Dictionary<string, int>
            {
                { "Americano", 2 }
            };
            var payment = new Payment
            {
                TotalAmount = 2000,
                Coins = new List<int> { 500, 500 },
                Bills = new List<int> { 1000 }
            };

            // Act
            var result = _coffeeManager.PurchaseCoffee(order, payment);

            // Assert
            Assert.IsNotNull(result);
            Assert.AreEqual("Su vuelto es de: 100 colones. Desglose: 1 moneda de 100", result);
        }

        [Test]
        public void PurchaseCoffee_InvalidOrder_ShouldThrowArgumentException()
        {
            // Arrange
            var order = new Dictionary<string, int>
            {
                { "Americano", 11 }
            };
            var payment = new Payment
            {
                TotalAmount = 12500,
                Coins = new List<int> { 500, 500, 500, 500, 500 },
                Bills = new List<int> { 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000 }
            };

            // Act
            var result = _coffeeManager.PurchaseCoffee(order, payment);

            // Assert
            Assert.AreEqual("No hay suficientes Americano en stock.", result);
        }
    }
}
