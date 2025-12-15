using SeguridadAPI.Data;
using SeguridadAPI.DTOs.Request;
using SeguridadAPI.DTOs.Response;
using SeguridadAPI.Entities;
using Microsoft.EntityFrameworkCore;
using System.Security.Cryptography;
using System.Text;

namespace SeguridadAPI.Services.Impl
{
  public class UsuarioServiceImpl : IUsuarioService
    {
        private readonly ApplicationDbContext _context;

        public UsuarioServiceImpl(ApplicationDbContext context)
        {
            _context = context;
        }

        // ====================================
        // Crear Usuario
        // ====================================
        public UsuarioResponseDTO CrearUsuario(UsuarioRequestDTO dto, string ipOrigen)
        {
            ValidarContrasena(dto.Contrasena);
            string hash = GenerarSHA256(dto.Contrasena);

            var usuario = new Usuario
            {
                NombreUsuario = dto.NombreUsuario,
                Contrasena = hash,
                EstadoUsuario = true,
                TipoAutenticacion = dto.TipoAutenticacion
            };

            _context.Usuarios.Add(usuario);
            _context.SaveChanges();

            // Registrar auditoría con objeto Usuario completo
            RegistrarAuditoria(usuario, "CrearUsuario", ipOrigen, "Usuario creado con éxito");

            return new UsuarioResponseDTO
            {
                UsuarioID = usuario.UsuarioID,
                NombreUsuario = usuario.NombreUsuario,
                EstadoUsuario = usuario.EstadoUsuario,
                TipoAutenticacion = usuario.TipoAutenticacion
            };
        }

        // ====================================
        // Actualizar Usuario
        // ====================================
        public UsuarioResponseDTO ActualizarUsuario(int id, UsuarioRequestDTO dto, string ipOrigen)
        {
            var usuario = _context.Usuarios.FirstOrDefault(u => u.UsuarioID == id);
            if (usuario == null) throw new Exception("Usuario no encontrado");

            usuario.NombreUsuario = dto.NombreUsuario;
            usuario.TipoAutenticacion = dto.TipoAutenticacion;

            if (!string.IsNullOrEmpty(dto.Contrasena))
            {
                ValidarContrasena(dto.Contrasena);
                usuario.Contrasena = GenerarSHA256(dto.Contrasena);
            }

            _context.Usuarios.Update(usuario);
            _context.SaveChanges();

            RegistrarAuditoria(usuario, "ActualizarUsuario", ipOrigen, "Usuario actualizado");

            return new UsuarioResponseDTO
            {
                UsuarioID = usuario.UsuarioID,
                NombreUsuario = usuario.NombreUsuario,
                EstadoUsuario = usuario.EstadoUsuario,
                TipoAutenticacion = usuario.TipoAutenticacion
            };
        }

        // ====================================
        // Login
        // ====================================
        public UsuarioResponseDTO Login(string nombreUsuario, string contrasena, string ipOrigen)
        {
            var usuario = _context.Usuarios.FirstOrDefault(u => u.NombreUsuario == nombreUsuario);
            if (usuario == null)
            {
                RegistrarLogError(0, "Login fallido", $"Usuario {nombreUsuario} no encontrado", ipOrigen);
                throw new Exception("Usuario o contraseña incorrectos");
            }

            string hash = GenerarSHA256(contrasena);
            if (usuario.Contrasena != hash)
            {
                RegistrarLogError(usuario.UsuarioID, "Login fallido", "Contraseña incorrecta", ipOrigen);
                throw new Exception("Usuario o contraseña incorrectos");
            }

            if (!usuario.EstadoUsuario)
            {
                RegistrarLogError(usuario.UsuarioID, "Login fallido", "Usuario inactivo", ipOrigen);
                throw new Exception("Usuario inactivo");
            }

            // Crear sesión asignando objeto Usuario completo
            var sesion = new SesionUsuario
            {
                UsuarioID = usuario.UsuarioID,
                Usuario = usuario, // ✅ requerido
                IP_Origen = ipOrigen,
                EstadoSesion = "Activo"
            };
            _context.SesionUsuarios.Add(sesion);
            _context.SaveChanges();

            RegistrarAuditoria(usuario, "Login", ipOrigen, "Inicio de sesión exitoso");

            return new UsuarioResponseDTO
            {
                UsuarioID = usuario.UsuarioID,
                NombreUsuario = usuario.NombreUsuario,
                EstadoUsuario = usuario.EstadoUsuario,
                TipoAutenticacion = usuario.TipoAutenticacion
            };
        }

        // ====================================
        // Logout
        // ====================================
        public void Logout(int usuarioID, string ipOrigen)
        {
            var sesion = _context.SesionUsuarios
                .Where(s => s.UsuarioID == usuarioID && s.EstadoSesion == "Activo")
                .FirstOrDefault();

            var usuario = _context.Usuarios.Find(usuarioID);

            if (sesion != null)
            {
                sesion.EstadoSesion = "Cerrado";
                sesion.FechaFin = DateTime.Now;
                sesion.Usuario = usuario; // ✅ asignar objeto completo
                _context.SesionUsuarios.Update(sesion);
                _context.SaveChanges();

                if (usuario != null)
                    RegistrarAuditoria(usuario, "Logout", ipOrigen, "Cierre de sesión exitoso");
            }
        }

        // ====================================
        // Métodos privados auxiliares
        // ====================================
        private void ValidarContrasena(string contrasena)
        {
            if (string.IsNullOrWhiteSpace(contrasena) || contrasena.Length < 8 || contrasena.Length > 20)
                throw new Exception("La contraseña debe tener entre 8 y 20 caracteres");

            if (!contrasena.Any(char.IsUpper))
                throw new Exception("La contraseña debe contener al menos una letra mayúscula");

            if (!contrasena.Any(char.IsDigit))
                throw new Exception("La contraseña debe contener al menos un número");

            if (!contrasena.Any(c => "!@#$%".Contains(c)))
                throw new Exception("La contraseña debe contener al menos un símbolo (!@#$%)");
        }

        private string GenerarSHA256(string input)
        {
            using (var sha256 = SHA256.Create())
            {
                var bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(input));
                return BitConverter.ToString(bytes).Replace("-", "").ToLower();
            }
        }

        private void RegistrarAuditoria(Usuario usuario, string accion, string ipOrigen, string descripcion)
        {
            var auditoria = new Auditoria
            {
                UsuarioID = usuario.UsuarioID,
                Usuario = usuario, // ✅ asignar objeto completo
                Accion = accion,
                IP_Origen = ipOrigen,
                Descripcion = descripcion,
                Aplicacion = "SeguridadAPI"
            };
            _context.Auditorias.Add(auditoria);
            _context.SaveChanges();
        }

     private void RegistrarLogError(int usuarioID, string tipoError, string descripcion, string ipOrigen)
{
    Usuario? usuario = null;
    if (usuarioID > 0)
    {
        usuario = _context.Usuarios.Find(usuarioID);
    }

    var log = new LogErrores
    {
        UsuarioID = usuarioID,
        Usuario = usuario, // ✅ ahora existe la variable
        TipoError = tipoError,
        Descripcion = descripcion,
        IP_Origen = ipOrigen
    };

    _context.LogErrores.Add(log);
    _context.SaveChanges();
}
    }
}