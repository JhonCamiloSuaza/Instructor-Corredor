namespace EjemploConstructores.ClasesAbstractas
{
    class Perro : AnimalAbstracto
    {
        // Constructor sin parámetros
        public Perro() { Nombre = "Perro"; }

        // Constructor de copia
        public Perro(Perro otro) { Nombre = otro.Nombre; }

        public override void HacerSonido() => System.Console.WriteLine($"{Nombre} ladra: ¡Guau!");
    }
}
