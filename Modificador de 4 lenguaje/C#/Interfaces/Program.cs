using System;

namespace EjemploConstructores.Interfaces
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine(" INTERFACES \n");

            // Pajaro: constructor CON PARÁMETROS y constructor de COPIA
            Pajaro pajaro1 = new Pajaro("Canario");
            Pajaro pajaro2 = new Pajaro(pajaro1);
            Console.WriteLine("Pajaros");
            pajaro1.Volar();
            pajaro2.Volar();

            // Documento: constructor SIN PARÁMETROS y constructor de COPIA
            Documento doc1 = new Documento();
            Documento doc2 = new Documento(doc1);
            Console.WriteLine("\n Documento ");
            doc1.Imprimir();
            doc2.Imprimir();

            // Moto: constructor SOBRECARGADO y constructor de COPIA
            Moto moto1 = new Moto(120);
            Moto moto2 = new Moto(moto1);
            Console.WriteLine("\n Moto ");
            moto1.Conducir();
            moto2.Conducir();

            // Pizza: constructor CON PARÁMETROS y constructor de COPIA
            Pizza pizza1 = new Pizza("Pizza Margarita");
            Pizza pizza2 = new Pizza(pizza1);
            Console.WriteLine("\n Pizza ");
            pizza1.Cocinar();
            pizza2.Cocinar();

            // Robot: constructor SIN PARÁMETROS y constructor de COPIA
            Robot robot1 = new Robot();
            Robot robot2 = new Robot(robot1);
            Console.WriteLine("\n Robot ");
            robot1.Programar();
            robot2.Programar();

            Console.WriteLine("\n FIN DE EJECUCIÓN ");
        }
    }
}
