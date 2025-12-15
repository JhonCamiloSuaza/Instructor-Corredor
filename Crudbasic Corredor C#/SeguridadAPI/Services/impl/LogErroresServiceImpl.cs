using SeguridadAPI.Data;
using SeguridadAPI.Entities;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace SeguridadAPI.Services.Impl
{
    // Implementación de ILogErroresService
    public class LogErroresServiceImpl : ILogErroresService
    {
        private readonly ApplicationDbContext _context;

        public LogErroresServiceImpl(ApplicationDbContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<LogErrores>> GetAllLogsAsync()
        {
            return await _context.LogErrores
                .Include(l => l.Usuario)
                .ToListAsync();
        }

        public async Task<LogErrores?> GetLogByIdAsync(int id)
        {
            return await _context.LogErrores
                .Include(l => l.Usuario)
                .FirstOrDefaultAsync(l => l.ErrorID == id);
        }

        public async Task<LogErrores> CreateLogAsync(LogErrores log)
        {
            _context.LogErrores.Add(log);
            await _context.SaveChangesAsync();
            return log;
        }

        public async Task<LogErrores?> UpdateLogAsync(LogErrores log)
        {
            var existing = await _context.LogErrores.FindAsync(log.ErrorID);
            if (existing == null) return null;

            existing.TipoError = log.TipoError;
            existing.Descripcion = log.Descripcion;
            existing.IP_Origen = log.IP_Origen;
            existing.Fecha = log.Fecha;
            existing.UsuarioID = log.UsuarioID;

            await _context.SaveChangesAsync();
            return existing;
        }

        public async Task<bool> DeleteLogAsync(int id)
        {
            var existing = await _context.LogErrores.FindAsync(id);
            if (existing == null) return false;

            _context.LogErrores.Remove(existing);
            await _context.SaveChangesAsync();
            return true;
        }
    }
}
