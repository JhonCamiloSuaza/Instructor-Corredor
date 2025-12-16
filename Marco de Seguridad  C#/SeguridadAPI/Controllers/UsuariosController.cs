using Microsoft.AspNetCore.Mvc;
using SeguridadAPI.DTOs.Request;
using SeguridadAPI.DTOs.Response;
using SeguridadAPI.Services;

namespace SeguridadAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class UsuarioController : ControllerBase
    {
        private readonly IUsuarioService _usuarioService;

        public UsuarioController(IUsuarioService usuarioService)
        {
            _usuarioService = usuarioService;
        }

        // ====================================
        // Crear Usuario
        // ====================================
        [HttpPost("crear")]
        public IActionResult Crear([FromBody] UsuarioRequestDTO dto)
        {
            try
            {
                var ip = HttpContext.Connection.RemoteIpAddress?.ToString() ?? "Desconocida";
                var usuario = _usuarioService.CrearUsuario(dto, ip);
                return Ok(usuario);
            }
            catch (Exception ex)
            {
                return BadRequest(new { mensaje = ex.Message });
            }
        }

        // ====================================
        // Actualizar Usuario
        // ====================================
        [HttpPut("actualizar/{id}")]
        public IActionResult Actualizar(int id, [FromBody] UsuarioRequestDTO dto)
        {
            try
            {
                var ip = HttpContext.Connection.RemoteIpAddress?.ToString() ?? "Desconocida";
                var usuario = _usuarioService.ActualizarUsuario(id, dto, ip);
                return Ok(usuario);
            }
            catch (Exception ex)
            {
                return BadRequest(new { mensaje = ex.Message });
            }
        }

        // ====================================
        // Login
        // ====================================
        [HttpPost("login")]
        public IActionResult Login([FromBody] LoginDTO dto)
        {
            try
            {
                var ip = HttpContext.Connection.RemoteIpAddress?.ToString() ?? "Desconocida";
                var usuario = _usuarioService.Login(dto.NombreUsuario, dto.Contrasena, ip);
                return Ok(usuario);
            }
            catch (Exception ex)
            {
                return Unauthorized(new { mensaje = ex.Message });
            }
        }

        // ====================================
        // Logout
        // ====================================
        [HttpPost("logout/{id}")]
        public IActionResult Logout(int id)
        {
            try
            {
                var ip = HttpContext.Connection.RemoteIpAddress?.ToString() ?? "Desconocida";
                _usuarioService.Logout(id, ip);
                return Ok(new { mensaje = "Sesión cerrada correctamente" });
            }
            catch (Exception ex)
            {
                return BadRequest(new { mensaje = ex.Message });
            }
        }
    }
}
