namespace EjemploConstructores.Interfaces
{
    class Pizza : ICocinable
    {
        public string Nombre;

        // Constructor con parámetros
        public Pizza(string nombre) { Nombre = nombre; }

        // Constructor de copia
        public Pizza(Pizza otra) { Nombre = otra.Nombre; }

        public void Cocinar() => System.Console.WriteLine($"{Nombre} se está horneando.");
    }
}
