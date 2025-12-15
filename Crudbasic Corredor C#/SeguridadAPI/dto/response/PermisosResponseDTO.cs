using System;

namespace SeguridadAPI.DTOs.Response
{
    public class PermisosResponseDTO
    {
        public int PermisoID { get; set; }
        public string NombrePermiso { get; set; }
        public string Descripcion { get; set; }

        // Opcional: número de roles asignados
        public int CantidadRoles { get; set; }
    }
}
