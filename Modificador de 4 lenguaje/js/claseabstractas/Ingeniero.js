const Empleado = require("./Empleado");

class Ingeniero extends Empleado {
    constructor(nombre, horas, tarifa) {
        super(nombre);
        this.horas = horas;
        this.tarifa = tarifa;
    }

    calcularSalario() {
        return this.horas * this.tarifa;
    }
}

module.exports = Ingeniero;
