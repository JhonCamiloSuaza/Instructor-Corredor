namespace EjemploConstructores.ClasesAbstractas
{
    class Bicicleta : Vehiculo
    {
        // Constructor sobrecargado con int
        public Bicicleta(int ruedas) { Nombre = $"Bicicleta con {ruedas} ruedas"; }

        // Constructor de copia
        public Bicicleta(Bicicleta otra) { Nombre = otra.Nombre; }

        public override void Mover() => System.Console.WriteLine($"{Nombre} se mueve pedaleando.");
    }
}
