
using System;

namespace SeguridadAPI.DTOs.Response
{
    public class AuditoriaResponseDTO
    {
        public int AuditoriaID { get; set; }
        public int UsuarioID { get; set; }
        public string Accion { get; set; }
        public DateTime Fecha { get; set; }
        public string? Descripcion { get; set; }
        public string IP_Origen { get; set; }
        public string Aplicacion { get; set; }

        // Opcional: nombre del usuario que realizó la acción
        public string? NombreUsuario { get; set; }
    }
}
