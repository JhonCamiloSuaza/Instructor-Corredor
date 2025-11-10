using System;

abstract class Figura
{
    public abstract double Area();
    public void MostrarArea(){ Console.WriteLine("Area = " + Area()); }
}

class Rectangulo : Figura
{
    private double baseR, altura;
    public Rectangulo(double b, double h){ baseR=b; altura=h; }
    public override double Area(){ return baseR*altura; }
}

abstract class Vehiculo { public abstract void Arrancar(); }
class Moto : Vehiculo { public override void Arrancar(){ Console.WriteLine("Moto arrancó"); } }

interface Empleado
{
    double CalcularPago();
    string ObtenerNombre();
}
class EmpleadoPlanta : Empleado
{
    private string nombre; private double salario;
    public EmpleadoPlanta(string nombre, double salario){ this.nombre=nombre; this.salario=salario; }
    public double CalcularPago(){ return salario; }
    public string ObtenerNombre(){ return nombre; }
}

abstract class AnimalAbstracto { public abstract void Hablar(); }
class Perro : AnimalAbstracto { public override void Hablar(){ Console.WriteLine("Guau"); } }

abstract class Electrodomestico { public abstract void Encender(); }
class Televisor : Electrodomestico { public override void Encender(){ Console.WriteLine("Televisor encendido"); } }

public class EjemploAbstraccion
{
    public void Mostrar()
    {
        Console.WriteLine("--- Ejemplo: Abstracción ---");

        Figura r = new Rectangulo(3,4); r.MostrarArea();
        Vehiculo m = new Moto(); m.Arrancar();
        Empleado emp = new EmpleadoPlanta("Laura", 1200); Console.WriteLine("Pago: " + emp.CalcularPago());
        AnimalAbstracto perro = new Perro(); perro.Hablar();
        Electrodomestico tv = new Televisor(); tv.Encender();

        Console.WriteLine();
    }
}
