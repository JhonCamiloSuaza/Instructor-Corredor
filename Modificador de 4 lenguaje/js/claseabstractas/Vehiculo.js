class Vehiculo {
    constructor() {
        if (new.target === Vehiculo) {
            throw new Error("No se puede instanciar la clase abstracta Vehiculo directamente.");
        }
    }

    mover() {
        throw new Error("Método abstracto 'mover' debe ser implementado.");
    }
}

module.exports = Vehiculo;
