
/*
 * EjemploClases.java
 * Aquí definimos 5 clases reales: Persona, Carro, Animal, Libro, Computador
 * Cada clase tiene atributos y un método mostrarInfo() para imprimir su información.
 */

// 1) Persona
class Persona {
    public String nombre;
    public int edad;
    public boolean activo;
    public Persona(String nombre, int edad, boolean activo) {
        this.nombre = nombre; this.edad = edad; this.activo = activo;
    }
    public void mostrarInfo() {
        System.out.println("Persona -> nombre: " + nombre + ", edad: " + edad + ", activo: " + activo);
    }
}

// 2) Carro
class Carro {
    public String marca;
    public int modelo;
    public double precio;
    public Carro(String marca, int modelo, double precio) {
        this.marca = marca; this.modelo = modelo; this.precio = precio;
    }
    public void mostrarInfo() {
        System.out.println("Carro  marca: " + marca + ", modelo: " + modelo + ", precio: " + precio);
    }
}

// 3) Animal
class Animal {
    public String especie;
    public String nombre;
    public boolean domestico;
    public Animal(String especie, String nombre, boolean domestico) {
        this.especie = especie; this.nombre = nombre; this.domestico = domestico;
    }
    public void mostrarInfo() {
        System.out.println("Animal  especie: " + especie + ", nombre: " + nombre + ", domestico: " + domestico);
    }
}

// 4) Libro
class Libro {
    public String titulo;
    public String autor;
    public int paginas;
    public Libro(String titulo, String autor, int paginas) {
        this.titulo = titulo; this.autor = autor; this.paginas = paginas;
    }
    public void mostrarInfo() {
        System.out.println("Libro -> titulo: " + titulo + ", autor: " + autor + ", paginas: " + paginas);
    }
}

// 5) Computador
class Computador {
    public String marca;
    public int ramGb;
    public boolean encendido;
    public Computador(String marca, int ramGb, boolean encendido) {
        this.marca = marca; this.ramGb = ramGb; this.encendido = encendido;
    }
    public void mostrarInfo() {
        System.out.println("Computador -> marca: " + marca + ", RAM: " + ramGb + "GB, encendido: " + encendido);
    }
}

// Clase que muestra los 5 ejemplos de clases creando instancias
public class EjemploClases {
    public void mostrar() {
        System.out.println("Ejemplo: Clases reales ");
        Persona p = new Persona("Camilo", 20, true);
        Carro c = new Carro("Toyota", 2020, 35000.0);
        Animal a = new Animal("Perro", "Firulais", true);
        Libro l = new Libro("POO en Java", "Autor X", 250);
        Computador pc = new Computador("Dell", 16, false);

        p.mostrarInfo();
        c.mostrarInfo();
        a.mostrarInfo();
        l.mostrarInfo();
        pc.mostrarInfo();
        System.out.println();
    }
}
