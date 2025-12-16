using System.ComponentModel.DataAnnotations;

namespace SeguridadAPI.DTOs.Request
{
    public class PermisosRequestDTO
    {
        [Required(ErrorMessage = "El nombre del permiso es obligatorio")]
        public string NombrePermiso { get; set; }

        [Required(ErrorMessage = "La descripción es obligatoria")]
        public string Descripcion { get; set; }
    }
}
