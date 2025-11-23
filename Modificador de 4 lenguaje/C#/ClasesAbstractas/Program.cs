using System;

namespace EjemploConstructores.ClasesAbstractas
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine(" CLASES ABSTRACTAS\n");

            // Circulo: usa constructor CON PARÁMETROS y constructor de COPIA
            Circulo cir1 = new Circulo("Círculo grande");
            Circulo cir2 = new Circulo(cir1);
            Console.WriteLine(" Circulo ");
            cir1.Dibujar();
            cir2.Dibujar();

            // Ingeniero: usa constructor SIN PARÁMETROS y constructor de COPIA
            Ingeniero ing1 = new Ingeniero();
            Ingeniero ing2 = new Ingeniero(ing1);
            Console.WriteLine("\n Ingeniero ");
            ing1.Trabajar();
            ing2.Trabajar();

            // Bicicleta: usa constructor SOBRECARGADO y constructor de COPIA
            Bicicleta bici1 = new Bicicleta(2);
            Bicicleta bici2 = new Bicicleta(bici1);
            Console.WriteLine("\n Bicicleta ");
            bici1.Mover();
            bici2.Mover();

            // Guitarra: usa constructor CON PARÁMETROS y constructor de COPIA
            Guitarra g1 = new Guitarra("Guitarra eléctrica");
            Guitarra g2 = new Guitarra(g1);
            Console.WriteLine("\n Guitarra ");
            g1.Tocar();
            g2.Tocar();

            // Perro: usa constructor SIN PARÁMETROS y constructor de COPIA
            Perro perro1 = new Perro();
            Perro perro2 = new Perro(perro1);
            Console.WriteLine("\n Perro ");
            perro1.HacerSonido();
            perro2.HacerSonido();

            Console.WriteLine("\n FIN DE EJECUCIÓN");
        }
    }
}
