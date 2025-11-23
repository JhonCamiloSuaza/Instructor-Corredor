class ICuenta {
    depositar() {
        throw new Error("Método 'depositar' debe ser implementado.");
    }

    retirar() {
        throw new Error("Método 'retirar' debe ser implementado.");
    }
}

module.exports = ICuenta;
