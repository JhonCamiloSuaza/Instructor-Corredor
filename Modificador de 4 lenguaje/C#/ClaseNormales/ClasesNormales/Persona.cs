namespace EjemploConstructores.ClasesNormales
{
    class Persona
    {
        public string Nombre;

        // Constructor de copia (único constructor público de esta clase)
        public Persona(Persona otra)
        {
            Nombre = otra.Nombre;
        }

        // Constructor privado para permitir crear un "original" sin exponer otro constructor público
        private Persona()
        {
            Nombre = "Sin nombre";
        }

        // Método de fábrica para crear un original (no cuenta como constructor público)
        public static Persona CrearPorDefecto()
        {
            return new Persona();
        }

        public void Mostrar()
        {
            System.Console.WriteLine($"Persona: {Nombre}");
        }
    }
}
