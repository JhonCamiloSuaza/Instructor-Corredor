using SeguridadAPI.Data;
using SeguridadAPI.Entities;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace SeguridadAPI.Services.Impl
{
    // Implementación de IConfiguracionSeguridadService
    // Aquí manejamos la lógica CRUD sobre la tabla ConfiguracionSeguridad
    public class ConfiguracionSeguridadServiceImpl : IConfiguracionSeguridadService
    {
        private readonly ApplicationDbContext _context;

        // Constructor que inyecta el DbContext
        public ConfiguracionSeguridadServiceImpl(ApplicationDbContext context)
        {
            _context = context;
        }

        // Obtener todas las configuraciones de seguridad
        public async Task<IEnumerable<ConfiguracionSeguridad>> GetAllConfiguracionesAsync()
        {
            return await _context.ConfiguracionSeguridad.ToListAsync();
        }

        // Obtener una configuración específica por ID
        public async Task<ConfiguracionSeguridad?> GetConfiguracionByIdAsync(int id)
        {
            // FindAsync devuelve null si no existe
            return await _context.ConfiguracionSeguridad.FindAsync(id);
        }

        // Crear una nueva configuración
        public async Task<ConfiguracionSeguridad> CreateConfiguracionAsync(ConfiguracionSeguridad config)
        {
            _context.ConfiguracionSeguridad.Add(config); // Agregamos al contexto
            await _context.SaveChangesAsync();           // Guardamos cambios
            return config;
        }

        // Actualizar una configuración existente
        public async Task<ConfiguracionSeguridad?> UpdateConfiguracionAsync(ConfiguracionSeguridad config)
        {
            var existing = await _context.ConfiguracionSeguridad.FindAsync(config.ConfiguracionID);
            if (existing == null) return null;

            // Actualizamos campos
            existing.NombreConfiguracion = config.NombreConfiguracion;
            existing.ValorConfiguracion = config.ValorConfiguracion;
            existing.Descripcion = config.Descripcion;

            await _context.SaveChangesAsync(); // Guardamos cambios
            return existing;
        }

        // Eliminar una configuración por ID
        public async Task<bool> DeleteConfiguracionAsync(int id)
        {
            var existing = await _context.ConfiguracionSeguridad.FindAsync(id);
            if (existing == null) return false;

            _context.ConfiguracionSeguridad.Remove(existing); // Removemos del contexto
            await _context.SaveChangesAsync();               // Guardamos cambios
            return true;
        }
    }
}
