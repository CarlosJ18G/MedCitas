using MedCitas.Core.Interfaces;
using MedCitas.Core.Services;
using MedCitas.Infrastructure.Repositories;
using MedCitas.Infrastructure.Services;

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

// ---------------------------------------------------------
// INYECCI�N DE DEPENDENCIAS
// ---------------------------------------------------------
builder.Services.AddSingleton<IPacienteRepository, InMemoryPacienteRepository>();
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

app.Run();
