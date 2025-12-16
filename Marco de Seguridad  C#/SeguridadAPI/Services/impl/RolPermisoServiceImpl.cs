using SeguridadAPI.Data;
using SeguridadAPI.Entities;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace SeguridadAPI.Services.Impl
{
    public class RolPermisoServiceImpl : IRolPermisoService
    {
        private readonly ApplicationDbContext _context;

        public RolPermisoServiceImpl(ApplicationDbContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<RolPermiso>> GetAllRolPermisosAsync()
        {
            return await _context.RolPermisos
                .Include(rp => rp.Rol)
                .Include(rp => rp.Permiso)
                .ToListAsync();
        }

        public async Task<RolPermiso?> GetRolPermisoAsync(int rolId, int permisoId)
        {
            return await _context.RolPermisos
                .Include(rp => rp.Rol)
                .Include(rp => rp.Permiso)
                .FirstOrDefaultAsync(rp => rp.RolID == rolId && rp.PermisoID == permisoId);
        }

        public async Task<RolPermiso> CreateRolPermisoAsync(RolPermiso rolPermiso)
        {
            _context.RolPermisos.Add(rolPermiso);
            await _context.SaveChangesAsync();
            return rolPermiso;
        }

        public async Task<RolPermiso?> UpdateRolPermisoAsync(RolPermiso rolPermiso)
        {
            var existing = await _context.RolPermisos
                .FirstOrDefaultAsync(rp => rp.RolID == rolPermiso.RolID && rp.PermisoID == rolPermiso.PermisoID);

            if (existing == null) return null;

            existing.FechaAsignacion = rolPermiso.FechaAsignacion;

            await _context.SaveChangesAsync();
            return existing;
        }

        public async Task<bool> DeleteRolPermisoAsync(int rolId, int permisoId)
        {
            var existing = await _context.RolPermisos
                .FirstOrDefaultAsync(rp => rp.RolID == rolId && rp.PermisoID == permisoId);

            if (existing == null) return false;

            _context.RolPermisos.Remove(existing);
            await _context.SaveChangesAsync();
            return true;
        }
    }
}
