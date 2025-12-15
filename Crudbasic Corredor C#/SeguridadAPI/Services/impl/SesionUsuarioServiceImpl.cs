using SeguridadAPI.Data;
using SeguridadAPI.Entities;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace SeguridadAPI.Services.Impl
{
    public class SesionUsuarioServiceImpl : ISesionUsuarioService
    {
        private readonly ApplicationDbContext _context;

        public SesionUsuarioServiceImpl(ApplicationDbContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<SesionUsuario>> GetAllSesionesAsync()
        {
            return await _context.SesionUsuarios
                .Include(s => s.Usuario)
                .ToListAsync();
        }

        public async Task<SesionUsuario?> GetSesionByIdAsync(int id)
        {
            return await _context.SesionUsuarios
                .Include(s => s.Usuario)
                .FirstOrDefaultAsync(s => s.SesionID == id);
        }

        public async Task<SesionUsuario> CreateSesionAsync(SesionUsuario sesion)
        {
            _context.SesionUsuarios.Add(sesion);
            await _context.SaveChangesAsync();
            return sesion;
        }

        public async Task<SesionUsuario?> UpdateSesionAsync(SesionUsuario sesion)
        {
            var existing = await _context.SesionUsuarios.FindAsync(sesion.SesionID);
            if (existing == null) return null;

            existing.UsuarioID = sesion.UsuarioID;
            existing.FechaInicio = sesion.FechaInicio;
            existing.FechaFin = sesion.FechaFin;
            existing.IP_Origen = sesion.IP_Origen;
            existing.EstadoSesion = sesion.EstadoSesion;

            await _context.SaveChangesAsync();
            return existing;
        }

        public async Task<bool> DeleteSesionAsync(int id)
        {
            var existing = await _context.SesionUsuarios.FindAsync(id);
            if (existing == null) return false;

            _context.SesionUsuarios.Remove(existing);
            await _context.SaveChangesAsync();
            return true;
        }
    }
}
