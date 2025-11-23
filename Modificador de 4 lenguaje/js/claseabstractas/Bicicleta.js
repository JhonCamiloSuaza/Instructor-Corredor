const Vehiculo = require("./Vehiculo");

class Bicicleta extends Vehiculo {
    constructor(marca) {
        super();
        this.marca = marca;
    }

    mover() {
        return `La bicicleta ${this.marca} avanza pedaleando.`;
    }
}

module.exports = Bicicleta;
