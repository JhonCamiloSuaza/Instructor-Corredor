using SeguridadAPI.DTOs.Request;
using SeguridadAPI.DTOs.Response;

namespace SeguridadAPI.Services
{
    public interface IUsuarioService

    {
        UsuarioResponseDTO CrearUsuario(UsuarioRequestDTO dto, string ipOrigen);
        UsuarioResponseDTO ActualizarUsuario(int id, UsuarioRequestDTO dto, string ipOrigen); // <-- Agregar
        UsuarioResponseDTO Login(string nombreUsuario, string contrasena, string ipOrigen);
        void Logout(int usuarioID, string ipOrigen);
    }
}
