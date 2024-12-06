namespace TestCoffeeMachine;

using coffee_machine_backend.Application.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

internal class ChangeHelperTests
{
    [Test]
    public void CalculateChange_ExactChange_ShouldReturnCorrectBreakdown()
    {
        // Arrange
        var availableCoins = new Dictionary<int, int>
            {
                { 500, 10 },
                { 100, 10 },
                { 50, 10 },
                { 25, 10 }
            };

        // Act
        var change = ChangeHelper.CalculateChange(675, availableCoins);

        // Assert
        Assert.IsNotNull(change);
        Assert.AreEqual(675, change.Amount);
        Assert.AreEqual(1, change.CoinBreakdown[500]);
        Assert.AreEqual(1, change.CoinBreakdown[100]);
        Assert.AreEqual(1, change.CoinBreakdown[50]);
        Assert.AreEqual(1, change.CoinBreakdown[25]);
    }

    [Test]
    public void CalculateChange_NotEnoughCoins_ShouldReturnNull()
    {
        // Arrange
        var availableCoins = new Dictionary<int, int>
            {
                { 500, 0 },
                { 100, 1 },
                { 50, 1 },
                { 25, 1 }
            };

        // Act
        var change = ChangeHelper.CalculateChange(675, availableCoins);

        // Assert
        Assert.IsNull(change);
    }
}
