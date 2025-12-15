using SeguridadAPI.Data;
using SeguridadAPI.Entities;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;

namespace SeguridadAPI.Data.Repositories
{
    public class AuditoriaRepository : Repository<Auditoria>
    {
        public AuditoriaRepository(ApplicationDbContext context) : base(context) { }

        // Obtener auditorías por UsuarioID
        public IEnumerable<Auditoria> GetPorUsuario(int usuarioID)
        {
            return _dbSet
                .Include(a => a.Usuario)
                .Where(a => a.UsuarioID == usuarioID)
                .OrderByDescending(a => a.Fecha)
                .ToList();
        }

        // Obtener auditorías por rango de fechas
        public IEnumerable<Auditoria> GetPorRangoFecha(DateTime inicio, DateTime fin)
        {
            return _dbSet
                .Include(a => a.Usuario)
                .Where(a => a.Fecha >= inicio && a.Fecha <= fin)
                .OrderByDescending(a => a.Fecha)
                .ToList();
        }

        // Últimas N auditorías
        public IEnumerable<Auditoria> GetUltimas(int cantidad)
        {
            return _dbSet
                .Include(a => a.Usuario)
                .OrderByDescending(a => a.Fecha)
                .Take(cantidad)
                .ToList();
        }
    }
}
