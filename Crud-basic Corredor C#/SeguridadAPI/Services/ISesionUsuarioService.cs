using SeguridadAPI.Entities;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace SeguridadAPI.Services
{
    public interface ISesionUsuarioService
    {
        Task<IEnumerable<SesionUsuario>> GetAllSesionesAsync();
        Task<SesionUsuario?> GetSesionByIdAsync(int id);
        Task<SesionUsuario> CreateSesionAsync(SesionUsuario sesion);
        Task<SesionUsuario?> UpdateSesionAsync(SesionUsuario sesion);
        Task<bool> DeleteSesionAsync(int id);
    }
}
