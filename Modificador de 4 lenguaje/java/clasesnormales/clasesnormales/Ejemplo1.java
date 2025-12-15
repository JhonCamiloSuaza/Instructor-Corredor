package clasesnormales;


// EJEMPLO 1: Clase normal con constructor SIN parámetros

public class Ejemplo1 {

    // Atributo de ejemplo
    String mensaje;

    // Constructor SIN parámetros
    // Este constructor se ejecuta cuando NO enviamos nada desde el main.
    public Ejemplo1() {
        this.mensaje = "Constructor sin parámetros";
    }

    public void mostrar() {
        System.out.println("Ejemplo 1: " + mensaje);
    }
}
