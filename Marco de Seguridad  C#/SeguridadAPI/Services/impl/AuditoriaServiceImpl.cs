using SeguridadAPI.Data;
using SeguridadAPI.Entities;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace SeguridadAPI.Services.Impl
{
    // Implementación de IAuditoriaService
    // Aquí realizamos la lógica CRUD sobre la tabla Auditoria
    public class AuditoriaServiceImpl : IAuditoriaService
    {
        private readonly ApplicationDbContext _context;

        // Constructor que inyecta el DbContext
        public AuditoriaServiceImpl(ApplicationDbContext context)
        {
            _context = context;
        }

        // Obtener todas las auditorías
        public async Task<IEnumerable<Auditoria>> GetAllAuditoriasAsync()
        {
            // Include Usuario para traer los datos del usuario que realizó la acción
            return await _context.Auditorias
                .Include(a => a.Usuario)
                .ToListAsync();
        }

        // Obtener una auditoría específica por ID
        public async Task<Auditoria?> GetAuditoriaByIdAsync(int id)
        {
            // FirstOrDefaultAsync devuelve null si no existe
            return await _context.Auditorias
                .Include(a => a.Usuario)
                .FirstOrDefaultAsync(a => a.AuditoriaID == id);
        }

        // Crear una nueva auditoría
        public async Task<Auditoria> CreateAuditoriaAsync(Auditoria auditoria)
        {
            // Agrega la auditoría al contexto
            _context.Auditorias.Add(auditoria);
            // Guarda los cambios en la base de datos
            await _context.SaveChangesAsync();
            return auditoria;
        }

        // Actualizar una auditoría existente
        public async Task<Auditoria?> UpdateAuditoriaAsync(Auditoria auditoria)
        {
            // Buscamos la auditoría existente
            var existing = await _context.Auditorias.FindAsync(auditoria.AuditoriaID);
            if (existing == null) return null;

            // Actualizamos los campos
            existing.Accion = auditoria.Accion;
            existing.Descripcion = auditoria.Descripcion;
            existing.IP_Origen = auditoria.IP_Origen;
            existing.Aplicacion = auditoria.Aplicacion;
            existing.Fecha = auditoria.Fecha;
            existing.UsuarioID = auditoria.UsuarioID;

            // Guardamos los cambios
            await _context.SaveChangesAsync();
            return existing;
        }

        // Eliminar una auditoría
        public async Task<bool> DeleteAuditoriaAsync(int id)
        {
            // Buscamos la auditoría
            var existing = await _context.Auditorias.FindAsync(id);
            if (existing == null) return false;

            // Removemos del contexto y guardamos
            _context.Auditorias.Remove(existing);
            await _context.SaveChangesAsync();
            return true;
        }
    }
}
