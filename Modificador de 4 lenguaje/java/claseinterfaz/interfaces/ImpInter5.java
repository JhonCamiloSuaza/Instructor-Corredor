package interfaces;

/*
 * ImpInter5.java
 * Implementa Inter5 con constructor repetido (con parámetros)
 */
public class ImpInter5 implements Inter5 {

    private double valor;

    public ImpInter5(double valor) {
        this.valor = valor;
        System.out.println("[ImpInter5] Constructor(double) ejecutado");
    }

    @Override
    public void mostrar() {
        System.out.println("ImpInter5: valor = " + valor);
    }

    @Override
    public double sumar(double x) {
        return valor + x;
    }
}
