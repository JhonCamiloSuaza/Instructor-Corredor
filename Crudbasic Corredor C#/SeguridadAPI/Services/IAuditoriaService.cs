using SeguridadAPI.Entities;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace SeguridadAPI.Services
{
    // Interfaz para operaciones CRUD sobre la tabla Auditoria
    public interface IAuditoriaService
    {
        Task<IEnumerable<Auditoria>> GetAllAuditoriasAsync();
        Task<Auditoria?> GetAuditoriaByIdAsync(int id);
        Task<Auditoria> CreateAuditoriaAsync(Auditoria auditoria);
        Task<Auditoria?> UpdateAuditoriaAsync(Auditoria auditoria);
        Task<bool> DeleteAuditoriaAsync(int id);
    }
}
