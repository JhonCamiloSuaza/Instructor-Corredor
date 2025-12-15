using SeguridadAPI.Entities;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace SeguridadAPI.Services
{
    public interface IPermisosService
    {
        Task<IEnumerable<Permisos>> GetAllAsync();
        Task<Permisos?> GetByIdAsync(int id);
        Task<Permisos> CreateAsync(Permisos permiso);
        Task<Permisos?> UpdateAsync(int id, Permisos permiso);
        Task<bool> DeleteAsync(int id);
    }
}
