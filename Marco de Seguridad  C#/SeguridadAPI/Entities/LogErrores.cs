using System;

namespace SeguridadAPI.Entities
{
    public class LogErrores
    {
        // Llave primaria
        public int ErrorID { get; set; }

        // Fecha del error
        public DateTime Fecha { get; set; } = DateTime.Now;

        // Llave foránea hacia Usuario
        public int UsuarioID { get; set; }

        // Navegación hacia Usuario
        public required Usuario Usuario { get; set; }

        // Tipo de error (ej: 'Acceso fallido')
        public required string TipoError { get; set; }

        // Descripción detallada del error
        public required string Descripcion { get; set; }

        // IP donde ocurrió el error
        public required string IP_Origen { get; set; }
    }
}
