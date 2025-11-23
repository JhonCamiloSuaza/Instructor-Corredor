package interfaces;

/*
 * ImpInter3.java
 * Implementa Inter3 con constructores sobrecargados
 */
public class ImpInter3 implements Inter3 {

    private String texto;
    private int numero;

    public ImpInter3(String texto) {
        this.texto = texto;
        this.numero = 0;
        System.out.println("[ImpInter3] Constructor(texto) ejecutado");
    }

    public ImpInter3(String texto, int numero) {
        this.texto = texto;
        this.numero = numero;
        System.out.println("[ImpInter3] Constructor(texto, numero) ejecutado");
    }

    @Override
    public void mostrar() {
        System.out.println("ImpInter3: texto = " + texto + " | numero = " + numero);
    }

    @Override
    public void setTexto(String t) {
        this.texto = t;
    }
}
