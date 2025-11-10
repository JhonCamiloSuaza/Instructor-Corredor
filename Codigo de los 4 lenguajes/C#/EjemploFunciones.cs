using System;

public class EjemploFunciones
{
    public void Mostrar()
    {
        Console.WriteLine("--- Ejemplo: Funciones con retorno ---");

        Persona p = new Persona("Sofia",19,false);
        Console.WriteLine("Nombre persona: " + p.Nombre);
        Console.WriteLine("Es mayor?: " + EsMayor(p.Edad));
        Console.WriteLine("Area rectángulo 3x4: " + AreaRectangulo(3,4));
        Console.WriteLine("Precio con descuento (100, 10%): " + AplicarDescuento(100.0,10));
        Console.WriteLine("Obtener inicial nombre: " + Inicial(p.Nombre));
        Console.WriteLine();
    }

    public bool EsMayor(int edad){ return edad >= 18; }
    public double AreaRectangulo(double baseR,double altura){ return baseR*altura; }
    public double AplicarDescuento(double precio,double porcentaje){ return precio*(1 - porcentaje/100.0); }
    public char Inicial(string nombre){ return nombre[0]; }
    public string Repetir(string s,int veces){ return new String(System.Linq.Enumerable.Repeat(s,veces).SelectMany(x=>x).ToArray()); }
}
