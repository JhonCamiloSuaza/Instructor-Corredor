// EjemploTiposDatos.js
export default class EjemploTiposDatos {
  mostrar() {
    console.log(" Ejemplo: Tipos de datos ");

    let a = 10;
    let b = 3000000000;
    let c = 32000;
    let d = 4.5;
    let e = 99.99;
    console.log("Numéricos:", a, b, c, d, e);

    let s1 = "Camilo", s2 = "Universidad", s3 = "POO", s4 = "Ejemplo", s5 = "JavaScript";
    console.log("Textos:", s1, s2, s3, s4, s5);

    let trues = [true, true, true, true, true];
    let falses = [false, false, false, false, false];
    console.log("Booleans true:", trues.join(", "));
    console.log("Booleans false:", falses.join(", "));

    let json1 = { nombre: "Camilo" };
    let json2 = { edad: 20 };
    let json3 = { activo: true };
    let json4 = { producto: "Teclado" };
    let json5 = { precio: 199.99 };
    console.log("JSONs:", json1, json2, json3, json4, json5);

    let bin1 = [1,0,1,1], bin2 = [0,1,0,1], bin3 = [1,1,1,0], bin4 = [0,0,1,0], bin5 = [1,0,0,1];
    console.log("Binarios (longitudes):", bin1.length, bin2.length, bin3.length, bin4.length, bin5.length);

    console.log();
  }
}
