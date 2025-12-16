using System;

namespace SeguridadAPI.DTOs.Response
{
    public class LogErroresResponseDTO
    {
        public int ErrorID { get; set; }
        public DateTime Fecha { get; set; }
        public int UsuarioID { get; set; }
        public string TipoError { get; set; }
        public string Descripcion { get; set; }
        public string IP_Origen { get; set; }

        // Opcional: nombre del usuario que causó el error
        public string? NombreUsuario { get; set; }
    }
}
