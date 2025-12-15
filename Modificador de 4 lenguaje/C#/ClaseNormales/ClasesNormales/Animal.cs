namespace EjemploConstructores.ClasesNormales
{
    class Animal
    {
        public string Especie;

        // Constructor con parámetros (único y repetido a propósito)
        public Animal(string especie)
        {
            Especie = especie;
        }

        public void Mostrar()
        {
            System.Console.WriteLine($"Animal: {Especie}");
        }
    }
}
