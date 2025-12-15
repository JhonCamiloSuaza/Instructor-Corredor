using SeguridadAPI.Data;
using SeguridadAPI.Entities;
using Microsoft.EntityFrameworkCore;

namespace SeguridadAPI.Data.Repositories
{
    public class RolesRepository : Repository<Roles>
    {
        public RolesRepository(ApplicationDbContext context) : base(context) { }

        // Obtener un rol por nombre
        public Roles? GetPorNombre(string nombreRol)
        {
            return _dbSet.FirstOrDefault(r => r.NombreRol == nombreRol);
        }

        // Listar todos los permisos asociados a un rol
        public IEnumerable<RolPermiso> GetPermisos(Roles rol)
        {
            return _context.RolPermisos
                .Where(rp => rp.RolID == rol.RolID)
                .Include(rp => rp.Permiso)
                .ToList();
        }
    }
}
