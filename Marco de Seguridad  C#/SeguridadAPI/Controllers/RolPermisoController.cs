using Microsoft.AspNetCore.Mvc;
using SeguridadAPI.Entities;
using SeguridadAPI.Services;

namespace SeguridadAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class RolPermisoController : ControllerBase
    {
        private readonly IRolPermisoService _service;

        public RolPermisoController(IRolPermisoService service)
        {
            _service = service;
        }

        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            var lista = await _service.GetAllRolPermisosAsync();
            return Ok(lista);
        }

        [HttpGet("{rolId}/{permisoId}")]
        public async Task<IActionResult> GetByIds(int rolId, int permisoId)
        {
            var rp = await _service.GetRolPermisoAsync(rolId, permisoId);
            if (rp == null) return NotFound();
            return Ok(rp);
        }

        [HttpPost]
        public async Task<IActionResult> Create([FromBody] RolPermiso model)
        {
            var created = await _service.CreateRolPermisoAsync(model);
            return CreatedAtAction(nameof(GetByIds), new { rolId = created.RolID, permisoId = created.PermisoID }, created);
        }

        [HttpPut]
        public async Task<IActionResult> Update([FromBody] RolPermiso model)
        {
            var updated = await _service.UpdateRolPermisoAsync(model);
            if (updated == null) return NotFound();
            return Ok(updated);
        }

        [HttpDelete("{rolId}/{permisoId}")]
        public async Task<IActionResult> Delete(int rolId, int permisoId)
        {
            var deleted = await _service.DeleteRolPermisoAsync(rolId, permisoId);
            if (!deleted) return NotFound();

            return NoContent();
        }
    }
}
