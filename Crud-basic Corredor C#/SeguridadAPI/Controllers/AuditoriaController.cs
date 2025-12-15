using Microsoft.AspNetCore.Mvc;
using SeguridadAPI.Entities;
using SeguridadAPI.Services;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace SeguridadAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AuditoriaController : ControllerBase
    {
        private readonly IAuditoriaService _auditoriaService;

        public AuditoriaController(IAuditoriaService auditoriaService)
        {
            _auditoriaService = auditoriaService;
        }

        // GET: api/Auditoria
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Auditoria>>> GetAll()
        {
            var auditorias = await _auditoriaService.GetAllAuditoriasAsync();
            return Ok(auditorias);
        }

        // GET: api/Auditoria/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Auditoria>> GetById(int id)
        {
            var auditoria = await _auditoriaService.GetAuditoriaByIdAsync(id);
            if (auditoria == null)
                return NotFound();

            return Ok(auditoria);
        }

        // POST: api/Auditoria
        [HttpPost]
        public async Task<ActionResult<Auditoria>> Create([FromBody] Auditoria auditoria)
        {
            var created = await _auditoriaService.CreateAuditoriaAsync(auditoria);
            return CreatedAtAction(nameof(GetById), new { id = created.AuditoriaID }, created);
        }

        // PUT: api/Auditoria/5
        [HttpPut("{id}")]
        public async Task<ActionResult<Auditoria>> Update(int id, [FromBody] Auditoria auditoria)
        {
            if (id != auditoria.AuditoriaID)
                return BadRequest("El ID no coincide.");

            var updated = await _auditoriaService.UpdateAuditoriaAsync(auditoria);
            if (updated == null)
                return NotFound();

            return Ok(updated);
        }

        // DELETE: api/Auditoria/5
        [HttpDelete("{id}")]
        public async Task<ActionResult> Delete(int id)
        {
            var deleted = await _auditoriaService.DeleteAuditoriaAsync(id);
            if (!deleted)
                return NotFound();

            return NoContent();
        }
    }
}
