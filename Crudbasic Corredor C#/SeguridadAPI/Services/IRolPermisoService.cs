using SeguridadAPI.Entities;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace  SeguridadAPI.Services
{
    public interface IRolPermisoService
    {
        Task<IEnumerable<RolPermiso>> GetAllRolPermisosAsync();
        Task<RolPermiso?> GetRolPermisoAsync(int rolId, int permisoId);
        Task<RolPermiso> CreateRolPermisoAsync(RolPermiso rolPermiso);
        Task<RolPermiso?> UpdateRolPermisoAsync(RolPermiso rolPermiso);
        Task<bool> DeleteRolPermisoAsync(int rolId, int permisoId);
    }
}
