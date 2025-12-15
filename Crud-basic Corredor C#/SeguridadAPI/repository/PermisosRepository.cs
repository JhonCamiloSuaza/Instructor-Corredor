using SeguridadAPI.Data;
using SeguridadAPI.Entities;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Linq;

namespace SeguridadAPI.Data.Repositories
{
    public class PermisosRepository : Repository<Permisos>
    {
        public PermisosRepository(ApplicationDbContext context) : base(context) { }

        // Obtener todos los permisos asignados a un rol específico
        public IEnumerable<Permisos> GetPermisosPorRol(int rolID)
        {
            return _dbSet
                .Include(p => p.RolPermisos)
                .Where(p => p.RolPermisos.Any(rp => rp.RolID == rolID))
                .ToList();
        }
    }
}
