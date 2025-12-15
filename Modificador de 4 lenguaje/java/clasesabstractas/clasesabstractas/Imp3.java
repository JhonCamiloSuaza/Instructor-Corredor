package clasesabstractas;

public class Imp3 extends Abstracto3 {

    public Imp3(String t) {
        super(t);
    }

    public Imp3(String t, int c) {
        super(t, c);
    }

    @Override
    public void mostrar() {
        System.out.println("Imp3: " + texto + " - " + cantidad);
    }
}
