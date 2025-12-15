class Computadora {
    constructor(marca, ram) {
        this.marca = marca;
        this.ram = ram;
    }

    mostrar() {
        console.log(`Computadora: ${this.marca}, RAM: ${this.ram}GB`);
    }
}

module.exports = Computadora;
