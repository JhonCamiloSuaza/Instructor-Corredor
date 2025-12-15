using Microsoft.AspNetCore.Mvc;
using SeguridadAPI.Entities;
using SeguridadAPI.Services;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace SeguridadAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class LogErroresController : ControllerBase
    {
        private readonly ILogErroresService _logErroresService;

        public LogErroresController(ILogErroresService logErroresService)
        {
            _logErroresService = logErroresService;
        }

        // GET: api/LogErrores
        [HttpGet]
        public async Task<ActionResult<IEnumerable<LogErrores>>> GetAll()
        {
            var logs = await _logErroresService.GetAllLogsAsync();
            return Ok(logs);
        }

        // GET: api/LogErrores/5
        [HttpGet("{id}")]
        public async Task<ActionResult<LogErrores>> GetById(int id)
        {
            var log = await _logErroresService.GetLogByIdAsync(id);
            if (log == null)
                return NotFound();

            return Ok(log);
        }

        // POST: api/LogErrores
        [HttpPost]
        public async Task<ActionResult<LogErrores>> Create([FromBody] LogErrores log)
        {
            var createdLog = await _logErroresService.CreateLogAsync(log);
            return CreatedAtAction(nameof(GetById), new { id = createdLog.ErrorID }, createdLog);
        }

        // PUT: api/LogErrores/5
        [HttpPut("{id}")]
        public async Task<ActionResult<LogErrores>> Update(int id, [FromBody] LogErrores log)
        {
            if (id != log.ErrorID)
                return BadRequest("El ID no coincide.");

            var updatedLog = await _logErroresService.UpdateLogAsync(log);
            if (updatedLog == null)
                return NotFound();

            return Ok(updatedLog);
        }

        // DELETE: api/LogErrores/5
        [HttpDelete("{id}")]
        public async Task<ActionResult> Delete(int id)
        {
            var deleted = await _logErroresService.DeleteLogAsync(id);
            if (!deleted)
                return NotFound();

            return NoContent();
        }
    }
}
