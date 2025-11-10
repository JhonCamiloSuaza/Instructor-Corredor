using System;

public class Calculadora
{
    public int Sumar(int a,int b){ return a+b; }
    public int Multiplicar(int a,int b){ return a*b; }
    public double CalcularIVA(double precio){ return precio*0.19; }
    public void RegistrarPersona(string nombre,int edad){ Console.WriteLine(" -> Registrado: " + nombre + ", " + edad + " años"); }
    public bool EsMayor(int edad){ return edad>=18; }
}

public class EjemploMetodosConParametros
{
    public void Mostrar()
    {
        Console.WriteLine(" Ejemplo: Métodos con parámetros ");
        Calculadora calc = new Calculadora();
        Console.WriteLine("Sumar 2+3 = " + calc.Sumar(2,3));
        Console.WriteLine("Multiplicar 4*5 = " + calc.Multiplicar(4,5));
        Console.WriteLine("Calcular IVA de 100 = " + calc.CalcularIVA(100.0));
        Console.WriteLine("Registrar persona: " );
        calc.RegistrarPersona("María",22);
        Console.WriteLine("Verificar mayor (edad 17): " + calc.EsMayor(17));
        Console.WriteLine();
    }
}
