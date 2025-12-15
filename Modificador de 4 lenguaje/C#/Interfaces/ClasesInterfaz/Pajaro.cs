namespace EjemploConstructores.Interfaces
{
    class Pajaro : IVolador
    {
        public string Nombre;

        // Constructor con parámetros
        public Pajaro(string nombre) { Nombre = nombre; }

        // Constructor de copia
        public Pajaro(Pajaro otro) { Nombre = otro.Nombre; }

        public void Volar() => System.Console.WriteLine($"{Nombre} está volando.");
    }
}
