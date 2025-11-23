package interfaces;

/*
 * ImpInter4.java
 * Implementa Inter4 con constructor normal + copia
 */
public class ImpInter4 implements Inter4 {

    private String dato;

    public ImpInter4(String dato) {
        this.dato = dato;
        System.out.println("[ImpInter4] Constructor(String) ejecutado");
    }

    public ImpInter4(ImpInter4 original) {
        this.dato = original.dato;
        System.out.println("[ImpInter4] Constructor copia ejecutado");
    }

    @Override
    public void mostrar() {
        System.out.println("ImpInter4: dato = " + dato);
    }

    @Override
    public String convertirMayus() {
        return dato == null ? null : dato.toUpperCase();
    }
}
