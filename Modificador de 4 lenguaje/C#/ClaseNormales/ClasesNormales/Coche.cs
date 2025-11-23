namespace EjemploConstructores.ClasesNormales
{
    class Coche
    {
        public string Marca;

        // Constructor sin parámetros (único)
        public Coche()
        {
            Marca = "Genérico";
        }

        public void Mostrar()
        {
            System.Console.WriteLine($"Coche: {Marca}");
        }
    }
}
