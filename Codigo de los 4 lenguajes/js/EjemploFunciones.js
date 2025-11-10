// EjemploFunciones.js
// (No se proporcionó el Java original; aquí incluyo un conjunto de funciones de ejemplo)
export default class EjemploFunciones {
  mostrar() {
    console.log("=== Ejemplo: Funciones (ejemplos) ===");

    // Función pura
    function sumar(a, b) { return a + b; }

    // Función que muta (ejemplo controlado)
    function agregarAlArray(arr, valor) { arr.push(valor); }

    // Función asíncrona simulada con Promise
    function esperar(ms) { return new Promise(resolve => setTimeout(resolve, ms)); }

    // Uso
    console.log("sumar(3,4) =", sumar(3,4));
    const arr = [1,2];
    agregarAlArray(arr, 3);
    console.log("Array tras agregar:", arr);

    // demostrar la función asíncrona con then (no bloquear)
    esperar(10).then(() => {
      console.log("Esperé 10ms (simulado) - ejemplo de función asíncrona");
      console.log();
    });
  }
}
