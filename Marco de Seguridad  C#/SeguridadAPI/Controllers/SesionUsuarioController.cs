using Microsoft.AspNetCore.Mvc;
using SeguridadAPI.Entities;
using SeguridadAPI.Services;

namespace SeguridadAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class SesionUsuarioController : ControllerBase
    {
        private readonly ISesionUsuarioService _service;

        public SesionUsuarioController(ISesionUsuarioService service)
        {
            _service = service;
        }

        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            var sesiones = await _service.GetAllSesionesAsync();
            return Ok(sesiones);
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetById(int id)
        {
            var sesion = await _service.GetSesionByIdAsync(id);
            if (sesion == null) return NotFound();
            return Ok(sesion);
        }

        [HttpPost]
        public async Task<IActionResult> Create([FromBody] SesionUsuario sesion)
        {
            var created = await _service.CreateSesionAsync(sesion);
            return CreatedAtAction(nameof(GetById), new { id = created.SesionID }, created);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> Update(int id, [FromBody] SesionUsuario sesion)
        {
            if (id != sesion.SesionID) return BadRequest("El ID no coincide");

            var updated = await _service.UpdateSesionAsync(sesion);
            if (updated == null) return NotFound();

            return Ok(updated);
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(int id)
        {
            var deleted = await _service.DeleteSesionAsync(id);
            if (!deleted) return NotFound();

            return NoContent();
        }
    }
}
