package clasesabstractas;

// EJEMPLO 3: Constructores sobrecargados
public abstract class Abstracto3 {

    String texto;
    int cantidad;

    public Abstracto3(String texto) {
        this.texto = texto;
        this.cantidad = 0;
    }

    public Abstracto3(String texto, int cantidad) {
        this.texto = texto;
        this.cantidad = cantidad;
    }

    public abstract void mostrar();
}
