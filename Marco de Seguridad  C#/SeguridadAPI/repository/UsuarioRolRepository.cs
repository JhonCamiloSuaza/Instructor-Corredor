using SeguridadAPI.Data;
using SeguridadAPI.Entities;
using Microsoft.EntityFrameworkCore;

namespace SeguridadAPI.Data.Repositories
{
    public class UsuarioRolRepository : Repository<UsuarioRol>
    {
        public UsuarioRolRepository(ApplicationDbContext context) : base(context) { }

        // Método para obtener roles de un usuario específico
        public IEnumerable<UsuarioRol> GetRolesByUsuarioId(int usuarioId)
        {
            return _dbSet
                .Include(ur => ur.Rol)
                .Where(ur => ur.UsuarioID == usuarioId)
                .ToList();
        }

        // Método para obtener usuarios de un rol específico
        public IEnumerable<UsuarioRol> GetUsuariosByRolId(int rolId)
        {
            return _dbSet
                .Include(ur => ur.Usuario)
                .Where(ur => ur.RolID == rolId)
                .ToList();
        }
    }
}
