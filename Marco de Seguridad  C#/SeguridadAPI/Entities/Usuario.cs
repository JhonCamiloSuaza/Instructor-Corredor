using System;
using System.Collections.Generic;

namespace SeguridadAPI.Entities
{
    public class Usuario
    {
        // ==== CAMPOS BÁSICOS ====

        public int UsuarioID { get; set; } // PK

        // Usuario para autenticación
        public required string NombreUsuario { get; set; }

        // Contraseña HASH (no texto plano)
        public required string Contrasena { get; set; }

        // Estado del usuario
        public bool EstadoUsuario { get; set; } = true;

        // Windows || SQL
        public required string TipoAutenticacion { get; set; }

        // Fechas
        public DateTime FechaCreacion { get; set; } = DateTime.Now;
        public DateTime? UltimoAcceso { get; set; }


        // ==== RELACIONES ====

        // Un usuario tiene muchos roles
        public ICollection<UsuarioRol> UsuarioRoles { get; set; } = new HashSet<UsuarioRol>();

        // Auditorías hechas por este usuario
        public ICollection<Auditoria> Auditorias { get; set; } = new HashSet<Auditoria>();

        // Sesiones activas/inactivas del usuario
        public ICollection<SesionUsuario> Sesiones { get; set; } = new HashSet<SesionUsuario>();

        // Logs de errores causados por este usuario
        public ICollection<LogErrores> LogsErrores { get; set; } = new HashSet<LogErrores>();
    }
}
