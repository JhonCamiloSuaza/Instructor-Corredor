using System;

public class Maquina
{
    private bool Encendida = false;
    public void Encender(){ Encendida = true; Console.WriteLine("Máquina encendida"); }
    public void Apagar(){ Encendida = false; Console.WriteLine("Máquina apagada"); }
    public bool EstaEncendida(){ return Encendida; }
    public void Reiniciar(){ Console.WriteLine("Reiniciando..."); Encendida=false; Encendida=true; }
    public void Detener(){ Console.WriteLine("Máquina detenida"); }
}

public class EjemploMetodosSinParametros
{
    public void Mostrar()
    {
        Console.WriteLine(" Ejemplo: Métodos sin parámetros ");
        Maquina m = new Maquina();
        m.Encender();
        m.Detener();
        Console.WriteLine("Estado encendida?: " + m.EstaEncendida());
        m.Reiniciar();
        m.Apagar();
        Console.WriteLine();
    }
}
