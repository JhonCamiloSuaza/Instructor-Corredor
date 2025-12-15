package clasesabstractas;

// EJEMPLO 4: Constructor copia
public abstract class Abstracto4 {

    String dato;

    public Abstracto4(String dato) {
        this.dato = dato;
    }

    public Abstracto4(Abstracto4 original) {
        this.dato = original.dato;
    }

    public abstract void mostrar();
}
