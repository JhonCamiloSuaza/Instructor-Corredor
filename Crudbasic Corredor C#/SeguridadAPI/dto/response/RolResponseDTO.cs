using System;

namespace SeguridadAPI.DTOs.Response
{
    public class RolResponseDTO
    {
        public int RolID { get; set; }
        public string NombreRol { get; set; }
        public string Descripcion { get; set; }

        // Opcional: número de usuarios y permisos asignados
        public int CantidadUsuarios { get; set; }
        public int CantidadPermisos { get; set; }
    }
}
