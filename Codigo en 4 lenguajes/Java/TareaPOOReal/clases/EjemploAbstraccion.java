
/*
 * EjemploAbstraccion.java
 * Contiene ejemplos reales de abstracción: clases abstractas e interfaces.
 */

// 1) Figura (abstracta)
abstract class Figura {
    public abstract double area();
    public void mostrarArea(){ System.out.println("Area = " + area()); }
}
class Rectangulo extends Figura {
    private double base, altura;
    public Rectangulo(double b, double h){ base=b; altura=h; }
    public double area(){ return base*altura; }
}

// 2) Vehiculo (abstracta)
abstract class Vehiculo {
    public abstract void arrancar();
}
class Moto extends Vehiculo {
    public void arrancar(){ System.out.println("Moto arrancó"); }
}

// 3) Empleado (interface para abstracción)
interface Empleado {
    double calcularPago();
    String obtenerNombre();
}
class EmpleadoPlanta implements Empleado {
    private String nombre; private double salario;
    public EmpleadoPlanta(String nombre, double salario){ this.nombre=nombre; this.salario=salario; }
    public double calcularPago(){ return salario; }
    public String obtenerNombre(){ return nombre; }
}

// 4) AnimalAbstracto (abstracta)
abstract class AnimalAbstracto {
    public abstract void hablar();
}
class Perro extends AnimalAbstracto {
    public void hablar(){ System.out.println("Guau"); }
}

// 5) Electrodomestico (abstracta)
abstract class Electrodomestico {
    public abstract void encender();
}
class Televisor extends Electrodomestico {
    public void encender(){ System.out.println("Televisor encendido"); }
}

public class EjemploAbstraccion {
    public void mostrar() {
        System.out.println("--- Ejemplo: Abstracción ---");
        Figura r = new Rectangulo(3,4); r.mostrarArea();
        Vehiculo m = new Moto(); m.arrancar();
        Empleado emp = new EmpleadoPlanta("Laura", 1200); System.out.println("Pago: " + emp.calcularPago());
        AnimalAbstracto perro = new Perro(); perro.hablar();
        Electrodomestico tv = new Televisor(); tv.encender();
        System.out.println();
    }
}
