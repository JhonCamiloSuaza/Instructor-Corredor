// EjemploEncapsulacion.js
export default class EjemploEncapsulacion {
  mostrar() {
    console.log(" Ejemplo: Encapsulación (get/set)");

    class CuentaBancaria {
      #titular;
      #saldo;
      constructor(titular, saldo) { this.#titular = titular; this.#saldo = saldo; }
      getTitular() { return this.#titular; }
      setTitular(t) { this.#titular = t; }
      getSaldo() { return this.#saldo; }
      setSaldo(s) { this.#saldo = s; }
    }

    class Usuario {
      #username;
      #password;
      constructor(u,p){ this.#username = u; this.#password = p; }
      getUsername(){ return this.#username; }
      setUsername(u){ this.#username = u; }
      getPassword(){ return this.#password; }
      setPassword(p){ this.#password = p; }
    }

    class ProductoEncapsulado {
      #codigo; #nombre; #precio;
      constructor(codigo,nombre,precio){ this.#codigo = codigo; this.#nombre = nombre; this.#precio = precio; }
      getCodigo(){ return this.#codigo; } setCodigo(c){ this.#codigo = c; }
      getNombre(){ return this.#nombre; } setNombre(n){ this.#nombre = n; }
      getPrecio(){ return this.#precio; } setPrecio(p){ this.#precio = p; }
    }

    class EstudianteEnc {
      #nombre; #edad;
      constructor(nombre, edad){ this.#nombre = nombre; this.#edad = edad; }
      getNombre(){ return this.#nombre; } setNombre(n){ this.#nombre = n; }
      getEdad(){ return this.#edad; } setEdad(e){ this.#edad = e; }
    }

    class Orden {
      #id; #pagada;
      constructor(id, pagada){ this.#id = id; this.#pagada = pagada; }
      getId(){ return this.#id; } setId(id){ this.#id = id; }
      isPagada(){ return this.#pagada; } setPagada(p){ this.#pagada = p; }
    }

    const cb = new CuentaBancaria("Camilo", 1500.0);
    console.log("Titular:", cb.getTitular(), ", Saldo:", cb.getSaldo());
    cb.setSaldo(2000.0); console.log("Saldo actualizado:", cb.getSaldo());

    const u = new Usuario("camilo123", "secreto"); console.log("Usuario:", u.getUsername());
    u.setPassword("nuevo"); console.log("Password cambiado");

    const pe = new ProductoEncapsulado(10, "Mouse", 25.5);
    console.log("Producto:", pe.getNombre(), ", Precio:", pe.getPrecio());
    pe.setPrecio(20.0); console.log("Precio actualizado:", pe.getPrecio());

    const est = new EstudianteEnc("Ana", 21); console.log("Estudiante:", est.getNombre());
    est.setEdad(22); console.log("Edad actualizada:", est.getEdad());

    const ord = new Orden(500, false); console.log("Orden pagada?:", ord.isPagada());
    ord.setPagada(true); console.log("Orden pagada ahora:", ord.isPagada());

    console.log();
  }
}
