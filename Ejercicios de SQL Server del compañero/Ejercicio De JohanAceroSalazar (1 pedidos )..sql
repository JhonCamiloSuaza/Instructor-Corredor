
-- Trabajo de Johan Acero Salazar 

-- Mer 2 Pedidos

-- Crear la base de datos
CREATE DATABASE Pedidos;
USE Pedidos;

-- Crear tabla Clientes
CREATE TABLE Clientes (
    id_cliente INT PRIMARY KEY,
    nombre_cliente VARCHAR(100)
);

-- Crear tabla Productos
CREATE TABLE Productos (
    id_producto INT PRIMARY KEY,
    nombre_producto VARCHAR(100),
    precio DECIMAL(10,2)
);

-- le falto agregar el id_cliente INT
-- Crear tabla Pedidos
CREATE TABLE Pedidos (
    id_pedido INT PRIMARY KEY,
    id_cliente INT,
    fecha DATE, 
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

-- Crear tabla Detalles_pedidos (Detalle de pedidos)
CREATE TABLE Detalles_pedidos (
    id_pedido INT,
    id_producto INT, 
    cantidad INT,
    PRIMARY KEY (id_pedido, id_producto),
    FOREIGN KEY (id_pedido) REFERENCES Pedidos(id_pedido),
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto)
);

-- Insertar datos en Clientes
INSERT INTO Clientes VALUES
(1, 'Jose Pérez'),
(2, 'Laura González'),
(3, 'Santiago Arias');

-- Insertar datos en Productos
INSERT INTO Productos VALUES
(101, 'Laptop', 3500000.00),
(102, 'Mouse', 50000.00),
(103, 'CPU', 450000.00);

-- Insertar datos en Pedidos
INSERT INTO Pedidos VALUES
(1001, 1, '2025-04-21'),
(1002, 3, '2025-05-08'),
(1003, 2, '2025-06-12');

-- Insertar datos en Detalles_pedidos
INSERT INTO Detalles_pedidos VALUES
(1001, 101, 1),
(1001, 103, 2),
(1002, 102, 5),
(1003, 102, 1),
(1003, 101, 1);

-- Operaciones de actualización
UPDATE Productos SET precio = 400000.00
WHERE id_producto = 102;

UPDATE Pedidos SET fecha = '2025-05-07'
WHERE id_pedido = 1001;

-- Consultar productos con precio > 200000
SELECT nombre_producto, precio FROM Productos;
SELECT id_producto, nombre_producto, precio FROM Productos 
WHERE precio > 200000.00;

-- en el select escribio mal P.nombre_producto, DP.cantidad ,JOIN Producto P ON DP.id_producto = P.id_producto;
-- Consulta para unir pedidos con clientes y productos
SELECT C.nombre_cliente, P.fecha, PR.nombre_producto, DP.cantidad
FROM Pedidos P
JOIN Clientes C ON P.id_cliente = C.id_cliente
JOIN Detalles_pedidos DP ON P.id_pedido = DP.id_pedido
JOIN Productos PR ON DP.id_producto = PR.id_producto;


/* no agrego la "s" a cliente 
-- Operaciones de eliminación
 esta mas se debe de hcer mas procedimiento para eliminar al cliente ya que tiene un foreign key 
 DELETE FROM Clientes WHERE id_cliente = 3;*/

-- Primero eliminar los pedidos asociados al cliente
DELETE FROM Detalles_pedidos 
WHERE id_pedido IN (SELECT id_pedido FROM Pedidos WHERE id_cliente = 3);

DELETE FROM Pedidos 
WHERE id_cliente = 3;

-- Ahora sí puedes eliminar el cliente
DELETE FROM Clientes 
WHERE id_cliente = 3;

/* DELETE FROM Productos WHERE id_producto = 101;*/
-- Primero eliminar los registros en Detalles_pedidos que lo referencian
DELETE FROM Detalles_pedidos 
WHERE id_producto = 101;

-- Ahora sí puedes eliminar el producto
DELETE FROM Productos 
WHERE id_producto = 101;
DELETE FROM Productos WHERE nombre_producto = 'Teclado ';
DELETE FROM Pedidos WHERE fecha = '2025-04-21';

-- Agregar columna email a la tabla Clientes
ALTER TABLE Clientes ADD email VARCHAR(100);
ALTER TABLE Productos DROP COLUMN precio;

-- le flato la "s"
-- Vaciar tablas (comentado ya que esto eliminaría todos los datos)
 TRUNCATE TABLE Clientes;
 TRUNCATE TABLE Pedidos;
 
-- Eliminar tablas
-- Asi debe ir el orden El compañero lo tenia DROP TABLE Detalle_pedido; DROP TABLE Producto; y sin S
DROP TABLE Detalles_pedidos;
DROP TABLE Pedidos;
DROP TABLE Productos;
DROP TABLE Clientes;
