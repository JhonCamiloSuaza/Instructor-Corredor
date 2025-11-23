namespace EjemploConstructores.ClasesAbstractas
{
    class Circulo : Figura
    {
        // Constructor con parámetros
        public Circulo(string nombre) { Nombre = nombre; }

        // Constructor de copia
        public Circulo(Circulo otro) { Nombre = otro.Nombre; }

        public override void Dibujar() => System.Console.WriteLine($"Dibujando {Nombre}");
    }
}
