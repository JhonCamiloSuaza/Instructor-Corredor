package clasesabstractas;

public class Imp5 extends Abstracto5 {

    public Imp5(double v) {
        super(v);
    }

    @Override
    public void mostrar() {
        System.out.println("Imp5: " + valor);
    }
}
