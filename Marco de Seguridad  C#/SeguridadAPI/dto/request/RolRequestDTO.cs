using System.ComponentModel.DataAnnotations;

namespace SeguridadAPI.DTOs.Request
{
    public class RolRequestDTO
    {
        [Required(ErrorMessage = "El nombre del rol es obligatorio")]
        public string NombreRol { get; set; }

        [Required(ErrorMessage = "La descripción es obligatoria")]
        public string Descripcion { get; set; }
    }
}
