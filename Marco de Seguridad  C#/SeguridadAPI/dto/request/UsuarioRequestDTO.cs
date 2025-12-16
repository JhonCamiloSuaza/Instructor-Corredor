namespace SeguridadAPI.DTOs.Request
{
    public class UsuarioRequestDTO
    {
        public string NombreUsuario { get; set; }
        public string Contrasena { get; set; }
        public string TipoAutenticacion { get; set; } // "Windows" o "SQL"
    }
}
