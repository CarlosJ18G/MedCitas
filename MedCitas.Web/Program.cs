using MedCitas.Core.Interfaces;
using MedCitas.Core.Services;
using MedCitas.Infrastructure.Repositories;
using MedCitas.Infrastructure.Services;
using MedCitas.Infrastructure.DataDb;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// ---------------------------------------------------------
// CONFIGURACI�N DE SERVICIOS
// ---------------------------------------------------------
builder.Services.AddControllersWithViews();
builder.Services.AddSession(options =>
{
    options.IdleTimeout = TimeSpan.FromMinutes(30);
    options.Cookie.HttpOnly = true;
    options.Cookie.IsEssential = true;
});


// Leer la contrase�a desde User Secrets
var dbPassword = builder.Configuration["ConnectionStrings:DbPassword"];
var baseConnectionString = builder.Configuration.GetConnectionString("DefaultConnection");

// Construir la cadena de conexi�n completa
var connectionString = string.IsNullOrEmpty(dbPassword)
    ? baseConnectionString
    : $"{baseConnectionString};Password={dbPassword}";

AppContext.SetSwitch("Npgsql.EnableLegacyTimestampBehavior", false);
// Configurar DbContext con la cadena de conexi�n completa
builder.Services.AddDbContext<MedCitasDbContext>(options =>
    options.UseNpgsql(connectionString));


// ---------------------------------------------------------
// INYECCI�N DE DEPENDENCIAS
// ---------------------------------------------------------
builder.Services.AddScoped<IPacienteRepository, EfPacienteRepositorio>();
builder.Services.AddScoped<IEmailService, FakeEmailService>();
builder.Services.AddScoped<PacienteService>();

// ---------------------------------------------------------
// CONSTRUCCI�N DE LA APP
// ---------------------------------------------------------
var app = builder.Build();

// ---------------------------------------------------------
// CONFIGURACI�N DEL PIPELINE HTTP
// ---------------------------------------------------------
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles(); // Necesario para cargar CSS, JS, im�genes, etc.
app.UseRouting();
app.UseSession(); // Importante: antes de Authorization si usas sesiones
app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}"
);

await app.RunAsync();
