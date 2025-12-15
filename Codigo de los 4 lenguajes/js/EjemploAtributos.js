// EjemploAtributos.js
export default class EjemploAtributos {
  mostrar() {
    console.log(" Ejemplo: Atributos ");

    class Producto {
      constructor(codigo, nombre, precio, disponible, imagen) {
        this.codigo = codigo;
        this.nombre = nombre;
        this.precio = precio;
        this.disponible = disponible;
        this.imagen = imagen;
      }
      mostrar() {
        console.log(`Producto -> codigo: ${this.codigo}, nombre: ${this.nombre}, precio: ${this.precio}, disponible: ${this.disponible}, imagenBytes: ${this.imagen.length}`);
      }
    }

    const p = new Producto(1001, "Auriculares", 79.99, true, [1,0,1]);
    p.mostrar();

    class Persona {
      constructor(nombre, edad, activo) { this.nombre = nombre; this.edad = edad; this.activo = activo; }
      mostrarInfo() { console.log(`Persona  nombre: ${this.nombre}, edad: ${this.edad}, activo: ${this.activo}`); }
    }
    class Carro {
      constructor(marca, modelo, precio) { this.marca = marca; this.modelo = modelo; this.precio = precio; }
      mostrarInfo() { console.log(`Carro  marca: ${this.marca}, modelo: ${this.modelo}, precio: ${this.precio}`); }
    }
    class Libro {
      constructor(titulo, autor, paginas) { this.titulo = titulo; this.autor = autor; this.paginas = paginas; }
      mostrarInfo() { console.log(`Libro  titulo: ${this.titulo}, autor: ${this.autor}, paginas: ${this.paginas}`); }
    }
    class Computador {
      constructor(marca, ram, gamer) { this.marca = marca; this.ram = ram; this.gamer = gamer; }
      mostrarInfo() { console.log(`Computador  marca: ${this.marca}, RAM: ${this.ram}GB, gamer: ${this.gamer}`); }
    }

    const per = new Persona("Luis", 28, true);
    per.mostrarInfo();
    const car = new Carro("Mazda", 2019, 22000.0);
    car.mostrarInfo();
    const lib = new Libro("Aprende Java", "Carlos", 320);
    lib.mostrarInfo();
    const pc = new Computador("Asus", 32, true);
    pc.mostrarInfo();

    console.log();
  }
}
