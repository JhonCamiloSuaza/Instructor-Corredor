using SeguridadAPI.Data;
using SeguridadAPI.Entities;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace SeguridadAPI.Services.Impl
{
    // Implementación de IUsuarioRolService
    public class UsuarioRolServiceImpl : IUsuarioRolService
    {
        private readonly ApplicationDbContext _context;

        public UsuarioRolServiceImpl(ApplicationDbContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<UsuarioRol>> GetAllUsuarioRolesAsync()
        {
            return await _context.UsuarioRoles
                .Include(ur => ur.Usuario)
                .Include(ur => ur.Rol)
                .ToListAsync();
        }

        public async Task<UsuarioRol?> GetUsuarioRolAsync(int usuarioId, int rolId)
        {
            return await _context.UsuarioRoles
                .Include(ur => ur.Usuario)
                .Include(ur => ur.Rol)
                .FirstOrDefaultAsync(ur => ur.UsuarioID == usuarioId && ur.RolID == rolId);
        }

        public async Task<UsuarioRol> CreateUsuarioRolAsync(UsuarioRol usuarioRol)
        {
            _context.UsuarioRoles.Add(usuarioRol);
            await _context.SaveChangesAsync();
            return usuarioRol;
        }

        public async Task<UsuarioRol?> UpdateUsuarioRolAsync(UsuarioRol usuarioRol)
        {
            var existing = await _context.UsuarioRoles
                .FirstOrDefaultAsync(ur => ur.UsuarioID == usuarioRol.UsuarioID && ur.RolID == usuarioRol.RolID);
            if (existing == null) return null;

            existing.FechaAsignacion = usuarioRol.FechaAsignacion;

            await _context.SaveChangesAsync();
            return existing;
        }

        public async Task<bool> DeleteUsuarioRolAsync(int usuarioId, int rolId)
        {
            var existing = await _context.UsuarioRoles
                .FirstOrDefaultAsync(ur => ur.UsuarioID == usuarioId && ur.RolID == rolId);
            if (existing == null) return false;

            _context.UsuarioRoles.Remove(existing);
            await _context.SaveChangesAsync();
            return true;
        }
    }
}
