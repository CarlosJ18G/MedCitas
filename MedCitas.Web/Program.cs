using MedCitas.Core.Interfaces;
using MedCitas.Core.Services;
using MedCitas.Infrastructure.Repositories;
using MedCitas.Infrastructure.Services;
using MedCitas.Infrastructure.DataDb;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// ---------------------------------------------------------
// CONFIGURACIÓN DE SERVICIOS
// ---------------------------------------------------------
builder.Services.AddControllersWithViews();
builder.Services.AddSession(options =>
{
    options.IdleTimeout = TimeSpan.FromMinutes(30);
    options.Cookie.HttpOnly = true;
    options.Cookie.IsEssential = true;
});

builder.Services.AddDbContext<MedCitasDbContext>(options =>
    options.UseNpgsql(builder.Configuration.GetConnectionString("DefaultConnection")));

// ---------------------------------------------------------
// INYECCIÓN DE DEPENDENCIAS
// ---------------------------------------------------------
builder.Services.AddScoped<IPacienteRepository, EfPacienteRepositorio>();
builder.Services.AddScoped<IEmailService, FakeEmailService>();
builder.Services.AddScoped<PacienteService>();

// ---------------------------------------------------------
// CONSTRUCCIÓN DE LA APP
// ---------------------------------------------------------
var app = builder.Build();

// ---------------------------------------------------------
// CONFIGURACIÓN DEL PIPELINE HTTP
// ---------------------------------------------------------
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles(); // Necesario para cargar CSS, JS, imágenes, etc.
app.UseRouting();
app.UseSession(); // Importante: antes de Authorization si usas sesiones
app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}"
);

app.Run();
