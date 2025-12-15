using System.ComponentModel.DataAnnotations;

namespace SeguridadAPI.DTOs.Request
{
    public class SesionUsuarioRequestDTO
    {
        [Required(ErrorMessage = "El ID del usuario es obligatorio")]
        public int UsuarioID { get; set; }

        [Required(ErrorMessage = "La IP de origen es obligatoria")]
        public string IP_Origen { get; set; }

        [Required(ErrorMessage = "El estado de la sesión es obligatorio")]
        public string EstadoSesion { get; set; } // 'Activo' | 'Cerrado'
    }
}
