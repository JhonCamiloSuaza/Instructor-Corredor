using System;

namespace EjemploConstructores.ClasesNormales
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine(" CLASES NORMALES (solo esta carpeta)\n");

            // Persona: usa CONSTRUCTOR DE COPIA
            // Creamos un 'original' mediante el método de fábrica estático (no añade otro constructor público)
            Persona originalPersona = Persona.CrearPorDefecto(); // crea una persona "Sin nombre"
            Persona copiaPersona = new Persona(originalPersona); // constructor de copia
            Console.WriteLine(" Persona ");
            originalPersona.Mostrar();
            copiaPersona.Mostrar();

            // Coche: usa CONSTRUCTOR SIN PARÁMETROS
            Coche coche = new Coche(); // sin parámetros
            Console.WriteLine("\n Coche ");
            coche.Mostrar();

            // Libro: usa CONSTRUCTOR CON PARÁMETROS
            Libro libro = new Libro("El Quijote"); // con parámetros
            Console.WriteLine("\n Libro ");
            libro.Mostrar();

            // Animal: usa CONSTRUCTOR CON PARÁMETROS (REPETIDO)
            Animal animal = new Animal("Perro"); // con parámetros (este tipo se repite a propósito)
            Console.WriteLine("\n Animal ");
            animal.Mostrar();

            // Computadora: usa CONSTRUCTOR SOBRECARGADO (ejemplo con int)
            // "Sobrecargado" aquí se refiere a que el constructor acepta un tipo específico (int)
            // distinto del típico string u otros, mostrando otra firma válida.
            Computadora pc = new Computadora(16); // sobrecargado con int
            Console.WriteLine("\n Computadora ");
            pc.Mostrar();

            Console.WriteLine("\n FIN ");
        }
    }
}
