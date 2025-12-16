using System;

namespace SeguridadAPI.Entities
{
    // Registro de acciones realizadas en el sistema
    public class Auditoria
    {
        // Llave primaria
        public int AuditoriaID { get; set; }

        // Usuario que realizó la acción
        public int UsuarioID { get; set; }
        public required Usuario Usuario { get; set; }

        // Acción ejecutada (Login, Crear, Editar, Eliminar)
        public required string Accion { get; set; }

        // Fecha del evento
        public DateTime Fecha { get; set; } = DateTime.Now;

        // Detalle opcional de la acción
        public string? Descripcion { get; set; }

        // Dirección IP desde donde ocurrió
        public required string IP_Origen { get; set; }

        // Aplicación o sistema que generó el registro
        public required string Aplicacion { get; set; }
    }
}
