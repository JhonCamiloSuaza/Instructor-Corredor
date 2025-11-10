// main.js
import EjemploClases from './EjemploClases.js';
import EjemploObjetos from './EjemploObjetos.js';
import EjemploModificadores from './EjemploModificadores.js';
import EjemploTiposDatos from './EjemploTiposDatos.js';
import EjemploAtributos from './EjemploAtributos.js';
import EjemploMetodosConParametros from './EjemploMetodosConParametros.js';
import EjemploMetodosSinParametros from './EjemploMetodosSinParametros.js';
import EjemploFunciones from './EjemploFunciones.js';
import EjemploAbstraccion from './EjemploAbstraccion.js';
import EjemploEncapsulacion from './EjemploEncapsulacion.js';

console.log(" TAREA POO REALISTA - Ejecutando ejemplos \n");

await new EjemploClases().mostrar();
await new EjemploObjetos().mostrar();
await new EjemploModificadores().mostrar();
await new EjemploTiposDatos().mostrar();
await new EjemploAtributos().mostrar();
await new EjemploMetodosConParametros().mostrar();
await new EjemploMetodosSinParametros().mostrar();
await new EjemploFunciones().mostrar();
await new EjemploAbstraccion().mostrar();
await new EjemploEncapsulacion().mostrar();

console.log("FIN DE LA EJECUCIÓN");
