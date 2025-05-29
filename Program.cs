using CyberClub.Classes;
using CyberClub.Components;
using CyberClub.Controllers;
using CyberClub.Database;

using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddRazorComponents()
    .AddInteractiveServerComponents();

builder.Services.AddDbContext<BootcampContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));

builder.Services.AddHostedService<SessionBackgroundService>();
builder.Services.AddSingleton<UserService>();
builder.Services.AddScoped<ExcelReportService>();
builder.Services.AddHttpClient();
builder.Services.Configure<YooKassaSettings>(
    builder.Configuration.GetSection("YooKassa"));
builder.Services.AddScoped<YooKassaService>();
builder.Services.AddControllers();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error", createScopeForErrors: true);
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();

app.UseStaticFiles();
app.UseAntiforgery();

app.MapRazorComponents<App>()
    .AddInteractiveServerRenderMode();
app.Use(async (context, next) =>
{
    Console.WriteLine($"➡️ Запрос: {context.Request.Method} {context.Request.Path}");
    await next.Invoke();
});


app.MapControllers();

app.Run();
