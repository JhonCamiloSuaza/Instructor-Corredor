using System;

public class EjemploAtributos
{
    public void Mostrar()
    {
        Console.WriteLine(" Ejemplo: Atributos ");

        // Clase Producto local
        var p = new Producto(1001,"Auriculares",79.99,true,new byte[]{1,0,1});
        p.Mostrar();

        Persona per = new Persona("Luis",28,true); per.MostrarInfo();
        Carro car = new Carro("Mazda",2019,22000.0); car.MostrarInfo();
        Libro lib = new Libro("Aprende Java","Carlos",320); lib.MostrarInfo();
        Computador pc = new Computador("Asus",32,true); pc.MostrarInfo();

        Console.WriteLine();
    }
}

public class Producto
{
    public int Codigo;
    public string Nombre;
    public double Precio;
    public bool Disponible;
    public byte[] Imagen;

    public Producto(int codigo,string nombre,double precio,bool disponible,byte[] imagen)
    {
        Codigo = codigo; Nombre = nombre; Precio = precio; Disponible = disponible; Imagen = imagen;
    }

    public void Mostrar()
    {
        Console.WriteLine($"Producto -> codigo: {Codigo}, nombre: {Nombre}, precio: {Precio}, disponible: {Disponible}, imagenBytes: {Imagen.Length}");
    }
}
