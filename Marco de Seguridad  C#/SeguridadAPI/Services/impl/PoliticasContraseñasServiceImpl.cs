using SeguridadAPI.Data;
using SeguridadAPI.Entities;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace SeguridadAPI.Services.Impl
{
    public class PoliticasContraseñasServiceImpl : IPoliticasContraseñasService
    {
        private readonly ApplicationDbContext _context;

        public PoliticasContraseñasServiceImpl(ApplicationDbContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<PoliticasContraseñas>> GetAllPoliticasAsync()
        {
            return await _context.PoliticasContraseñas.ToListAsync();
        }

        public async Task<PoliticasContraseñas?> GetPoliticaByIdAsync(int id)
        {
            return await _context.PoliticasContraseñas.FirstOrDefaultAsync(p => p.PoliticaID == id);
        }

        public async Task<PoliticasContraseñas> CreatePoliticaAsync(PoliticasContraseñas politica)
        {
            _context.PoliticasContraseñas.Add(politica);
            await _context.SaveChangesAsync();
            return politica;
        }

        public async Task<PoliticasContraseñas?> UpdatePoliticaAsync(PoliticasContraseñas politica)
        {
            var existing = await _context.PoliticasContraseñas.FindAsync(politica.PoliticaID);
            if (existing == null) return null;

            existing.MinLongitud = politica.MinLongitud;
            existing.MaxLongitud = politica.MaxLongitud;
            existing.RequiereMayusculas = politica.RequiereMayusculas;
            existing.RequiereNumeros = politica.RequiereNumeros;
            existing.RequiereSimbolos = politica.RequiereSimbolos;
            existing.CaducidadDias = politica.CaducidadDias;

            await _context.SaveChangesAsync();
            return existing;
        }

        public async Task<bool> DeletePoliticaAsync(int id)
        {
            var existing = await _context.PoliticasContraseñas.FindAsync(id);
            if (existing == null) return false;

            _context.PoliticasContraseñas.Remove(existing);
            await _context.SaveChangesAsync();
            return true;
        }
    }
}
