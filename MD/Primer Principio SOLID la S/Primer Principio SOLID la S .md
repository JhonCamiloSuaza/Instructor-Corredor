Aprendiz: Jhon Camilo Suaza Sanchez

Ficha: 3145555

Tema: Primer Principio SOLID – Principio de Responsabilidad Única (SRP)

1\. Introducción a SOLID

Los principios SOLID son un conjunto de buenas prácticas de programación orientada a objetos que ayudan a crear códigos más organizados, fáciles de mantener y de ampliar.\
El acrónimo SOLID representa cinco principios:

- S – *Single Responsibility Principle* (Responsabilidad Única)
- O – *Open/Closed Principle* (Abierto/Cerrado)
- L – *Liskov Substitution Principle* (Sustitución de Liskov)
- I – *Interface Segregation Principle* (Segregación de Interfaces)
- D – *Dependency Inversion Principle* (Inversión de Dependencias)

En esta exposición nos enfocaremos en el primer principio: el de Responsabilidad Única.

2\. Concepto del Principio de Responsabilidad Única (SRP)

El Principio de Responsabilidad Única establece que:

“Una clase debe tener una sola razón para cambiar.”

Esto significa que cada clase, módulo o función debe encargarse de una única tarea o responsabilidad específica dentro del sistema.\
Cuando una clase tiene más de una función (por ejemplo, manejar datos, imprimir reportes y conectarse a la base de datos al mismo tiempo), se vuelve difícil de mantener y da a que no ejecute por los errores.

En resumen:\
Cada clase debe hacer una sola cosa, y hacerla bien.

` `4. Ejemplos del Principio de Responsabilidad Única

**Ejemplo 1:** Clase de Usuario

**\* Incorrecto** (múltiples responsabilidades)

class Usuario {

void registrarUsuario() { ... }

void enviarCorreoBienvenida() { ... }

}

Aquí la clase maneja el registro y también el envío de correos: dos responsabilidades.

` `**- Correcto** (una sola responsabilidad por clase)

class Usuario {

void registrarUsuario() { ... }

}

class Correo {

void enviarCorreoBienvenida() { ... }

}

Ahora cada clase se encarga de una tarea específica.

**Ejemplo 2:** Factura y Reporte

**\*Incorrecto:**  Mezclar cálculo y presentación:

class Factura {

void calcularTotal() { ... }

void imprimirFactura() { ... }

}

**- Correcto:**  Separar responsabilidades:

class Factura {

void calcularTotal() { ... }

}

class ReporteFactura {

void imprimirFactura() { ... }

}



Ejemplo 3: Gestión de Empleados

**\*Incorrecto:** Una clase que hace de todo:

class Empleado {

void calcularSueldo() { ... }

void guardarEnBaseDatos() { ... }

}

**-Correcto:** Aplicando SRP:

class Empleado {

void calcularSueldo() { ... }

}

class EmpleadoDB {

void guardar(Empleado emanuel) { ... }

}

Ejemplo 4: Sistema de Notificaciones

**\*Incorrecto:** Una clase que notifica por varios medios:

class Notificador {

void enviarCorreo() { ... }

void enviarSMS() { ... }

}

**-Correcto:** Separar por tipo:

class NotificadorCorreo {

void enviarCorreo() { ... }

}

class NotificadorSMS {

void enviarSMS() { ... }

}



Ejemplo 5: Aplicación de Ventas

**\*Incorrecto:** Todo en una clase:

class Venta {

void calcularPrecio() { ... }

void generarReporte() { ... }

void enviarCorreoCliente() { ... }

}

**-Correcto:** Aplicando SRP:

class Venta {

void calcularPrecio() { ... }

}

class ReporteVenta {

void generarReporte() { ... }

}

class CorreoCliente {

void enviarCorreoCliente() { ... }

}

` `5. Conclusión

El Principio de Responsabilidad Única nos enseña que la simplicidad es la clave de la calidad del código.\
Cuando cada clase tiene un único propósito, nuestro software se vuelve más limpio, ordenado y fácil de mantener.\
Aplicar este principio es el primer paso para lograr una programación orientada a objetos profesional y escalable.

