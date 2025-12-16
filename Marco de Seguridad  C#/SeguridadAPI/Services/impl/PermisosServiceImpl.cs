using SeguridadAPI.Data;
using SeguridadAPI.Entities;
using Microsoft.EntityFrameworkCore;

namespace SeguridadAPI.Services.Impl
{
    public class PermisosServiceImpl : IPermisosService
    {
        private readonly ApplicationDbContext _context;

        public PermisosServiceImpl(ApplicationDbContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<Permisos>> GetAllAsync()
        {
            return await _context.Permisos
                .Include(p => p.RolPermisos)
                .ToListAsync();
        }

        public async Task<Permisos?> GetByIdAsync(int id)
        {
            return await _context.Permisos
                .Include(p => p.RolPermisos)
                .FirstOrDefaultAsync(p => p.PermisoID == id);
        }

        public async Task<Permisos> CreateAsync(Permisos permiso)
        {
            _context.Permisos.Add(permiso);
            await _context.SaveChangesAsync();
            return permiso;
        }

        public async Task<Permisos?> UpdateAsync(int id, Permisos permiso)
        {
            var existing = await _context.Permisos.FindAsync(id);
            if (existing == null) return null;

            existing.NombrePermiso = permiso.NombrePermiso;
            existing.Descripcion = permiso.Descripcion;

            await _context.SaveChangesAsync();
            return existing;
        }

        public async Task<bool> DeleteAsync(int id)
        {
            var existing = await _context.Permisos.FindAsync(id);
            if (existing == null) return false;

            _context.Permisos.Remove(existing);
            await _context.SaveChangesAsync();
            return true;
        }
    }
}
