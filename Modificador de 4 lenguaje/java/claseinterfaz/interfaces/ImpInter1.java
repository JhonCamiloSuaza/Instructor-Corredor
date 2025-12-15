package interfaces;

/*
 * ImpInter1.java
 * Implementa Inter1 con constructor sin parámetros
 */
public class ImpInter1 implements Inter1 {

    public ImpInter1() {
        System.out.println("[ImpInter1] Constructor sin parámetros ejecutado");
    }

    @Override
    public void mostrar() {
        System.out.println("ImpInter1: método mostrar()");
    }
}

