package clasesnormales;


// EJEMPLO 2: Clase normal con constructor CON parámetros
 
public class Ejemplo2 {

    int numero;

    // Constructor CON parámetros
    // Aquí el usuario debe enviar un número al crear el objeto.
    public Ejemplo2(int numero) {
        this.numero = numero;
    }

    public void mostrar() {
        System.out.println("Ejemplo 2: " + numero);
    }
}
