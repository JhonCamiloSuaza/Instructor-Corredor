using System.Collections.Generic;

namespace SeguridadAPI.Entities
{
    public class Permisos
    {
        // Llave primaria
        public int PermisoID { get; set; }

        // Nombre del permiso (obligatorio)
        public required string NombrePermiso { get; set; }

        // Descripción del permiso
        public required string Descripcion { get; set; }

        // Relación muchos a muchos con Roles
        public ICollection<RolPermiso> RolPermisos { get; set; } = new List<RolPermiso>();
    }
}
