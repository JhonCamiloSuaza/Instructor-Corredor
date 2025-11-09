
/*
 * EjemploEncapsulacion.java
 * Presenta 5 ejemplos de encapsulación: clases con atributos privados y sus get/set.
 */

// 1) CuentaBancaria
class CuentaBancaria {
    private String titular;
    private double saldo;
    public CuentaBancaria(String titular, double saldo){ this.titular = titular; this.saldo = saldo; }
    public String getTitular(){ return titular; }
    public void setTitular(String t){ this.titular = t; }
    public double getSaldo(){ return saldo; }
    public void setSaldo(double s){ this.saldo = s; }
}

// 2) Usuario
class Usuario {
    private String username;
    private String password;
    public Usuario(String u, String p){ this.username=u; this.password=p; }
    public String getUsername(){ return username; }
    public void setUsername(String u){ this.username = u; }
    public String getPassword(){ return password; }
    public void setPassword(String p){ this.password = p; }
}

// 3) ProductoEncapsulado
class ProductoEncapsulado {
    private int codigo;
    private String nombre;
    private double precio;
    public ProductoEncapsulado(int codigo, String nombre, double precio){ this.codigo=codigo; this.nombre=nombre; this.precio=precio; }
    public int getCodigo(){ return codigo; } public void setCodigo(int c){ codigo=c; }
    public String getNombre(){ return nombre; } public void setNombre(String n){ nombre=n; }
    public double getPrecio(){ return precio; } public void setPrecio(double p){ precio=p; }
}

// 4) EstudianteEnc
class EstudianteEnc {
    private String nombre; private int edad;
    public EstudianteEnc(String nombre, int edad){ this.nombre=nombre; this.edad=edad; }
    public String getNombre(){ return nombre; } public void setNombre(String n){ nombre=n; }
    public int getEdad(){ return edad; } public void setEdad(int e){ edad=e; }
}

// 5) Orden
class Orden {
    private int id; private boolean pagada;
    public Orden(int id, boolean pagada){ this.id=id; this.pagada=pagada; }
    public int getId(){ return id; } public void setId(int id){ this.id = id; }
    public boolean isPagada(){ return pagada; } public void setPagada(boolean p){ pagada = p; }
}

public class EjemploEncapsulacion {
    public void mostrar() {
        System.out.println("--- Ejemplo: Encapsulación (get/set) ---");
        CuentaBancaria cb = new CuentaBancaria("Camilo", 1500.0);
        System.out.println("Titular: " + cb.getTitular() + ", Saldo: " + cb.getSaldo());
        cb.setSaldo(2000.0); System.out.println("Saldo actualizado: " + cb.getSaldo());

        Usuario u = new Usuario("camilo123","secreto"); System.out.println("Usuario: " + u.getUsername());
        u.setPassword("nuevo"); System.out.println("Password cambiado");

        ProductoEncapsulado pe = new ProductoEncapsulado(10, "Mouse", 25.5);
        System.out.println("Producto: " + pe.getNombre() + ", Precio: " + pe.getPrecio());
        pe.setPrecio(20.0); System.out.println("Precio actualizado: " + pe.getPrecio());

        EstudianteEnc est = new EstudianteEnc("Ana", 21); System.out.println("Estudiante: " + est.getNombre());
        est.setEdad(22); System.out.println("Edad actualizada: " + est.getEdad());

        Orden ord = new Orden(500, false); System.out.println("Orden pagada?: " + ord.isPagada());
        ord.setPagada(true); System.out.println("Orden pagada ahora: " + ord.isPagada());

        System.out.println();
    }
}
