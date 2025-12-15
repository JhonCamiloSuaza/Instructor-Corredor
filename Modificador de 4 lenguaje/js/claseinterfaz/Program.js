const Bicicleta = require("./Bicicleta");
const Banco = require("./Banco");
const Guitarra = require("./Guitarra");

function main() {
    console.log("EJEMPLO DE INTERFACES ");

    // IVehiculo / Bicicleta 
    console.log(" Probando IVehiculo -> Bicicleta");
    let bici1 = new Bicicleta("GW");
    let bici2 = new Bicicleta("Specialized");
    console.log(bici1.mover());
    console.log(bici2.mover());

    //  ICuenta / Banco 
    console.log("\n>> Probando ICuenta -> Banco");
    let cuenta = new Banco("Banco de Jhon");
    console.log(cuenta.depositar(500));
    console.log(cuenta.retirar(200));
    console.log(cuenta.retirar(400)); 

    //  IInstrumento / Guitarra 
    console.log("\n>> Probando IInstrumento -> Guitarra");
    let g1 = new Guitarra("Yamaha");
    let g2 = new Guitarra("Fender");
    console.log(g1.tocar());
    console.log(g2.tocar());

    console.log(" FIN DE EJECUCIÓN");
}

main();
