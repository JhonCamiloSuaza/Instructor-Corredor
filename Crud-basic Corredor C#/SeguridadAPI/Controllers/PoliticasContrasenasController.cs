using Microsoft.AspNetCore.Mvc;
using SeguridadAPI.Entities;
using SeguridadAPI.Services;

namespace SeguridadAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class PoliticasContraseñasController : ControllerBase
    {
        private readonly IPoliticasContraseñasService _service;

        public PoliticasContraseñasController(IPoliticasContraseñasService service)
        {
            _service = service;
        }

        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            var lista = await _service.GetAllPoliticasAsync();
            return Ok(lista);
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetById(int id)
        {
            var politica = await _service.GetPoliticaByIdAsync(id);
            if (politica == null) return NotFound();

            return Ok(politica);
        }

        [HttpPost]
        public async Task<IActionResult> Create([FromBody] PoliticasContraseñas model)
        {
            var created = await _service.CreatePoliticaAsync(model);
            return CreatedAtAction(nameof(GetById), new { id = created.PoliticaID }, created);
        }

        [HttpPut]
        public async Task<IActionResult> Update([FromBody] PoliticasContraseñas model)
        {
            var updated = await _service.UpdatePoliticaAsync(model);
            if (updated == null) return NotFound();

            return Ok(updated);
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(int id)
        {
            var deleted = await _service.DeletePoliticaAsync(id);
            if (!deleted) return NotFound();

            return NoContent();
        }
    }
}
