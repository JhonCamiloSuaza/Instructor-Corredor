// Importamos SOLO las clases concretas
const Circulo = require("Circulo");
const Ingeniero = require("Ingeniero");
const Bicicleta = require("Bicicleta");

function main() {
    console.log("EJEMPLO DE CLASES ABSTRACTAS \n");

    // FIGURA / CIRCULO 
    console.log(" Probando Figura  Circulo");
    let c1 = new Circulo(5);
    let c2 = new Circulo(10);
    console.log("Área círculo 1:", c1.calcularArea());
    console.log("Área círculo 2:", c2.calcularArea());

    // EMPLEADO / INGENIERO 
    console.log("\n Probando Empleado  Ingeniero");
    let ing1 = new Ingeniero("Jhon", 160, 50);
    let ing2 = new Ingeniero("Ana", 120, 60);
    console.log(`Salario de ${ing1.nombre}: $${ing1.calcularSalario()}`);
    console.log(`Salario de ${ing2.nombre}: $${ing2.calcularSalario()}`);

    //  VEHICULO / BICICLETA 
    console.log("\n>> Probando Vehiculo  Bicicleta");
    let bici1 = new Bicicleta("GW");
    let bici2 = new Bicicleta("Specialized");
    console.log(bici1.mover());
    console.log(bici2.mover());

    console.log("\n FIN DE EJECUCIÓN ");
}

main();
