const IInstrumento = require("./IInstrumento");

class Guitarra extends IInstrumento {
    constructor(marca) {
        super();
        this.marca = marca;
    }

    tocar() {
        return `La guitarra ${this.marca} está sonando `;
    }
}

module.exports = Guitarra;
