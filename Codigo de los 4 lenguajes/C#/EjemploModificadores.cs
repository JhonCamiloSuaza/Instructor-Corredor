using System;

class ModificadoresDemo
{
    public string Publico = "soyPublico";
    private string Privado = "soyPrivado";
    protected string Protegido = "soyProtegido";
    string PorDefecto = "soyPorDefecto";
    public static string Estatico = "soyEstatico";

    public void MostrarTodos()
    {
        Console.WriteLine("publico: " + Publico);
        Console.WriteLine("privado: " + Privado);
        Console.WriteLine("protegido: " + Protegido);
        Console.WriteLine("porDefecto: " + PorDefecto);
        Console.WriteLine("estatico: " + Estatico);
    }
}

public class EjemploModificadores
{
    public void Mostrar()
    {
        Console.WriteLine(" Ejemplo: Modificadores de acceso");
        ModificadoresDemo d = new ModificadoresDemo();
        d.MostrarTodos();

        Console.WriteLine("Acceso estático directo: " + ModificadoresDemo.Estatico);
        Console.WriteLine();
    }
}
