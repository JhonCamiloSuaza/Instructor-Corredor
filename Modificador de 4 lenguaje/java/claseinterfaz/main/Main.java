package main;

import interfaces.*;

public class Main {
    public static void main(String[] args) {

        Inter1 i1 = new ImpInter1();
        i1.mostrar();

        Inter2 i2 = new ImpInter2(123);
        i2.mostrar();

        Inter3 i3a = new ImpInter3("Hola solo texto");
        i3a.mostrar();

        Inter3 i3b = new ImpInter3("Hola y número", 7);
        i3b.mostrar();

        ImpInter4 original = new ImpInter4("dato original");
        ImpInter4 copia = new ImpInter4(original);
        copia.mostrar();

        Inter5 i5 = new ImpInter5(9.5);
        i5.mostrar();
    }
}
