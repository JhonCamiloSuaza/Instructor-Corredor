using System.ComponentModel.DataAnnotations;

namespace SeguridadAPI.DTOs.Request
{
    public class UsuarioRolRequestDTO
    {
        [Required(ErrorMessage = "El ID del usuario es obligatorio")]
        public int UsuarioID { get; set; }

        [Required(ErrorMessage = "El ID del rol es obligatorio")]
        public int RolID { get; set; }
    }
}
