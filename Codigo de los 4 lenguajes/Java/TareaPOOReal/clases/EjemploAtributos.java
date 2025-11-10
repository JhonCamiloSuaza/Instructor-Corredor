
/*
 * EjemploAtributos.java
 * Muestra 5 atributos distintos y cómo usarlos (edad, nombre, precio, codigo, disponible).
 */

public class EjemploAtributos {
    public void mostrar() {
        System.out.println(" Ejemplo: Atributos ");

        // 5 atributos en una clase Producto (demostración)
        class Producto {
            public int codigo;
            public String nombre;
            public double precio;
            public boolean disponible;
            public byte[] imagen; // binario simulado

            public Producto(int codigo, String nombre, double precio, boolean disponible, byte[] imagen) {
                this.codigo = codigo; this.nombre = nombre; this.precio = precio;
                this.disponible = disponible; this.imagen = imagen;
            }
            public void mostrar() {
                System.out.println("Producto -> codigo: " + codigo + ", nombre: " + nombre + ", precio: " + precio + ", disponible: " + disponible + ", imagenBytes: " + imagen.length);
            }
        }

        Producto p = new Producto(1001, "Auriculares", 79.99, true, new byte[]{1,0,1});
        p.mostrar();

        // Otros ejemplos rápidos de atributos en objetos simples
        Persona per = new Persona("Luis", 28, true);
        per.mostrarInfo();

        Carro car = new Carro("Mazda", 2019, 22000.0);
        car.mostrarInfo();

        Libro lib = new Libro("Aprende Java", "Carlos", 320);
        lib.mostrarInfo();

        Computador pc = new Computador("Lenovo", 32, true);
        pc.mostrarInfo();

        System.out.println();
    }
}
