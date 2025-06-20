-- 1. Crear base de datos
CREATE DATABASE Licorera;
USE Licorera;

-- 2. Crear tablas
CREATE TABLE Cliente (
    id_cliente INT PRIMARY KEY,
    nombre VARCHAR(50),
    telefono VARCHAR(20)
);

CREATE TABLE Empleado (
    id_empleado INT PRIMARY KEY,
    nombre VARCHAR(50),
    salario DECIMAL(10,2),
    correo VARCHAR(50)
);

CREATE TABLE Producto (
    id_producto INT PRIMARY KEY,
    nombre VARCHAR(50),
    precio DECIMAL(8,2),
    stock INT
);

CREATE TABLE Proveedor (
    id_proveedor INT PRIMARY KEY,
    nombre VARCHAR(50),
    ciudad VARCHAR(30)
);

CREATE TABLE Venta (
    id_venta INT PRIMARY KEY,
    id_cliente INT,
    id_empleado INT,
    total DECIMAL(10,2),
    metodo_pago VARCHAR(20),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado)
);

CREATE TABLE Venta_Producto (
    id_venta INT,
    id_producto INT,
    cantidad INT,
    PRIMARY KEY (id_venta, id_producto),
    FOREIGN KEY (id_venta) REFERENCES Venta(id_venta),
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

CREATE TABLE Empleado_Proveedor (
    id_empleado INT,
    id_proveedor INT,
    turno VARCHAR(20),
    PRIMARY KEY (id_empleado, id_proveedor),
    FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado),
    FOREIGN KEY (id_proveedor) REFERENCES Proveedor(id_proveedor)
);

-- 3. INSERT
INSERT INTO Cliente VALUES 
(1, 'Ana', '3001234567'), (2, 'Luis', '3012345678'), 
(3, 'Marta', '3023456789'), (4, 'Pedro', '3034567890'), 
(5, 'Laura', '3045678901');

INSERT INTO Empleado VALUES 
(1, 'Carlos', 1800, 'carlos@mail.com'), (2, 'Sandra', 1900, 'sandra@mail.com'), 
(3, 'Diego', 1750, 'diego@mail.com'), (4, 'Sofia', 1850, 'sofia@mail.com'), 
(5, 'Jorge', 1950, 'jorge@mail.com');

INSERT INTO Producto VALUES 
(1, 'Ron', 35.00, 50), (2, 'Whisky', 80.00, 20), 
(3, 'Vodka', 60.00, 30), (4, 'Cerveza', 5.00, 100), 
(5, 'Tequila', 70.00, 25);

INSERT INTO Proveedor VALUES 
(1, 'Distribuidora A', 'Bogotá'), (2, 'LicorZona', 'Medellín'), 
(3, 'SaborAndes', 'Cali'), (4, 'BebidasVIP', 'Barranquilla'), 
(5, 'LicoresDelValle', 'Pereira');

INSERT INTO Venta VALUES 
(1, 1, 1, 100.00, 'Efectivo'), (2, 2, 2, 150.00, 'Tarjeta'), 
(3, 3, 3, 120.00, 'Transferencia'), (4, 4, 4, 80.00, 'Efectivo'), 
(5, 5, 5, 60.00, 'Tarjeta');

INSERT INTO Venta_Producto VALUES 
(1, 1, 2), (2, 2, 1), (3, 3, 1), (4, 4, 4), (5, 5, 1);

INSERT INTO Empleado_Proveedor VALUES 
(1, 1, 'Mañana'), (2, 2, 'Tarde'), (3, 3, 'Mañana'), (4, 4, 'Noche'), (5, 5, 'Tarde');

-- 4. UPDATE
UPDATE Cliente SET nombre = 'Ana María' WHERE id_cliente = 1;
UPDATE Empleado SET salario = 2000 WHERE id_empleado = 2;
UPDATE Producto SET stock = 60 WHERE id_producto = 3;
UPDATE Proveedor SET ciudad = 'Cartagena' WHERE id_proveedor = 4;
UPDATE Venta SET total = 110.00 WHERE id_venta = 1;

-- 5. DELETE (respetando integridad referencial)
DELETE FROM Venta_Producto WHERE id_venta = 5;
DELETE FROM Empleado_Proveedor WHERE id_empleado = 5;
DELETE FROM Venta WHERE id_venta = 5;
DELETE FROM Cliente WHERE id_cliente = 5;
DELETE FROM Producto WHERE id_producto = 5;

-- 6. SELECT JOIN
SELECT c.nombre, v.total 
FROM Cliente c JOIN Venta v ON c.id_cliente = v.id_cliente;

SELECT e.nombre, p.nombre 
FROM Empleado e 
JOIN Empleado_Proveedor ep ON e.id_empleado = ep.id_empleado
JOIN Proveedor p ON ep.id_proveedor = p.id_proveedor;

SELECT v.id_venta, pr.nombre, vp.cantidad 
FROM Venta v 
JOIN Venta_Producto vp ON v.id_venta = vp.id_venta 
JOIN Producto pr ON vp.id_producto = pr.id_producto;

SELECT v.id_venta, e.nombre 
FROM Venta v JOIN Empleado e ON v.id_empleado = e.id_empleado;

SELECT p.nombre, ep.turno 
FROM Proveedor p JOIN Empleado_Proveedor ep ON p.id_proveedor = ep.id_proveedor;

-- 7. SUBCONSULTAS
SELECT nombre FROM Cliente 
WHERE id_cliente IN (SELECT id_cliente FROM Venta WHERE total > 100);

SELECT nombre FROM Producto 
WHERE precio = (SELECT MAX(precio) FROM Producto);

SELECT nombre FROM Empleado 
WHERE salario > (SELECT AVG(salario) FROM Empleado);

SELECT nombre FROM Proveedor 
WHERE id_proveedor IN (SELECT id_proveedor FROM Empleado_Proveedor);

SELECT nombre FROM Producto 
WHERE precio < (SELECT AVG(precio) FROM Producto);

-- 8. ALTER (agregar columnas)
ALTER TABLE Cliente ADD direccion VARCHAR(100);
ALTER TABLE Empleado ADD edad INT;
ALTER TABLE Producto ADD marca VARCHAR(30);
ALTER TABLE Venta ADD fecha DATE;
ALTER TABLE Proveedor ADD contacto VARCHAR(50);

-- 9. FUNCIONES AGREGADAS

-- MAX: Precio más alto
SELECT MAX(precio) AS mayor_precio FROM Producto;

-- MIN: Precio más bajo
SELECT MIN(precio) AS menor_precio FROM Producto;

-- SUM: Total de ventas
SELECT SUM(total) AS total_ventas FROM Venta;

-- AVG: Promedio salario
SELECT AVG(salario) AS promedio_salario FROM Empleado;

-- COUNT: Empleados totales
SELECT COUNT(*) AS total_empleados FROM Empleado;

-- CONCAT: Info de cliente
SELECT CONCAT(nombre, ' - ', telefono) AS info_cliente FROM Cliente;

-- UPPER: Nombre en mayúsculas
SELECT UPPER(nombre) AS nombre_mayus FROM Empleado;

-- LOWER: Nombre proveedor minúsculas
SELECT LOWER(nombre) AS nombre_min FROM Proveedor;

-- ROUND: Precio redondeado
SELECT ROUND(AVG(precio), 0) FROM Producto;

-- LEFT: Iniciales de producto
SELECT LEFT(nombre, 3) FROM Producto;

-- 10. PROCEDIMIENTO ALMACENADO
CREATE PROCEDURE VentasPorEmpleado
@ID INT
AS
BEGIN
    SELECT id_venta, total, metodo_pago
    FROM Venta
    WHERE id_empleado = @ID;
END;

-- 11. TRUNCATE
TRUNCATE TABLE Venta_Producto;
TRUNCATE TABLE Empleado_Proveedor;
TRUNCATE TABLE Venta;
TRUNCATE TABLE Producto;
TRUNCATE TABLE Cliente;

-- 12. DROP TABLE
DROP TABLE IF EXISTS Venta_Producto;
DROP TABLE IF EXISTS Empleado_Proveedor;
DROP TABLE IF EXISTS Venta;
DROP TABLE IF EXISTS Producto;
DROP TABLE IF EXISTS Proveedor;
DROP TABLE IF EXISTS Cliente;
DROP TABLE IF EXISTS Empleado;

-- 13. DROP DATABASE
DROP DATABASE IF EXISTS Licorera;
