namespace EjemploConstructores.ClasesAbstractas
{
    class Guitarra : Instrumento
    {
        // Constructor con parámetros
        public Guitarra(string nombre) { Nombre = nombre; }

        // Constructor de copia
        public Guitarra(Guitarra otro) { Nombre = otro.Nombre; }

        public override void Tocar() => System.Console.WriteLine($"{Nombre} está sonando.");
    }
}
