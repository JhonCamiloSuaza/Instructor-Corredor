// EjemploMetodosSinParametros.js
export default class EjemploMetodosSinParametros {
  mostrar() {
    console.log("=== Ejemplo: Métodos sin parámetros ===");

    class Maquina {
      constructor() { this.encendida = false; }
      encender() { this.encendida = true; console.log("Máquina encendida"); }
      apagar() { this.encendida = false; console.log("Máquina apagada"); }
      estaEncendida() { return this.encendida; }
      reiniciar() { console.log("Reiniciando..."); this.encendida = false; this.encendida = true; }
      detener() { console.log("Máquina detenida"); }
    }

    const m = new Maquina();
    m.encender();
    m.detener();
    console.log("Estado encendida?:", m.estaEncendida());
    m.reiniciar();
    m.apagar();
    console.log();
  }
}
