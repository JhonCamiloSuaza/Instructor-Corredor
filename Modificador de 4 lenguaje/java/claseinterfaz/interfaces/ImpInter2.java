package interfaces;

/*
 * ImpInter2.java
 * Implementa Inter2 con constructor con parámetros
 */
public class ImpInter2 implements Inter2 {

    private int numero;

    public ImpInter2(int numero) {
        this.numero = numero;
        System.out.println("[ImpInter2] Constructor con parámetros ejecutado");
    }

    @Override
    public void mostrar() {
        System.out.println("ImpInter2: numero = " + numero);
    }

    @Override
    public int getNumero() {
        return numero;
    }
}
