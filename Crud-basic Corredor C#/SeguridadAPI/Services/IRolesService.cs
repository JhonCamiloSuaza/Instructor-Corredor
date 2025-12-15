using SeguridadAPI.Entities;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace SeguridadAPI.Services
{
    // Interfaz para operaciones CRUD sobre la tabla Roles
    public interface IRolesService
    {
        Task<IEnumerable<Roles>> GetAllRolesAsync();
        Task<Roles?> GetRolByIdAsync(int id);
        Task<Roles> CreateRolAsync(Roles rol);
        Task<Roles?> UpdateRolAsync(Roles rol);
        Task<bool> DeleteRolAsync(int id);
    }
}
