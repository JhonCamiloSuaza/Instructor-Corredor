const Persona = require("Persona");
const Coche = require("Coche");
const Libro = require("Libro");
const Animal = require("Animal");
const Computadora = require("Computadora");

function main() {
    console.log(" Ejemplo de Clases en ");

    let persona = new Persona();
    persona.mostrar();

    let coche = new Coche("Toyota", "Corolla");
    coche.mostrar();

    let libro1 = new Libro("1984", "George Orwell");
    let libro2 = Libro.copiar(libro1);
    libro1.mostrar();
    libro2.mostrar();

    let animal1 = new Animal("Perro", 5);
    let animal2 = new Animal("Gato");
    let animal3 = new Animal();
    animal1.mostrar();
    animal2.mostrar();
    animal3.mostrar();

    let pc = new Computadora("Dell", 16);
    pc.mostrar();
}

main();
