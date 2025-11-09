
/*
 * EjemploMetodosSinParametros.java
 * Contiene ejemplos de métodos sin parámetros (acciones de objetos).
 */

public class EjemploMetodosSinParametros {
    public void mostrar() {
        System.out.println(" Ejemplo: Métodos sin parámetros ");
        Máquina m = new Máquina();
        m.encender(); // void
        m.detener();  // void
        System.out.println("Estado encendida?: " + m.estaEncendida()); 
        m.reiniciar();
        m.apagar();
        System.out.println();
    }
}

class Máquina {
    private boolean encendida = false;
    public void encender(){ encendida = true; System.out.println("Máquina encendida"); }
    public void apagar(){ encendida = false; System.out.println("Máquina apagada"); }
    public boolean estaEncendida(){ return encendida; }
    public void reiniciar(){ System.out.println("Reiniciando..."); encendida = false; encendida = true; }
    public void detener(){ System.out.println("Máquina detenida"); }
}
