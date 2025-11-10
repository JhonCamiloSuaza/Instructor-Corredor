
/*
 * EjemploModificadores.java
 * Demuestra modificadores de acceso: public, private, protected, default y static.
 */

class ModificadoresDemo {
    public String publico = "soyPublico";       // accesible desde cualquier parte
    private String privado = "soyPrivado";     // solo dentro de la clase
    protected String protegido = "soyProtegido"; // accesible en subclases y paquete
    String porDefecto = "soyPorDefecto";      
    public static String estatico = "soyEstatico"; // pertenece a la clase

    // Método para mostrar valores (accede al private desde dentro)
    public void mostrarTodos() {
        System.out.println("publico: " + publico);
        System.out.println("privado: " + privado);
        System.out.println("protegido: " + protegido);
        System.out.println("porDefecto: " + porDefecto);
        System.out.println("estatico: " + estatico);
    }
}

public class EjemploModificadores {
    public void mostrar() {
        System.out.println(" Ejemplo: Modificadores de acceso");
        ModificadoresDemo d = new ModificadoresDemo();
        d.mostrarTodos();

        // Acceso a miembro estático sin instanciar
        System.out.println("Acceso estático directo: " + ModificadoresDemo.estatico);
        System.out.println();
    }
}
