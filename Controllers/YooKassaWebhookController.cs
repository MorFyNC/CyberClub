using CyberClub.Classes;
using CyberClub.Database;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Text.Json;


namespace CyberClub.Controllers
{
    // Контроллер, на который ЮКасса отправляет запросы со статусом платежей
    [ApiController]
    [Route("api/payments")]
    public class PaymentsController : ControllerBase
    {
        private readonly YooKassaService _yooKassaService;
        private readonly UserService _userService;
        private readonly BootcampContext _dbContext;
        private static readonly HashSet<string> _processedPaymentIds = new();

        public PaymentsController(YooKassaService yooKassaService, UserService userService, BootcampContext dbContext)
        {
            _yooKassaService = yooKassaService;
            _userService = userService;
            _dbContext = dbContext;
        }

        [HttpPost("create")]
        public async Task<IActionResult> CreatePayment([FromBody] decimal amount)
        {
            int clientId = _userService.CurrentClient.Id; 

            var returnUrl = "https://localhost:7236/personalCabinet";
            var confirmationUrl = await _yooKassaService.CreatePaymentAsync(amount, clientId, returnUrl);

            return Ok(new { url = confirmationUrl });
        }

        [HttpGet("success")]
        public async Task<IActionResult> PaymentSuccess([FromQuery] string payment_id)
        {
            var paymentInfo = await _yooKassaService.GetPaymentInfoAsync(payment_id);
            if (paymentInfo == null) return BadRequest("Invalid payment");

            var status = paymentInfo.Value.GetProperty("status").GetString();
            if (status != "succeeded") return BadRequest("Payment not completed");

            var amount = paymentInfo.Value.GetProperty("amount").GetProperty("value").GetDecimal();


            var description = paymentInfo.Value.GetProperty("description").GetString();
            var clientId = int.Parse(description!.Split('#').Last());

            using var db = new BootcampContext();
            var client = await db.Clients.FindAsync(clientId);
            if (client == null) return NotFound("Клиент не найден");

            client.Balance += amount;
            db.BalanceReplenishments.Add(new BalanceReplenishment
            {
                IdClient = clientId,
                Amount = amount,
                ReplenishmentType = 2,
                CreatedAt = DateTime.Now
            });

            await db.SaveChangesAsync();

            return Content("<h2>Платеж успешно выполнен. Баланс пополнен.</h2>", "text/html");
        }

        [HttpPost("webhook")]
        [IgnoreAntiforgeryToken]
        [Consumes("application/json")]
        public async Task<IActionResult> PaymentWebhook([FromBody] JsonElement root)
        {
            Console.WriteLine("\n\n\n\n\nWEBHOOK\n\n\n\n\n");

            try
            {
                var eventType = root.GetProperty("event").GetString();
                if (eventType != "payment.succeeded")
                    return Ok();

                var payment = root.GetProperty("object");

                var paymentId = payment.GetProperty("id").GetString();
                if (string.IsNullOrWhiteSpace(paymentId))
                    return BadRequest("Missing payment ID");

                lock (_processedPaymentIds)
                {
                    if (_processedPaymentIds.Contains(paymentId))
                    {
                        Console.WriteLine($"⚠️ Платёж {paymentId} уже был обработан.");
                        return Ok();
                    }

                    _processedPaymentIds.Add(paymentId);
                }

                var status = payment.GetProperty("status").GetString();
                if (status != "succeeded")
                    return Ok();

                var amountStr = payment.GetProperty("amount").GetProperty("value").GetString();
                if (!decimal.TryParse(amountStr, System.Globalization.NumberStyles.Number, System.Globalization.CultureInfo.InvariantCulture, out var amount))
                {
                    return BadRequest("Invalid amount value");
                }

                var description = payment.GetProperty("description").GetString() ?? "";
                var clientIdStr = description.Split('#').LastOrDefault();

                if (!int.TryParse(clientIdStr, out var clientId))
                    return BadRequest("Invalid client ID");

                var client = await _dbContext.Clients.FindAsync(clientId);
                if (client == null)
                    return NotFound();

                client.Balance += amount;

                _dbContext.BalanceReplenishments.Add(new BalanceReplenishment
                {
                    IdClient = clientId,
                    Amount = amount,
                    ReplenishmentType = 2,
                    CreatedAt = DateTime.Now
                });

                await _dbContext.SaveChangesAsync();

                Console.WriteLine($"✅ Успешная обработка платежа {paymentId} для клиента #{clientId}");
                return Ok();
            }
            catch (Exception ex)
            {
                Console.WriteLine($"❌ Ошибка обработки платежа: {ex.Message}");
                return StatusCode(500);
            }
        }




    }
}
