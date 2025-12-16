using System;

namespace SeguridadAPI.DTOs.Response
{
    public class UsuarioRolResponseDTO
    {
        public int UsuarioID { get; set; }
        public int RolID { get; set; }
        public DateTime FechaAsignacion { get; set; }

        // Opcional: nombres resumidos
        public string? NombreUsuario { get; set; }
        public string? NombreRol { get; set; }
    }
}
