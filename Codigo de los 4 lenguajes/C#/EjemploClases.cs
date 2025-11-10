using System;

public class Persona
{
    public string Nombre;
    public int Edad;
    public bool Activo;
    public Persona(string nombre,int edad,bool activo){ Nombre=nombre; Edad=edad; Activo=activo; }
    public void MostrarInfo(){ Console.WriteLine($"Persona -> nombre: {Nombre}, edad: {Edad}, activo: {Activo}"); }
}

public class Carro
{
    public string Marca;
    public int Modelo;
    public double Precio;
    public Carro(string marca,int modelo,double precio){ Marca=marca; Modelo=modelo; Precio=precio; }
    public void MostrarInfo(){ Console.WriteLine($"Carro  marca: {Marca}, modelo: {Modelo}, precio: {Precio}"); }
}

public class Animal
{
    public string Especie;
    public string Nombre;
    public bool Domestico;
    public Animal(string especie,string nombre,bool domestico){ Especie=especie; Nombre=nombre; Domestico=domestico; }
    public void MostrarInfo(){ Console.WriteLine($"Animal  especie: {Especie}, nombre: {Nombre}, domestico: {Domestico}"); }
}

public class Libro
{
    public string Titulo;
    public string Autor;
    public int Paginas;
    public Libro(string titulo,string autor,int paginas){ Titulo=titulo; Autor=autor; Paginas=paginas; }
    public void MostrarInfo(){ Console.WriteLine($"Libro -> titulo: {Titulo}, autor: {Autor}, paginas: {Paginas}"); }
}

public class Computador
{
    public string Marca;
    public int RamGb;
    public bool Encendido;
    public Computador(string marca,int ramGb,bool encendido){ Marca=marca; RamGb=ramGb; Encendido=encendido; }
    public void MostrarInfo(){ Console.WriteLine($"Computador -> marca: {Marca}, RAM: {RamGb}GB, encendido: {Encendido}"); }
}

public class EjemploClases
{
    public void Mostrar()
    {
        Console.WriteLine(" Ejemplo: Clases reales ");
        Persona p = new Persona("Camilo",20,true);
        Carro c = new Carro("Toyota",2020,35000.0);
        Animal a = new Animal("Perro","Firulais",true);
        Libro l = new Libro("POO en Java","Autor X",250);
        Computador pc = new Computador("Dell",16,false);

        p.MostrarInfo();
        c.MostrarInfo();
        a.MostrarInfo();
        l.MostrarInfo();
        pc.MostrarInfo();
        Console.WriteLine();
    }
}
