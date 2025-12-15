using Microsoft.AspNetCore.Mvc;
using SeguridadAPI.Entities;
using SeguridadAPI.Services;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace SeguridadAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ConfiguracionSeguridadController : ControllerBase
    {
        private readonly IConfiguracionSeguridadService _configService;

        public ConfiguracionSeguridadController(IConfiguracionSeguridadService configService)
        {
            _configService = configService;
        }

        // GET: api/ConfiguracionSeguridad
        [HttpGet]
        public async Task<ActionResult<IEnumerable<ConfiguracionSeguridad>>> GetAll()
        {
            var configs = await _configService.GetAllConfiguracionesAsync();
            return Ok(configs);
        }

        // GET: api/ConfiguracionSeguridad/5
        [HttpGet("{id}")]
        public async Task<ActionResult<ConfiguracionSeguridad>> GetById(int id)
        {
            var config = await _configService.GetConfiguracionByIdAsync(id);
            if (config == null)
                return NotFound();

            return Ok(config);
        }

        // POST: api/ConfiguracionSeguridad
        [HttpPost]
        public async Task<ActionResult<ConfiguracionSeguridad>> Create([FromBody] ConfiguracionSeguridad config)
        {
            var createdConfig = await _configService.CreateConfiguracionAsync(config);
            return CreatedAtAction(nameof(GetById), new { id = createdConfig.ConfiguracionID }, createdConfig);
        }

        // PUT: api/ConfiguracionSeguridad/5
        [HttpPut("{id}")]
        public async Task<ActionResult<ConfiguracionSeguridad>> Update(int id, [FromBody] ConfiguracionSeguridad config)
        {
            if (id != config.ConfiguracionID)
                return BadRequest("El ID no coincide.");

            var updatedConfig = await _configService.UpdateConfiguracionAsync(config);
            if (updatedConfig == null)
                return NotFound();

            return Ok(updatedConfig);
        }

        // DELETE: api/ConfiguracionSeguridad/5
        [HttpDelete("{id}")]
        public async Task<ActionResult> Delete(int id)
        {
            var deleted = await _configService.DeleteConfiguracionAsync(id);
            if (!deleted)
                return NotFound();

            return NoContent();
        }
    }
}
