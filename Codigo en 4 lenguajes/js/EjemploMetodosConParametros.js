// EjemploMetodosConParametros.js
export default class EjemploMetodosConParametros {
  mostrar() {
    console.log("=== Ejemplo: Métodos con parámetros ===");

    class Calculadora {
      sumar(a, b) { return a + b; }
      multiplicar(a, b) { return a * b; }
      calcularIVA(precio) { return precio * 0.19; }
      registrarPersona(nombre, edad) { console.log(`  Registrado: ${nombre}, ${edad} años`); }
      esMayor(edad) { return edad >= 18; }
    }

    const calc = new Calculadora();
    console.log("Sumar 2+3 =", calc.sumar(2,3));
    console.log("Multiplicar 4*5 =", calc.multiplicar(4,5));
    console.log("Calcular IVA de 100 =", calc.calcularIVA(100.0));
    console.log("Registrar persona:");
    calc.registrarPersona("María", 22);
    console.log("Verificar mayor (edad 17):", calc.esMayor(17));
    console.log();
  }
}
