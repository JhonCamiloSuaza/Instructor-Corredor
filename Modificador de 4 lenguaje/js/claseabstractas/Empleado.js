class Empleado {
    constructor(nombre) {
        if (new.target === Empleado) {
            throw new Error("No se puede instanciar la clase abstracta Empleado directamente.");
        }
        this.nombre = nombre;
    }

    calcularSalario() {
        throw new Error("Método abstracto 'calcularSalario' debe ser implementado.");
    }
}

module.exports = Empleado;
