namespace EjemploConstructores.ClasesAbstractas
{
    class Ingeniero : Empleado
    {
        // Constructor sin parámetros
        public Ingeniero() { Nombre = "Ingeniero"; }

        // Constructor de copia
        public Ingeniero(Ingeniero otro) { Nombre = otro.Nombre; }

        public override void Trabajar() => System.Console.WriteLine($"{Nombre} está trabajando.");
    }
}
