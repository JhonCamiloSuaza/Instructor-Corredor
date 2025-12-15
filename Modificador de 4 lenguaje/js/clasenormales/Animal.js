class Animal {
    constructor(nombre, edad) {
        if (nombre && edad) {
            this.nombre = nombre;
            this.edad = edad;
        } else if (nombre) {
            this.nombre = nombre;
            this.edad = 0;
        } else {
            this.nombre = "Sin nombre";
            this.edad = 0;
        }
    }

    mostrar() {
        console.log(`Animal: ${this.nombre}, Edad: ${this.edad}`);
    }
}

module.exports = Animal;
