package main;

// Importamos TODAS las clases de clasesnormales
import clasesnormales.*;


// MAIN:  se ejecutan los ejemplos
// 
public class Main {
    public static void main(String[] args) {

        // Ejemplo 1: Constructor sin parámetros
        Ejemplo1 e1 = new Ejemplo1();

        // Ejemplo 2: Constructor con parámetros
        Ejemplo2 e2 = new Ejemplo2(100);

        // Ejemplo 3: Constructores sobrecargados
        Ejemplo3 e3a = new Ejemplo3("Solo texto");
        Ejemplo3 e3b = new Ejemplo3("Texto y número", 15);

        // Ejemplo 4: Constructor copia
        Ejemplo4 temp = new Ejemplo4("Dato original");
        Ejemplo4 e4 = new Ejemplo4(temp);

        // Ejemplo 5: Constructor con parámetros 
        Ejemplo5 e5 = new Ejemplo5(55.8);

        // Mostrar resultados
        e1.mostrar();
        e2.mostrar();
        e3a.mostrar();
        e3b.mostrar();
        e4.mostrar();
        e5.mostrar();
    }
}
