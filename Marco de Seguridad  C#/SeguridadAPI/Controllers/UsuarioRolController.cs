using Microsoft.AspNetCore.Mvc;
using SeguridadAPI.Entities;
using SeguridadAPI.Services;

namespace SeguridadAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class UsuarioRolController : ControllerBase
    {
        private readonly IUsuarioRolService _usuarioRolService;

        public UsuarioRolController(IUsuarioRolService usuarioRolService)
        {
            _usuarioRolService = usuarioRolService;
        }

        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            var data = await _usuarioRolService.GetAllUsuarioRolesAsync();
            return Ok(data);
        }

        [HttpGet("{usuarioId}/{rolId}")]
        public async Task<IActionResult> GetByIds(int usuarioId, int rolId)
        {
            var data = await _usuarioRolService.GetUsuarioRolAsync(usuarioId, rolId);
            if (data == null) return NotFound();

            return Ok(data);
        }

        [HttpPost]
        public async Task<IActionResult> Create([FromBody] UsuarioRol usuarioRol)
        {
            var created = await _usuarioRolService.CreateUsuarioRolAsync(usuarioRol);
            return Ok(created);
        }

        [HttpPut]
        public async Task<IActionResult> Update([FromBody] UsuarioRol usuarioRol)
        {
            var updated = await _usuarioRolService.UpdateUsuarioRolAsync(usuarioRol);
            if (updated == null) return NotFound();

            return Ok(updated);
        }

        [HttpDelete("{usuarioId}/{rolId}")]
        public async Task<IActionResult> Delete(int usuarioId, int rolId)
        {
            var deleted = await _usuarioRolService.DeleteUsuarioRolAsync(usuarioId, rolId);
            if (!deleted) return NotFound();

            return NoContent();
        }
    }
}
