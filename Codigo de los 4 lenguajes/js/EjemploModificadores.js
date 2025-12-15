// EjemploModificadores.js
export default class EjemploModificadores {
  mostrar() {
    console.log("=== Ejemplo: Modificadores de acceso ===");

    class ModificadoresDemo {
      constructor() {
        this.publico = "soyPublico";
        this._privado = "soyPrivado"; 
        this.protegido = "soyProtegido";
        this.porDefecto = "soyPorDefecto";
      }
      mostrarTodos() {
        console.log("publico:", this.publico);
        console.log("privado:", this._privado);
        console.log("protegido:", this.protegido);
        console.log("porDefecto:", this.porDefecto);
        console.log("estatico:", ModificadoresDemo.estatico);
      }
      static estatico = "soyEstatico";
    }

    const d = new ModificadoresDemo();
    d.mostrarTodos();
    console.log("Acceso estático directo:", ModificadoresDemo.estatico);
    console.log();
  }
}
