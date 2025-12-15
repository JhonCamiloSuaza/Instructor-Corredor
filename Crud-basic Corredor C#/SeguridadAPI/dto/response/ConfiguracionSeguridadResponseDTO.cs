namespace SeguridadAPI.DTOs.Response
{
    public class ConfiguracionSeguridadResponseDTO
    {
        public int ConfiguracionID { get; set; }
        public string NombreConfiguracion { get; set; }
        public string ValorConfiguracion { get; set; }
        public string? Descripcion { get; set; }
    }
}
