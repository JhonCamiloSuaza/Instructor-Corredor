using SeguridadAPI.Data;
using SeguridadAPI.Entities;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace SeguridadAPI.Services.Impl
{
    // Implementación de IRolesService
    public class RolesServiceImpl : IRolesService
    {
        private readonly ApplicationDbContext _context;

        public RolesServiceImpl(ApplicationDbContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<Roles>> GetAllRolesAsync()
        {
            return await _context.Roles
                .Include(r => r.UsuarioRoles)
                .Include(r => r.RolPermisos)
                .ToListAsync();
        }

        public async Task<Roles?> GetRolByIdAsync(int id)
        {
            return await _context.Roles
                .Include(r => r.UsuarioRoles)
                .Include(r => r.RolPermisos)
                .FirstOrDefaultAsync(r => r.RolID == id);
        }

        public async Task<Roles> CreateRolAsync(Roles rol)
        {
            _context.Roles.Add(rol);
            await _context.SaveChangesAsync();
            return rol;
        }

        public async Task<Roles?> UpdateRolAsync(Roles rol)
        {
            var existing = await _context.Roles.FindAsync(rol.RolID);
            if (existing == null) return null;

            existing.NombreRol = rol.NombreRol;
            existing.Descripcion = rol.Descripcion;

            await _context.SaveChangesAsync();
            return existing;
        }

        public async Task<bool> DeleteRolAsync(int id)
        {
            var existing = await _context.Roles.FindAsync(id);
            if (existing == null) return false;

            _context.Roles.Remove(existing);
            await _context.SaveChangesAsync();
            return true;
        }
    }
}
