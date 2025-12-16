using SeguridadAPI.Entities;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace SeguridadAPI.Services
{
    // Interfaz para operaciones CRUD sobre la tabla intermedia UsuarioRoles
    public interface IUsuarioRolService
    {
        Task<IEnumerable<UsuarioRol>> GetAllUsuarioRolesAsync();
        Task<UsuarioRol?> GetUsuarioRolAsync(int usuarioId, int rolId);
        Task<UsuarioRol> CreateUsuarioRolAsync(UsuarioRol usuarioRol);
        Task<UsuarioRol?> UpdateUsuarioRolAsync(UsuarioRol usuarioRol);
        Task<bool> DeleteUsuarioRolAsync(int usuarioId, int rolId);
    }
}
