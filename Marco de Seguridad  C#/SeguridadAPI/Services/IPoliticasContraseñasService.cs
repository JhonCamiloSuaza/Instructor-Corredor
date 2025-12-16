using SeguridadAPI.Entities;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace SeguridadAPI.Services
{
    public interface IPoliticasContraseñasService
    {
        Task<IEnumerable<PoliticasContraseñas>> GetAllPoliticasAsync();
        Task<PoliticasContraseñas?> GetPoliticaByIdAsync(int id);
        Task<PoliticasContraseñas> CreatePoliticaAsync(PoliticasContraseñas politica);
        Task<PoliticasContraseñas?> UpdatePoliticaAsync(PoliticasContraseñas politica);
        Task<bool> DeletePoliticaAsync(int id);
    }
}
