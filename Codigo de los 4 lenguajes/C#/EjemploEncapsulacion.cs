using System;

public class CuentaBancaria
{
    private string Titular;
    private double Saldo;
    public CuentaBancaria(string titular,double saldo){ Titular=titular; Saldo=saldo; }
    public string GetTitular(){ return Titular; }
    public void SetTitular(string t){ Titular=t; }
    public double GetSaldo(){ return Saldo; }
    public void SetSaldo(double s){ Saldo=s; }
}

public class Usuario
{
    private string Username;
    private string Password;
    public Usuario(string u,string p){ Username=u; Password=p; }
    public string GetUsername(){ return Username; }
    public void SetUsername(string u){ Username=u; }
    public string GetPassword(){ return Password; }
    public void SetPassword(string p){ Password=p; }
}

public class ProductoEncapsulado
{
    private int Codigo;
    private string Nombre;
    private double Precio;
    public ProductoEncapsulado(int codigo,string nombre,double precio){ Codigo=codigo; Nombre=nombre; Precio=precio; }
    public int GetCodigo(){ return Codigo; } public void SetCodigo(int c){ Codigo=c; }
    public string GetNombre(){ return Nombre; } public void SetNombre(string n){ Nombre=n; }
    public double GetPrecio(){ return Precio; } public void SetPrecio(double p){ Precio=p; }
}

public class EstudianteEnc
{
    private string Nombre; private int Edad;
    public EstudianteEnc(string nombre,int edad){ Nombre=nombre; Edad=edad; }
    public string GetNombre(){ return Nombre; } public void SetNombre(string n){ Nombre=n; }
    public int GetEdad(){ return Edad; } public void SetEdad(int e){ Edad=e; }
}

public class Orden
{
    private int Id; private bool Pagada;
    public Orden(int id,bool pagada){ Id=id; Pagada=pagada; }
    public int GetId(){ return Id; } public void SetId(int id){ Id=id; }
    public bool IsPagada(){ return Pagada; } public void SetPagada(bool p){ Pagada=p; }
}

public class EjemploEncapsulacion
{
    public void Mostrar()
    {
        Console.WriteLine("--- Ejemplo: Encapsulación (get/set) ---");

        CuentaBancaria cb = new CuentaBancaria("Camilo",1500.0);
        Console.WriteLine("Titular: " + cb.GetTitular() + ", Saldo: " + cb.GetSaldo());
        cb.SetSaldo(2000.0); Console.WriteLine("Saldo actualizado: " + cb.GetSaldo());

        Usuario u = new Usuario("camilo123","secreto");
        Console.WriteLine("Usuario: " + u.GetUsername());
        u.SetPassword("nuevo"); Console.WriteLine("Password cambiado");

        ProductoEncapsulado pe = new ProductoEncapsulado(10,"Mouse",25.5);
        Console.WriteLine("Producto: " + pe.GetNombre() + ", Precio: " + pe.GetPrecio());
        pe.SetPrecio(20.0); Console.WriteLine("Precio actualizado: " + pe.GetPrecio());

        EstudianteEnc est = new EstudianteEnc("Ana",21);
        Console.WriteLine("Estudiante: " + est.GetNombre());
        est.SetEdad(22); Console.WriteLine("Edad actualizada: " + est.GetEdad());

        Orden ord = new Orden(500,false);
        Console.WriteLine("Orden pagada?: " + ord.IsPagada());
        ord.SetPagada(true); Console.WriteLine("Orden pagada ahora: " + ord.IsPagada());

        Console.WriteLine();
    }
}
