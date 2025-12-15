namespace SeguridadAPI.Entities
{
    // Políticas de contraseñas del sistema
    public class PoliticasContraseñas
    {
        // Llave primaria de la política
        public int PoliticaID { get; set; }

        // Mínimo de caracteres permitidos
        public int MinLongitud { get; set; }

        // Máximo de caracteres permitidos
        public int MaxLongitud { get; set; }

        // ¿Requiere letras mayúsculas?
        public bool RequiereMayusculas { get; set; }

        // ¿Requiere números?
        public bool RequiereNumeros { get; set; }

        // ¿Requiere símbolos? (Ej: !@#$)
        public bool RequiereSimbolos { get; set; }

        // Cada cuántos días caduca la contraseña
        public int CaducidadDias { get; set; }
    }
}
