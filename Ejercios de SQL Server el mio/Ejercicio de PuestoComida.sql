-- Crear base de datos
CREATE DATABASE PuestoComida;
USE PuestoComida;

-- Cliente
CREATE TABLE Cliente (
    id_cliente INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(50) UNIQUE NOT NULL,
    telefono VARCHAR(20)
);

-- Empleado
CREATE TABLE Empleado (
    id_empleado INT PRIMARY KEY,
    nombre VARCHAR(100),
    cargo VARCHAR(50)
);

-- Producto
CREATE TABLE Producto (
    id_producto INT PRIMARY KEY,
    nombre_producto VARCHAR(50),
    precio DECIMAL(6,2)
);

-- Pedido
CREATE TABLE Pedido (
    id_pedido INT PRIMARY KEY,
    id_cliente INT,
    id_empleado INT,
    fecha DATE NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado)
);

-- Promocion
CREATE TABLE Promocion (
    id_promocion INT PRIMARY KEY,
    descripcion VARCHAR(100),
    descuento DECIMAL(5,2)
);

-- Pivote: Detalle_Pedido (Pedido ↔ Producto)
CREATE TABLE Detalle_Pedido (
    id_pedido INT,
    id_producto INT,
    cantidad INT,
    PRIMARY KEY (id_pedido, id_producto),
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido),
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

-- Pivote: Empleado_Promocion (Empleado ↔ Promocion)
CREATE TABLE Empleado_Promocion (
    id_empleado INT,
    id_promocion INT,
    PRIMARY KEY (id_empleado, id_promocion),
    FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado),
    FOREIGN KEY (id_promocion) REFERENCES Promocion(id_promocion)
);

-- Insertar datos
INSERT INTO Cliente VALUES 
(1, 'Carlos Ramírez', 'carlos@correo.com', '3214567890'),
(2, 'Ana López', 'ana@correo.com', '3009876543');

INSERT INTO Empleado VALUES 
(1, 'Laura Torres', 'Mesera'),
(2, 'Luis Pérez', 'Cocinero');

INSERT INTO Producto VALUES 
(1, 'Hamburguesa', 12.50),
(2, 'Refresco', 3.00);

INSERT INTO Pedido VALUES 
(1, 1, 1, '2025-06-10'),
(2, 2, 2, '2025-06-11');

INSERT INTO Promocion VALUES 
(1, 'Descuento del día', 10.00),
(2, 'Combo familiar', 15.00);

INSERT INTO Detalle_Pedido VALUES 
(1, 1, 2),
(1, 2, 1),
(2, 1, 1);

INSERT INTO Empleado_Promocion VALUES 
(1, 1),
(2, 2);

-- Actualización
UPDATE Producto SET precio = 13.00 WHERE id_producto = 1;

-- Eliminación controlada
DELETE FROM Detalle_Pedido WHERE id_pedido = 2;
DELETE FROM Pedido WHERE id_pedido = 2;

-- JOIN: productos por pedido
SELECT 
    c.nombre AS cliente, p.fecha, pr.nombre_producto, dp.cantidad
FROM Pedido p
JOIN Cliente c ON p.id_cliente = c.id_cliente
JOIN Detalle_Pedido dp ON p.id_pedido = dp.id_pedido
JOIN Producto pr ON dp.id_producto = pr.id_producto;

-- Subconsulta: clientes con pedidos que superan 20
SELECT nombre FROM Cliente
WHERE id_cliente IN (
    SELECT pe.id_cliente
    FROM Pedido pe
    JOIN Detalle_Pedido dp ON pe.id_pedido = dp.id_pedido
    JOIN Producto pr ON dp.id_producto = pr.id_producto
    GROUP BY pe.id_cliente
    HAVING SUM(dp.cantidad * pr.precio) > 20
);

-- Funciones agregadas

-- MAX: precio más alto
SELECT MAX(precio) AS precio_mas_alto FROM Producto;

-- MIN: precio más bajo
SELECT MIN(precio) AS precio_mas_bajo FROM Producto;

-- SUM: total ingresos
SELECT SUM(dp.cantidad * pr.precio) AS total_ventas
FROM Detalle_Pedido dp
JOIN Producto pr ON dp.id_producto = pr.id_producto;

-- Crear vista
CREATE VIEW Vista_Pedidos_Productos AS
SELECT p.id_pedido, c.nombre AS cliente, pr.nombre_producto, dp.cantidad
FROM Pedido p
JOIN Cliente c ON p.id_cliente = c.id_cliente
JOIN Detalle_Pedido dp ON p.id_pedido = dp.id_pedido
JOIN Producto pr ON dp.id_producto = pr.id_producto;

-- ALTER: agregar teléfono a Empleado
ALTER TABLE Empleado ADD telefono VARCHAR(20);

-- TRUNCATE: limpiar promociones
TRUNCATE TABLE Promocion;

-- DROP en orden correcto
DROP TABLE Detalle_Pedido;
DROP TABLE Empleado_Promocion;
DROP TABLE Pedido;
DROP TABLE Promocion;
DROP TABLE Producto;
DROP TABLE Cliente;
DROP TABLE Empleado;

-- Eliminar base de datos
DROP DATABASE PuestoComida;

-- RESUMEN DE FUNCIONES AGREGADAS:
-- MAX (Máximo): Se utilizó 1 vez para obtener el precio más alto
-- MIN (Mínimo): Se utilizó 1 vez para obtener el precio más bajo
-- SUM (Suma): Se utilizó 1 vez para obtener el total de ventas