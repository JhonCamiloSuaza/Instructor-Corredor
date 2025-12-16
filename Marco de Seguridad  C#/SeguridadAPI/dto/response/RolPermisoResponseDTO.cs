using System;

namespace SeguridadAPI.DTOs.Response
{
    public class RolPermisoResponseDTO
    {
        public int RolID { get; set; }
        public int PermisoID { get; set; }
        public DateTime FechaAsignacion { get; set; }

        // Opcional: nombres resumidos
        public string? NombreRol { get; set; }
        public string? NombrePermiso { get; set; }
    }
}
