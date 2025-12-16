using Microsoft.AspNetCore.Mvc;
using SeguridadAPI.Entities;
using SeguridadAPI.Services;

namespace SeguridadAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class RolesController : ControllerBase
    {
        private readonly IRolesService _rolesService;

        public RolesController(IRolesService rolesService)
        {
            _rolesService = rolesService;
        }

        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            var roles = await _rolesService.GetAllRolesAsync();
            return Ok(roles);
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetById(int id)
        {
            var rol = await _rolesService.GetRolByIdAsync(id);
            if (rol == null) return NotFound();

            return Ok(rol);
        }

        [HttpPost]
        public async Task<IActionResult> Create([FromBody] Roles rol)
        {
            var created = await _rolesService.CreateRolAsync(rol);
            return CreatedAtAction(nameof(GetById), new { id = created.RolID }, created);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> Update(int id, [FromBody] Roles rol)
        {
            if (id != rol.RolID) return BadRequest("El ID no coincide");

            var updated = await _rolesService.UpdateRolAsync(rol);
            if (updated == null) return NotFound();

            return Ok(updated);
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(int id)
        {
            var deleted = await _rolesService.DeleteRolAsync(id);
            if (!deleted) return NotFound();

            return NoContent();
        }
    }
}
