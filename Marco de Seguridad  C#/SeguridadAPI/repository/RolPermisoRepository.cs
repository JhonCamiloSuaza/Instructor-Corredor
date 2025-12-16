using SeguridadAPI.Data;
using SeguridadAPI.Entities;
using Microsoft.EntityFrameworkCore;

namespace SeguridadAPI.Data.Repositories
{
    public class RolPermisoRepository : Repository<RolPermiso>
    {
        public RolPermisoRepository(ApplicationDbContext context) : base(context) { }

        // Obtener todos los permisos de un rol
        public IEnumerable<RolPermiso> GetPermisosPorRol(int rolId)
        {
            return _dbSet
                .Where(rp => rp.RolID == rolId)
                .Include(rp => rp.Permiso)
                .ToList();
        }

        // Verificar si un rol ya tiene un permiso asignado
        public bool ExistePermiso(int rolId, int permisoId)
        {
            return _dbSet.Any(rp => rp.RolID == rolId && rp.PermisoID == permisoId);
        }
    }
}
