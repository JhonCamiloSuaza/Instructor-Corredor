namespace EjemploConstructores.Interfaces
{
    class Moto : IConducible
    {
        public string Nombre;

        // Constructor sobrecargado con int
        public Moto(int velocidad)
        {
            Nombre = $"Moto a {velocidad} km/h";
        }

        // Constructor de copia
        public Moto(Moto otro)
        {
            Nombre = otro.Nombre;
        }

        public void Conducir()
        {
            System.Console.WriteLine($"{Nombre} está en marcha.");
        }
    }
}
