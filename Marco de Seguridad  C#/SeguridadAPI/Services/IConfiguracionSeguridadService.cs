using SeguridadAPI.Entities;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace SeguridadAPI.Services
{
    // Interfaz para operaciones CRUD sobre la tabla ConfiguracionSeguridad
    public interface IConfiguracionSeguridadService
    {
        Task<IEnumerable<ConfiguracionSeguridad>> GetAllConfiguracionesAsync();
        Task<ConfiguracionSeguridad?> GetConfiguracionByIdAsync(int id);
        Task<ConfiguracionSeguridad> CreateConfiguracionAsync(ConfiguracionSeguridad config);
        Task<ConfiguracionSeguridad?> UpdateConfiguracionAsync(ConfiguracionSeguridad config);
        Task<bool> DeleteConfiguracionAsync(int id);
    }
}
