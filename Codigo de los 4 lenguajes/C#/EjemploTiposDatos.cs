/*
 * EjemploTiposDatos.cs
 * Muestra 5 ejemplos por tipo de dato: numérico, texto, boolean, JSON(simulado), binario.
 */

using System;

public class EjemploTiposDatos
{
    public void Mostrar()
    {
        Console.WriteLine("--- Ejemplo: Tipos de datos ---");

        // 5 numéricos (int, long, short, float, double)
        int a = 10;
        long b = 3000000000L;
        short c = 32000;
        float d = 4.5f;
        double e = 99.99;
        Console.WriteLine($"Numéricos: {a}, {b}, {c}, {d}, {e}");

        // 5 textos (Strings)
        string s1 = "Camilo";
        string s2 = "Universidad";
        string s3 = "POO";
        string s4 = "Ejemplo";
        string s5 = "C#";
        Console.WriteLine($"Textos: {s1}, {s2}, {s3}, {s4}, {s5}");

        // 5 booleans true / 5 booleans false
        bool t1 = true, t2 = true, t3 = true, t4 = true, t5 = true;
        bool f1 = false, f2 = false, f3 = false, f4 = false, f5 = false;
        Console.WriteLine($"Booleans true: {t1},{t2},{t3},{t4},{t5}");
        Console.WriteLine($"Booleans false: {f1},{f2},{f3},{f4},{f5}");

        // 5 JSON simulados con Strings
        string json1 = "{\"nombre\":\"Camilo\"}";
        string json2 = "{\"edad\":20}";
        string json3 = "{\"activo\":true}";
        string json4 = "{\"producto\":\"Teclado\"}";
        string json5 = "{\"precio\":199.99}";
        Console.WriteLine($"JSONs: {json1}, {json2}, {json3}, {json4}, {json5}");

        // 5 binarios (byte arrays)
        byte[] bin1 = {1, 0, 1, 1};
        byte[] bin2 = {0, 1, 0, 1};
        byte[] bin3 = {1, 1, 1, 0};
        byte[] bin4 = {0, 0, 1, 0};
        byte[] bin5 = {1, 0, 0, 1};
        Console.WriteLine($"Binarios (longitudes): {bin1.Length},{bin2.Length},{bin3.Length},{bin4.Length},{bin5.Length}");

        Console.WriteLine();
    }
}
