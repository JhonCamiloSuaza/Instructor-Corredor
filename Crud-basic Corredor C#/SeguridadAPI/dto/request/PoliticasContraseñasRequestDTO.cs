using System.ComponentModel.DataAnnotations;

namespace SeguridadAPI.DTOs.Request
{
    public class PoliticasContraseñasRequestDTO
    {
        [Required(ErrorMessage = "La longitud mínima es obligatoria")]
        [Range(1, 100, ErrorMessage = "La longitud mínima debe ser entre 1 y 100")]
        public int MinLongitud { get; set; }

        [Required(ErrorMessage = "La longitud máxima es obligatoria")]
        [Range(1, 100, ErrorMessage = "La longitud máxima debe ser entre 1 y 100")]
        public int MaxLongitud { get; set; }

        public bool RequiereMayusculas { get; set; }
        public bool RequiereNumeros { get; set; }
        public bool RequiereSimbolos { get; set; }

        [Required(ErrorMessage = "La caducidad en días es obligatoria")]
        [Range(1, 365, ErrorMessage = "La caducidad debe ser entre 1 y 365 días")]
        public int CaducidadDias { get; set; }
    }
}
