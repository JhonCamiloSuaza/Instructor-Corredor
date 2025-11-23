package clasesabstractas;

public class Imp2 extends Abstracto2 {

    public Imp2(int numero) {
        super(numero);
    }

    @Override
    public void mostrar() {
        System.out.println("Imp2: " + numero);
    }
}
