using SeguridadAPI.Entities;

namespace SeguridadAPI.Services
{
    public interface ILogErroresService
    {
        Task<IEnumerable<LogErrores>> GetAllLogsAsync();
        Task<LogErrores?> GetLogByIdAsync(int id);
        Task<LogErrores> CreateLogAsync(LogErrores log);
        Task<LogErrores?> UpdateLogAsync(LogErrores log);
        Task<bool> DeleteLogAsync(int id);
    }
}
