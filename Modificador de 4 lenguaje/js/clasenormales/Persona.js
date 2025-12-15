class Persona {
    constructor() {
        this.nombre = "Desconocido";
        this.edad = 0;
    }

    mostrar() {
        console.log(`Nombre: ${this.nombre}, Edad: ${this.edad}`);
    }
}

module.exports = Persona;
