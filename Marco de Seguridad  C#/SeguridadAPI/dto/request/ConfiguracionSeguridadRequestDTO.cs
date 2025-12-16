using System.ComponentModel.DataAnnotations;

namespace SeguridadAPI.DTOs.Request
{
    public class ConfiguracionSeguridadRequestDTO
    {
        [Required(ErrorMessage = "El nombre de la configuración es obligatorio")]
        public string NombreConfiguracion { get; set; }

        [Required(ErrorMessage = "El valor de la configuración es obligatorio")]
        public string ValorConfiguracion { get; set; }

        public string? Descripcion { get; set; }
    }
}
