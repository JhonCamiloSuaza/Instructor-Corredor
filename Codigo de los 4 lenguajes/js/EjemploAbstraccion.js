// EjemploAbstraccion.js
export default class EjemploAbstraccion {
  mostrar() {
    console.log("--- Ejemplo: Abstracción ---");

    class Figura {
      area() { throw new Error("Método 'area()' debe ser implementado por la subclase"); }
      mostrarArea() { console.log("Área = " + this.area()); }
    }
    class Rectangulo extends Figura {
      constructor(b, h) { super(); this.base = b; this.altura = h; }
      area() { return this.base * this.altura; }
    }

    class Vehiculo { arrancar() { throw new Error("Implementar arrancar()"); } }
    class Moto extends Vehiculo { arrancar() { console.log("Moto arrancó"); } }

    class Empleado {
      calcularPago() { throw new Error("Implementar calcularPago()"); }
      obtenerNombre() { throw new Error("Implementar obtenerNombre()"); }
    }
    class EmpleadoPlanta extends Empleado {
      constructor(nombre, salario) { super(); this.nombre = nombre; this.salario = salario; }
      calcularPago() { return this.salario; }
      obtenerNombre() { return this.nombre; }
    }

    class AnimalAbstracto { hablar() { throw new Error("Implementar hablar()"); } }
    class Perro extends AnimalAbstracto { hablar() { console.log("Guau"); } }

    class Electrodomestico { encender() { throw new Error("Implementar encender()"); } }
    class Televisor extends Electrodomestico { encender() { console.log("Televisor encendido"); } }

    const r = new Rectangulo(3,4); r.mostrarArea();
    const m = new Moto(); m.arrancar();
    const emp = new EmpleadoPlanta("Laura", 1200); console.log("Pago:", emp.calcularPago());
    const perro = new Perro(); perro.hablar();
    const tv = new Televisor(); tv.encender();

    console.log();
  }
}
