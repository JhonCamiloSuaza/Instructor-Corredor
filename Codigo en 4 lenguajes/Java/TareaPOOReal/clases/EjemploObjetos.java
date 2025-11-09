
/*
 * EjemploObjetos.java
 * Muestra 5 objetos distintos creados a partir de las clases reales y usa sus métodos.
 */

public class EjemploObjetos {
    public void mostrar() {
        System.out.println(" Ejemplo: Objetos ");

        // 1) Persona objeto
        Persona persona1 = new Persona("Ana", 30, true);
        persona1.mostrarInfo();

        // 2) Carro objeto
        Carro carro1 = new Carro("Honda", 2018, 18000.0);
        carro1.mostrarInfo();

        // 3) Animal objeto
        Animal animal1 = new Animal("Gato", "Michi", true);
        animal1.mostrarInfo();

        // 4) Libro objeto
        Libro libro1 = new Libro("Java Básico", "María", 150);
        libro1.mostrarInfo();

        // 5) Computador objeto
        Computador comp1 = new Computador("lenovo", 8, true);
        comp1.mostrarInfo();

        System.out.println();
    }
}
