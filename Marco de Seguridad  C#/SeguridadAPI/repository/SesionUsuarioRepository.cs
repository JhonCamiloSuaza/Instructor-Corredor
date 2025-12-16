using SeguridadAPI.Data;
using SeguridadAPI.Entities;
using Microsoft.EntityFrameworkCore;

namespace SeguridadAPI.Data.Repositories
{
    public class SesionUsuarioRepository : Repository<SesionUsuario>
    {
        public SesionUsuarioRepository(ApplicationDbContext context) : base(context) { }

        // Obtener sesiones activas de un usuario
        public IEnumerable<SesionUsuario> GetSesionesActivas(int usuarioId)
        {
            return _dbSet
                .Where(s => s.UsuarioID == usuarioId && s.EstadoSesion == "Activo")
                .Include(s => s.Usuario)
                .ToList();
        }

        // Cerrar sesión
        public void CerrarSesion(int sesionId)
        {
            var sesion = _dbSet.FirstOrDefault(s => s.SesionID == sesionId);
            if (sesion != null)
            {
                sesion.EstadoSesion = "Cerrado";
                sesion.FechaFin = DateTime.Now;
            }
        }
    }
}
