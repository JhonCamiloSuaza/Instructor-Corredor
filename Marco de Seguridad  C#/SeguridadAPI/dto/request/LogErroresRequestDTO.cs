using System.ComponentModel.DataAnnotations;

namespace SeguridadAPI.DTOs.Request
{
    public class LogErroresRequestDTO
    {
        [Required(ErrorMessage = "El ID del usuario es obligatorio")]
        public int UsuarioID { get; set; }

        [Required(ErrorMessage = "El tipo de error es obligatorio")]
        public string TipoError { get; set; }

        [Required(ErrorMessage = "La descripción del error es obligatoria")]
        public string Descripcion { get; set; }

        [Required(ErrorMessage = "La IP de origen es obligatoria")]
        public string IP_Origen { get; set; }
    }
}
