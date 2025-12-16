using Microsoft.EntityFrameworkCore;
using SeguridadAPI.Data;
using SeguridadAPI.Services;
using SeguridadAPI.Services.Impl;
using SeguridadAPI.Data.Repositories;
var builder = WebApplication.CreateBuilder(args);

// =====================================
//  1. Agregar DbContext (SQL Server)
// =====================================
builder.Services.AddDbContext<ApplicationDbContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));

// =====================================
//  2. Registrar Services
// =====================================
builder.Services.AddScoped<IUsuarioService, UsuarioServiceImpl>();
builder.Services.AddScoped<IPasswordPolicyService, PasswordPolicyServiceImpl>();

builder.Services.AddScoped<IRolesService, RolesServiceImpl>();
builder.Services.AddScoped<IUsuarioRolService, UsuarioRolServiceImpl>();
builder.Services.AddScoped<IPermisosService, PermisosServiceImpl>();

builder.Services.AddScoped<IRolPermisoService, RolPermisoServiceImpl>();
builder.Services.AddScoped<IAuditoriaService, AuditoriaServiceImpl>();
builder.Services.AddScoped<ISesionUsuarioService, SesionUsuarioServiceImpl>();
builder.Services.AddScoped<ILogErroresService, LogErroresServiceImpl>();
builder.Services.AddScoped<IConfiguracionSeguridadService, ConfiguracionSeguridadServiceImpl>();
builder.Services.AddScoped<IPoliticasContraseñasService, PoliticasContraseñasServiceImpl>();

builder.Services.AddScoped<UsuarioRepository>();
builder.Services.AddScoped<UsuarioRolRepository>();
builder.Services.AddScoped<SesionUsuarioRepository>();
builder.Services.AddScoped<RolPermisoRepository>();
builder.Services.AddScoped<RolesRepository>();
builder.Services.AddScoped<PoliticasContraseñasRepository>();
builder.Services.AddScoped<PermisosRepository>();
builder.Services.AddScoped<LogErroresRepository>();
builder.Services.AddScoped<ConfiguracionSeguridadRepository>();
builder.Services.AddScoped<AuditoriaRepository>();



// =====================================
//  3. Swagger / OpenAPI
// =====================================
builder.Services.AddOpenApi();

// =====================================
//  4. Construir App
// =====================================
var app = builder.Build();

// =====================================
//  5. Swagger en desarrollo
// =====================================
if (app.Environment.IsDevelopment())
{
    app.MapOpenApi();
}

app.UseHttpsRedirection();

// =====================================
//  6. Endpoint de prueba (el default)
// =====================================
var summaries = new[]
{
    "Freezing", "Bracing", "Chilly", "Cool", "Mild", "Warm", "Balmy", "Hot", "Sweltering", "Scorching"
};

app.MapGet("/weatherforecast", () =>
{
    var forecast =  Enumerable.Range(1, 5).Select(index =>
        new WeatherForecast
        (
            DateOnly.FromDateTime(DateTime.Now.AddDays(index)),
            Random.Shared.Next(-20, 55),
            summaries[Random.Shared.Next(summaries.Length)]
        ))
        .ToArray();
    return forecast;
})
.WithName("GetWeatherForecast");

app.Run();

record WeatherForecast(DateOnly Date, int TemperatureC, string? Summary)
{
    public int TemperatureF => 32 + (int)(TemperatureC / 0.5556);
}


/* AddDbContext → Configura tu base de datos.

AddScoped<IService, Impl>() → Registra todos tus Services para inyección de dependencias.

AddOpenApi() → Swagger para documentar tu API.

builder.Build() → Construye la app.
app.MapOpenApi() → Habilita Swagger en desarrollo.
*/