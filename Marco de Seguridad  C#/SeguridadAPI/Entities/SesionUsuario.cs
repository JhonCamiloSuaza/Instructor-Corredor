using System;

namespace SeguridadAPI.Entities
{
    // Representa las sesiones iniciadas por un usuario
    public class SesionUsuario
    {
        // ====== LLAVE PRIMARIA ======
        public int SesionID { get; set; }

        // ====== RELACIÓN CON USUARIO ======
        public int UsuarioID { get; set; }
        public required Usuario Usuario { get; set; }

        // ====== DATOS DE SESIÓN ======
        public DateTime FechaInicio { get; set; } = DateTime.Now;

        public DateTime? FechaFin { get; set; }

        public required string IP_Origen { get; set; }

        // 'Activo' | 'Cerrado'
        public required string EstadoSesion { get; set; }
    }
}
