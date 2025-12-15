// EjemploObjetos.js
import EjemploClasesModule from './EjemploClases.js';

export default class EjemploObjetos {
  mostrar() {
    console.log(" Ejemplo: Objetos ");

    // Reuse class definitions similar to EjemploClases but keep simple standalone definitions
    class Persona {
      constructor(nombre, edad, activo) { this.nombre = nombre; this.edad = edad; this.activo = activo; }
      mostrarInfo() { console.log(`Persona  nombre: ${this.nombre}, edad: ${this.edad}, activo: ${this.activo}`); }
    }
    class Carro {
      constructor(marca, modelo, precio) { this.marca = marca; this.modelo = modelo; this.precio = precio; }
      mostrarInfo() { console.log(`Carro  marca: ${this.marca}, modelo: ${this.modelo}, precio: ${this.precio}`); }
    }
    class Animal {
      constructor(especie, nombre, domestico) { this.especie = especie; this.nombre = nombre; this.domestico = domestico; }
      mostrarInfo() { console.log(`Animal  especie: ${this.especie}, nombre: ${this.nombre}, domestico: ${this.domestico}`); }
    }
    class Libro {
      constructor(titulo, autor, paginas) { this.titulo = titulo; this.autor = autor; this.paginas = paginas; }
      mostrarInfo() { console.log(`Libro  titulo: ${this.titulo}, autor: ${this.autor}, paginas: ${this.paginas}`); }
    }
    class Computador {
      constructor(marca, ramGb, encendido) { this.marca = marca; this.ramGb = ramGb; this.encendido = encendido; }
      mostrarInfo() { console.log(`Computador  marca: ${this.marca}, RAM: ${this.ramGb}GB, encendido: ${this.encendido}`); }
    }

    const persona1 = new Persona("Ana", 30, true);
    persona1.mostrarInfo();

    const carro1 = new Carro("Honda", 2018, 18000.0);
    carro1.mostrarInfo();

    const animal1 = new Animal("Gato", "Michi", true);
    animal1.mostrarInfo();

    const libro1 = new Libro("Java Básico", "María", 150);
    libro1.mostrarInfo();

    const comp1 = new Computador("lenovo", 8, true);
    comp1.mostrarInfo();

    console.log();
  }
}
