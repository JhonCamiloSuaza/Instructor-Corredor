class Coche {
    constructor(marca, modelo) {
        this.marca = marca;
        this.modelo = modelo;
    }

    mostrar() {
        console.log(`Coche: ${this.marca} ${this.modelo}`);
    }
}

module.exports = Coche;
