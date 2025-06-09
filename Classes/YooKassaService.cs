using CyberClub.Classes;
using System.Net.Http.Headers;
using System.Text;
using System.Text.Json;

public class YooKassaService
{
    private readonly HttpClient _httpClient;
    private readonly IConfiguration _configuration;
    private readonly UserService _userService;
    public YooKassaService(HttpClient httpClient, IConfiguration configuration)
    {
        _httpClient = httpClient;
        _configuration = configuration;
    }
    // Создание оплаты
    public async Task<string> CreatePaymentAsync(decimal amount, int clientId, string returnUrl)
    {
        var shopId = _configuration["YooKassa:ShopId"];
        var apiKey = _configuration["YooKassa:SecretKey"];
        var credentials = Convert.ToBase64String(Encoding.UTF8.GetBytes($"{shopId}:{apiKey}"));
        _httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Basic", credentials);

        var requestBody = new
        {
            amount = new
            {
                value = amount.ToString("F2", System.Globalization.CultureInfo.InvariantCulture),
                currency = "RUB"
            },
            confirmation = new
            {
                type = "redirect",
                return_url = returnUrl
            },
            capture = true,
            description = $"Пополнение баланса для клиента #{clientId}"
        };

        var idempotenceKey = Guid.NewGuid().ToString();
        _httpClient.DefaultRequestHeaders.Remove("Idempotence-Key");
        _httpClient.DefaultRequestHeaders.Add("Idempotence-Key", idempotenceKey);

        var jsonBody = JsonSerializer.Serialize(requestBody);
        Console.WriteLine("Request JSON:");
        Console.WriteLine(jsonBody);

        var content = new StringContent(jsonBody, Encoding.UTF8, "application/json");
        var response = await _httpClient.PostAsync("https://api.yookassa.ru/v3/payments", content);

        var responseContent = await response.Content.ReadAsStringAsync();
        Console.WriteLine($"Response status code: {(int)response.StatusCode} {response.ReasonPhrase}");
        Console.WriteLine("Response content:");
        Console.WriteLine(responseContent);

        response.EnsureSuccessStatusCode();

        using var doc = JsonDocument.Parse(responseContent);

        var confirmationUrl = doc.RootElement.GetProperty("confirmation").GetProperty("confirmation_url").GetString();
        return confirmationUrl!;
    }

    public async Task<JsonElement?> GetPaymentInfoAsync(string paymentId)
    {
        var shopId = _configuration["YooKassa:ShopId"];
        var apiKey = _configuration["YooKassa:ApiKey"];
        var credentials = Convert.ToBase64String(Encoding.UTF8.GetBytes($"{shopId}:{apiKey}"));
        _httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Basic", credentials);

        var response = await _httpClient.GetAsync($"https://api.yookassa.ru/v3/payments/{paymentId}");
        response.EnsureSuccessStatusCode();

        var json = await response.Content.ReadAsStringAsync();
        return JsonDocument.Parse(json).RootElement;
    }

}

