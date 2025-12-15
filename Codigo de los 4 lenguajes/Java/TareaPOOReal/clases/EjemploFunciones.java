
/*
 * EjemploFunciones.java
 * Muestra 5 funciones (métodos con retorno) con ejemplos reales.
 */

public class EjemploFunciones {
    public void mostrar() {
        System.out.println("Ejemplo: Funciones con retorno ");
        Persona p = new Persona("Sofia", 19, false);
        System.out.println("Nombre persona: " + p.nombre);
        System.out.println("Es mayor?: " + esMayor(p.edad));
        System.out.println("Area rectángulo 3x4: " + areaRectangulo(3,4));
        System.out.println("Precio con descuento (100, 10%): " + aplicarDescuento(100.0, 10));
        System.out.println("Obtener inicial nombre: " + inicial(p.nombre));
        System.out.println();
    }

    public boolean esMayor(int edad){ return edad >= 18; }
    public double areaRectangulo(double base, double altura){ return base * altura; }
    public double aplicarDescuento(double precio, double porcentaje){ return precio * (1 - porcentaje/100.0); }
    public char inicial(String nombre){ return nombre.charAt(0); }
    public String repetir(String s, int veces){ StringBuilder sb = new StringBuilder(); for(int i=0;i<veces;i++) sb.append(s); return sb.toString(); }
}
