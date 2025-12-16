using Microsoft.AspNetCore.Mvc;
using SeguridadAPI.Entities;
using SeguridadAPI.Services;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace SeguridadAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PermisosController : ControllerBase
    {
        private readonly IPermisosService _permisosService;

        public PermisosController(IPermisosService permisosService)
        {
            _permisosService = permisosService;
        }

        // GET: api/Permisos
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Permisos>>> GetAll()
        {
            var permisos = await _permisosService.GetAllAsync();
            return Ok(permisos);
        }

        // GET: api/Permisos/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Permisos>> GetById(int id)
        {
            var permiso = await _permisosService.GetByIdAsync(id);
            if (permiso == null)
                return NotFound();

            return Ok(permiso);
        }

        // POST: api/Permisos
        [HttpPost]
        public async Task<ActionResult<Permisos>> Create([FromBody] Permisos permiso)
        {
            var created = await _permisosService.CreateAsync(permiso);
            return CreatedAtAction(nameof(GetById), new { id = created.PermisoID }, created);
        }

        // PUT: api/Permisos/5
        [HttpPut("{id}")]
        public async Task<ActionResult<Permisos>> Update(int id, [FromBody] Permisos permiso)
        {
            if (id != permiso.PermisoID)
                return BadRequest("El ID no coincide.");

            var updated = await _permisosService.UpdateAsync(permiso.PermisoID, permiso);
            if (updated == null)
                return NotFound();

            return Ok(updated);
        }

        // DELETE: api/Permisos/5
        [HttpDelete("{id}")]
        public async Task<ActionResult> Delete(int id)
        {
            var deleted = await _permisosService.DeleteAsync(id);
            if (!deleted)
                return NotFound();

            return NoContent();
        }
    }
}
