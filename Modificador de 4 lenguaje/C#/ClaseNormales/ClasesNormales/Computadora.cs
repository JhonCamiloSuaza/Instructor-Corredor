namespace EjemploConstructores.ClasesNormales
{
    class Computadora
    {
        public string Procesador;
        public int RamGb;

        // Constructor sobrecargado (único), ejemplificado con un parámetro int
        // que establece RAM y deja un procesador por defecto.
        public Computadora(int ramGb)
        {
            Procesador = "Desconocido";
            RamGb = ramGb;
        }

        public void Mostrar()
        {
            System.Console.WriteLine($"Computadora: CPU={Procesador}, RAM={RamGb}GB");
        }
    }
}
