/*
 * EjemploObjetos.cs
 * Muestra 5 objetos distintos creados a partir de clases reales y usa sus métodos.
 */

using System;

public class EjemploObjetos
{
    public void Mostrar()
    {
        Console.WriteLine("Ejemplo: Objetos");

        // 1) Persona objeto
        Persona persona1 = new Persona("Ana", 30, true);
        persona1.MostrarInfo();

        // 2) Carro objeto
        Carro carro1 = new Carro("Honda", 2018, 18000.0);
        carro1.MostrarInfo();

        // 3) Animal objeto
        Animal animal1 = new Animal("Gato", "Michi", true);
        animal1.MostrarInfo();

        // 4) Libro objeto
        Libro libro1 = new Libro("Java Básico", "María", 150);
        libro1.MostrarInfo();

        // 5) Computador objeto
        Computador comp1 = new Computador("Lenovo", 8, true);
        comp1.MostrarInfo();

        Console.WriteLine();
    }
}
