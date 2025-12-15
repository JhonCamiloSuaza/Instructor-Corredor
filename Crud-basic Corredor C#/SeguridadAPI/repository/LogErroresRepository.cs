using SeguridadAPI.Data;
using SeguridadAPI.Entities;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;

namespace SeguridadAPI.Data.Repositories
{
    public class LogErroresRepository : Repository<LogErrores>
    {
        public LogErroresRepository(ApplicationDbContext context) : base(context) { }

        // Obtener todos los logs de un usuario específico
        public IEnumerable<LogErrores> GetLogsPorUsuario(int usuarioID)
        {
            return _dbSet
                .Include(l => l.Usuario)
                .Where(l => l.UsuarioID == usuarioID)
                .OrderByDescending(l => l.Fecha)
                .ToList();
        }

        // Obtener logs en un rango de fechas
        public IEnumerable<LogErrores> GetLogsPorFechas(DateTime desde, DateTime hasta)
        {
            return _dbSet
                .Include(l => l.Usuario)
                .Where(l => l.Fecha >= desde && l.Fecha <= hasta)
                .OrderByDescending(l => l.Fecha)
                .ToList();
        }
    }
}
