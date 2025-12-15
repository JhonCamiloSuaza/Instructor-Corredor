using System;

namespace SeguridadAPI.Entities
{
    // Relación muchos a muchos entre Roles y Permisos
    public class RolPermiso
    {
        // Llave foránea hacia Roles
        public int RolID { get; set; }

        // Navegación hacia Roles
        public required Roles Rol { get; set; }

        // Llave foránea hacia Permisos
        public int PermisoID { get; set; }

        // Navegación hacia Permisos
        public required Permisos Permiso { get; set; }

        // Fecha en que se asignó el permiso al rol
        public DateTime FechaAsignacion { get; set; } = DateTime.Now;
    }
}
