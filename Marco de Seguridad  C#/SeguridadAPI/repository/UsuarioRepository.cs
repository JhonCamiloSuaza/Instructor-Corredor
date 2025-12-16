using SeguridadAPI.Data;
using SeguridadAPI.Entities;
using Microsoft.EntityFrameworkCore;

namespace SeguridadAPI.Data.Repositories
{
    public class UsuarioRepository : Repository<Usuario>
    {
        public UsuarioRepository(ApplicationDbContext context) : base(context) { }

        // Método específico para buscar usuario por nombre
        public Usuario? GetByNombreUsuario(string nombreUsuario)
        {
            return _dbSet
                .Include(u => u.UsuarioRoles)
                    .ThenInclude(ur => ur.Rol)
                .Include(u => u.Sesiones)
                .Include(u => u.Auditorias)
                .Include(u => u.LogsErrores)
                .FirstOrDefault(u => u.NombreUsuario == nombreUsuario);
        }
    }
}
