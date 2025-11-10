
/*
 * EjemploTiposDatos.java
 * Muestra 5 ejemplos por tipo de dato: numérico, texto, boolean, JSON(simulated), binario.
 */

public class EjemploTiposDatos {
    public void mostrar() {
        System.out.println("--- Ejemplo: Tipos de datos ---");

        // 5 numéricos (int, long, short, float, double)
        int a = 10;
        long b = 3000000000L;
        short c = 32000;
        float d = 4.5f;
        double e = 99.99;
        System.out.println("Numéricos: " + a + ", " + b + ", " + c + ", " + d + ", " + e);

        // 5 textos (Strings)
        String s1 = "Camilo";
        String s2 = "Universidad";
        String s3 = "POO";
        String s4 = "Ejemplo";
        String s5 = "Java";
        System.out.println("Textos: " + s1 + ", " + s2 + ", " + s3 + ", " + s4 + ", " + s5);

        // 5 booleans true / 5 booleans false (we'll show 5 true and 5 false examples)
        boolean t1 = true, t2 = true, t3 = true, t4 = true, t5 = true;
        boolean f1 = false, f2 = false, f3 = false, f4 = false, f5 = false;
        System.out.println("Booleans true: " + t1 + "," + t2 + "," + t3 + "," + t4 + "," + t5);
        System.out.println("Booleans false: " + f1 + "," + f2 + "," + f3 + "," + f4 + "," + f5);

        // 5 JSON simulados con Strings
        String json1 = "{\"nombre\":\"Camilo\"}" ;
        String json2 = "{\"edad\":20}" ;
        String json3 = "{\"activo\":true}" ;
        String json4 = "{\"producto\":\"Teclado\"}" ;
        String json5 = "{\"precio\":199.99}" ;
        System.out.println("JSONs: " + json1 + ", " + json2 + ", " + json3 + ", " + json4 + ", " + json5);

        // 5 binarios (byte arrays)
        byte[] bin1 = {1,0,1,1};
        byte[] bin2 = {0,1,0,1};
        byte[] bin3 = {1,1,1,0};
        byte[] bin4 = {0,0,1,0};
        byte[] bin5 = {1,0,0,1};
        System.out.println("Binarios (longitudes): " + bin1.length + "," + bin2.length + "," + bin3.length + "," + bin4.length + "," + bin5.length);

        System.out.println();
    }
}
