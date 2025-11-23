package main;

import clasesabstractas.*;

public class Main {
    public static void main(String[] args) {

        Imp1 a1 = new Imp1();
        Imp2 a2 = new Imp2(200);
        Imp3 a31 = new Imp3("Texto abstracto");
        Imp3 a32 = new Imp3("Texto y número", 50);
        Abstracto4 aux = new Imp4("Dato original abstracto");
        Imp4 a4 = new Imp4(aux);
        Imp5 a5 = new Imp5(99.9);

        a1.mostrar();
        a2.mostrar();
        a31.mostrar();
        a32.mostrar();
        a4.mostrar();
        a5.mostrar();
    }
}
