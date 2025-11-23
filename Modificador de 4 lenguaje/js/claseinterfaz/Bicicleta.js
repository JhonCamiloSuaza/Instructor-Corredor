const IVehiculo = require("./IVehiculo");

class Bicicleta extends IVehiculo {
    constructor(marca) {
        super();
        this.marca = marca;
    }

    mover() {
        return `La bicicleta ${this.marca} avanza pedaleando.`;
    }
}

module.exports = Bicicleta;
