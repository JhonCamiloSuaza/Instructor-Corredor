package clasesnormales;
 
// EJEMPLO 3: Clase normal con constructor SOBRECARGADO

public class Ejemplo3 {

    String texto;
    int cantidad;

    //  constructor sobrecargado
    // Se ejecuta si solo envían un texto.
    public Ejemplo3(String texto) {
        this.texto = texto;
        this.cantidad = 0;
    }

    // Segundo constructor sobrecargado
    // Se ejecuta si envían un texto y un número.
    public Ejemplo3(String texto, int cantidad) {
        this.texto = texto;
        this.cantidad = cantidad;
    }

    public void mostrar() {
        System.out.println("Ejemplo 3: " + texto + " - " + cantidad);
    }
}
