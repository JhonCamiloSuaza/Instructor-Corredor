using SeguridadAPI.Data;
using SeguridadAPI.Entities;
using Microsoft.EntityFrameworkCore;

namespace SeguridadAPI.Data.Repositories
{
    public class PoliticasContraseñasRepository : Repository<PoliticasContraseñas>
    {
        public PoliticasContraseñasRepository(ApplicationDbContext context) : base(context) { }

        // Obtener la política activa más reciente (puedes definir la lógica según tu necesidad)
        public PoliticasContraseñas? GetPoliticaActual()
        {
            return _dbSet
                .OrderByDescending(p => p.PoliticaID)
                .FirstOrDefault();
        }
    }
}
