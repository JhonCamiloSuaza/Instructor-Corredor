package clasesabstractas;

// EJEMPLO 1: Constructor sin parámetros
public abstract class Abstracto1 {

    String mensaje;

    public Abstracto1() {
        this.mensaje = "Constructor sin parámetros (abstracta)";
    }

    public abstract void mostrar();
}
