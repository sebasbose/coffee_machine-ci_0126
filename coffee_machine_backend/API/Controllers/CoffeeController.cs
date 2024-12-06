namespace coffee_machine_backend.API.Controllers;

using coffee_machine_backend.Application.Interfaces;
using coffee_machine_backend.Domain.Database;
using coffee_machine_backend.Domain.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

[Route("api/[controller]")]
[ApiController]
public class CoffeeController : ControllerBase
{
    private readonly Database _database;
    private readonly ICoffeeManager _coffeeManager;
    
    public CoffeeController(ICoffeeManager coffeeManager)
    {
        _database = new();
        _coffeeManager = coffeeManager;
    }

    [HttpGet("AvailableCoffees")]
    public IActionResult GetAvailableCoffees() => Ok(_coffeeManager.GetAvailableCoffees(_database));

    [HttpPost("Purchase")]
    public IActionResult Purchase([FromBody] PurchaseRequest request)
    {
        if (request.Order == null || request.Order.Count == 0)
            return BadRequest("La orden no puede ser nula ni estar vacia.");

        if (request.Payment == null)
            return BadRequest("Los detalles del pago no pueden ser nulos.");

        if (request.Payment.TotalAmount <= 0)
            return BadRequest("La cantidad total de pago debe ser mayor a 0.");

        try
        {
            var result = _coffeeManager.PurchaseCoffee(_database, request.Order, request.Payment);
            if (result == null)
                return StatusCode(500, "Ocurrio un error al procesar la solicitud.");

            return Ok(result);
        }
        catch (ArgumentException ex)
        {
            return BadRequest(ex.Message);
        }
        catch (Exception ex)
        {
            return StatusCode(500, ex.Message);
        }
    }
}
