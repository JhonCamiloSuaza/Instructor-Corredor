package clasesabstractas;

public class Imp4 extends Abstracto4 {

    public Imp4(String d) {
        super(d);
    }

    public Imp4(Abstracto4 o) {
        super(o);
    }

    @Override
    public void mostrar() {
        System.out.println("Imp4: " + dato);
    }
}
