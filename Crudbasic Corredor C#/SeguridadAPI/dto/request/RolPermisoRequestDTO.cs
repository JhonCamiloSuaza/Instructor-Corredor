using System.ComponentModel.DataAnnotations;

namespace SeguridadAPI.DTOs.Request
{
    public class RolPermisoRequestDTO
    {
        [Required(ErrorMessage = "El ID del rol es obligatorio")]
        public int RolID { get; set; }

        [Required(ErrorMessage = "El ID del permiso es obligatorio")]
        public int PermisoID { get; set; }
    }
}
