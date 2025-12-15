namespace SeguridadAPI.Entities
{
    // Configuraciones de seguridad del sistema
    public class ConfiguracionSeguridad
    {
        // Llave primaria
        public int ConfiguracionID { get; set; }

        // Nombre de la política o configuración
        public required string NombreConfiguracion { get; set; }

        // Valor correspondiente
        public required string ValorConfiguracion { get; set; }

        // Descripción opcional
        public string? Descripcion { get; set; }
    }
}
