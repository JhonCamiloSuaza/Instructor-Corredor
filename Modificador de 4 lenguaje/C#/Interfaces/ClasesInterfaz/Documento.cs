namespace EjemploConstructores.Interfaces
{
    class Documento : IImprimible
    {
        public string Nombre;

        // Constructor sin parámetros
        public Documento() { Nombre = "Documento"; }

        // Constructor de copia
        public Documento(Documento otro) { Nombre = otro.Nombre; }

        public void Imprimir() => System.Console.WriteLine($"{Nombre} se imprime.");
    }
}
