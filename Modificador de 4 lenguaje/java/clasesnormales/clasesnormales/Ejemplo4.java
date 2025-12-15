package clasesnormales;


// EJEMPLO 4: Clase normal con CONSTRUCTOR COPIA

public class Ejemplo4 {

    String dato;

    // Constructor normal (se usa para crear un dato inicial)
    public Ejemplo4(String dato) {
        this.dato = dato;
    }

    // Constructor COPIA
    // Recibe otro objeto Ejemplo4 y copia su atributo.
    public Ejemplo4(Ejemplo4 original) {
        this.dato = original.dato;
    }

    public void mostrar() {
        System.out.println("Ejemplo 4: " + dato);
    }
}
