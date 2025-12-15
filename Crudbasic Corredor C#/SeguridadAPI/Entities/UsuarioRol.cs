using System;

namespace SeguridadAPI.Entities
{
    // Tabla intermedia Usuarios ↔ Roles (Many-to-Many)
    public class UsuarioRol
    {
        // ====== LLAVES ======

        // FK → Usuario
        public int UsuarioID { get; set; }

        // FK → Rol
        public int RolID { get; set; }

        // ====== RELACIONES ======

        public required Usuario Usuario { get; set; }
        public required Roles Rol { get; set; }

        // ====== DATOS EXTRA ======
        public DateTime FechaAsignacion { get; set; } = DateTime.Now;
    }
}
