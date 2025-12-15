namespace EjemploConstructores.ClasesNormales
{
    class Libro
    {
        public string Titulo;

        // Constructor con parámetros (único)
        public Libro(string titulo)
        {
            Titulo = titulo;
        }

        public void Mostrar()
        {
            System.Console.WriteLine($"Libro: {Titulo}");
        }
    }
}
