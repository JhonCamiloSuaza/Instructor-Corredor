namespace EjemploConstructores.Interfaces
{
    class Robot : IProgramable
    {
        public string Nombre;

        // Constructor sin parámetros
        public Robot() { Nombre = "Robot"; }

        // Constructor de copia
        public Robot(Robot otro) { Nombre = otro.Nombre; }

        public void Programar() => System.Console.WriteLine($"{Nombre} ejecuta código.");
    }
}
