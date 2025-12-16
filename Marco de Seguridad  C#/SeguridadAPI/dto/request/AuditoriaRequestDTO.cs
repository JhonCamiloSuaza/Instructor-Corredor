using System.ComponentModel.DataAnnotations;

namespace SeguridadAPI.DTOs.Request
{
    public class AuditoriaRequestDTO
    {
        [Required(ErrorMessage = "El ID del usuario es obligatorio")]
        public int UsuarioID { get; set; }

        [Required(ErrorMessage = "La acción es obligatoria")]
        public string Accion { get; set; } // Login, Crear, Editar, Eliminar

        public string? Descripcion { get; set; }

        [Required(ErrorMessage = "La IP de origen es obligatoria")]
        public string IP_Origen { get; set; }

        [Required(ErrorMessage = "La aplicación es obligatoria")]
        public string Aplicacion { get; set; }
    }
}
