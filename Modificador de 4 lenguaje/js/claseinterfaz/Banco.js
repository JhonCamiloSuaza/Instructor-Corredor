const ICuenta = require("./ICuenta");

class Banco extends ICuenta {
    constructor(nombre) {
        super();
        this.nombre = nombre;
        this.saldo = 0;
    }

    depositar(monto) {
        this.saldo += monto;
        return `Depositados $${monto}. Saldo actual: $${this.saldo}`;
    }

    retirar(monto) {
        if (monto > this.saldo) {
            return "Fondos insuficientes.";
        }
        this.saldo -= monto;
        return `Retirados $${monto}. Saldo actual: $${this.saldo}`;
    }
}

module.exports = Banco;
