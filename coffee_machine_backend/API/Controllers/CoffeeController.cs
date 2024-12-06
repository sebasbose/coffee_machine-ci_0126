namespace coffee_machine_backend.API.Controllers;

using coffee_machine_backend.Application.Interfaces;
using coffee_machine_backend.Domain.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

[Route("api/[controller]")]
[ApiController]
public class CoffeeController : ControllerBase
{
    private readonly ICoffeeManager _coffeeManager;
    
    CoffeeController(ICoffeeManager coffeeManager)
    {
        _coffeeManager = coffeeManager;
    }

    [HttpGet("AvailableCoffees")]
    public IActionResult GetAvailableCoffees() => Ok(_coffeeManager.GetAvailableCoffees());

    [HttpPost("Purchase")]
    public IActionResult Purchase([FromBody] Dictionary<string, int> order, [FromBody] Payment payment)
    {
        if (order == null || order.Count == 0)
            return BadRequest("La orden no puede ser nula ni estar vacia.");

        if (payment == null)
            return BadRequest("Los detalles del pago no pueden ser nulos.");

        if (payment.TotalAmount <= 0)
            return BadRequest("La cantidad total de pago debe ser mayor a 0.");

        try
        {
            var result = _coffeeManager.PurchaseCoffee(order, payment);
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
