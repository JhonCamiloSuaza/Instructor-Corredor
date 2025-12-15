using System.Collections.Generic;

namespace SeguridadAPI.Entities
{
    // Representa la tabla "Roles" en SQL Server
    public class Roles
    {
        // Llave primaria (IDENTITY)
        public int RolID { get; set; }

        // Nombre del rol (obligatorio)
        public required string NombreRol { get; set; }

        // Descripción del rol
        public required string Descripcion { get; set; }

        // Relación: un rol puede estar asignado a muchos usuarios (muchos a muchos)
        public ICollection<UsuarioRol> UsuarioRoles { get; set; } = new List<UsuarioRol>();

        // Relación: un rol puede tener muchos permisos (muchos a muchos)
        public ICollection<RolPermiso> RolPermisos { get; set; } = new List<RolPermiso>();
    }
}
