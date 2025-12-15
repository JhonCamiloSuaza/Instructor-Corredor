using System;

namespace SeguridadAPI.DTOs.Response
{
    public class SesionUsuarioResponseDTO
    {
        public int SesionID { get; set; }
        public int UsuarioID { get; set; }
        public DateTime FechaInicio { get; set; }
        public DateTime? FechaFin { get; set; }
        public string IP_Origen { get; set; }
        public string EstadoSesion { get; set; }

        // Opcional: nombre del usuario
        public string? NombreUsuario { get; set; }
    }
}
