// EjemploClases.js
export default class EjemploClases {
  mostrar() {
    console.log(" Ejemplo: Clases reales ");

    class Persona {
      constructor(nombre, edad, activo) {
        this.nombre = nombre;
        this.edad = edad;
        this.activo = activo;
      }
      mostrarInfo() {
        console.log(`Persona  nombre: ${this.nombre}, edad: ${this.edad}, activo: ${this.activo}`);
      }
    }

    class Carro {
      constructor(marca, modelo, precio) {
        this.marca = marca;
        this.modelo = modelo;
        this.precio = precio;
      }
      mostrarInfo() {
        console.log(`Carro  marca: ${this.marca}, modelo: ${this.modelo}, precio: ${this.precio}`);
      }
    }

    class Animal {
      constructor(especie, nombre, domestico) {
        this.especie = especie;
        this.nombre = nombre;
        this.domestico = domestico;
      }
      mostrarInfo() {
        console.log(`Animal  especie: ${this.especie}, nombre: ${this.nombre}, domestico: ${this.domestico}`);
      }
    }

    class Libro {
      constructor(titulo, autor, paginas) {
        this.titulo = titulo;
        this.autor = autor;
        this.paginas = paginas;
      }
      mostrarInfo() {
        console.log(`Libro  titulo: ${this.titulo}, autor: ${this.autor}, paginas: ${this.paginas}`);
      }
    }

    class Computador {
      constructor(marca, ramGb, encendido) {
        this.marca = marca;
        this.ramGb = ramGb;
        this.encendido = encendido;
      }
      mostrarInfo() {
        console.log(`Computador  marca: ${this.marca}, RAM: ${this.ramGb}GB, encendido: ${this.encendido}`);
      }
    }

    const p = new Persona("Camilo", 20, true);
    const c = new Carro("Toyota", 2020, 35000.0);
    const a = new Animal("Perro", "Firulais", true);
    const l = new Libro("POO en Java", "Autor X", 250);
    const pc = new Computador("Dell", 16, false);

    p.mostrarInfo();
    c.mostrarInfo();
    a.mostrarInfo();
    l.mostrarInfo();
    pc.mostrarInfo();
    console.log();
  }
}
