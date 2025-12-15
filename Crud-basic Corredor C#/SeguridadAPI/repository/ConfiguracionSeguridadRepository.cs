using SeguridadAPI.Data;
using SeguridadAPI.Entities;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Linq;

namespace SeguridadAPI.Data.Repositories
{
    public class ConfiguracionSeguridadRepository : Repository<ConfiguracionSeguridad>
    {
        public ConfiguracionSeguridadRepository(ApplicationDbContext context) : base(context) { }

        // Obtener configuración por nombre
        public ConfiguracionSeguridad? GetPorNombre(string nombre)
        {
            return _dbSet.FirstOrDefault(c => c.NombreConfiguracion == nombre);
        }

        // Obtener todas las configuraciones
        public IEnumerable<ConfiguracionSeguridad> GetTodas()
        {
            return _dbSet.ToList();
        }
    }
}
