namespace SeguridadAPI.DTOs.Response
{
    public class UsuarioResponseDTO
    {
        public int UsuarioID { get; set; }
        public string NombreUsuario { get; set; }
        public bool EstadoUsuario { get; set; }
        public string TipoAutenticacion { get; set; }
    }
}
