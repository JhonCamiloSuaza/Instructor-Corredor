
/*
 * EjemploMetodosConParametros.java
 * Contiene 5 métodos con parámetros y los usa con ejemplos reales.
 */

public class EjemploMetodosConParametros {
    public void mostrar() {
        System.out.println(" Ejemplo: Métodos con parámetros ");
        Calculadora calc = new Calculadora();
        System.out.println("Sumar 2+3 = " + calc.sumar(2,3));
        System.out.println("Multiplicar 4*5 = " + calc.multiplicar(4,5));
        System.out.println("Calcular IVA de 100 = " + calc.calcularIVA(100.0));
        System.out.println("Registrar persona: " );
        calc.registrarPersona("María", 22);
        System.out.println("Verificar mayor (edad 17): " + calc.esMayor(17));
        System.out.println();
    }
}

class Calculadora {
    public int sumar(int a, int b){ return a+b; }
    public int multiplicar(int a, int b){ return a*b; }
    public double calcularIVA(double precio){ return precio * 0.19; }
    public void registrarPersona(String nombre, int edad){ System.out.println("  Registrado: " + nombre + ", " + edad + " años"); }
    public boolean esMayor(int edad){ return edad >= 18; }
}
