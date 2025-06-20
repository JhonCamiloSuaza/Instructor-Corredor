-- 1. CREAR BASE DE DATOS
CREATE DATABASE AlmacenRopa;
USE AlmacenRopa;

-- 2. CREAR TABLAS

-- Tabla de clientes que compran productos
CREATE TABLE Cliente (
    id_cliente INT PRIMARY KEY,
    nombre VARCHAR(50),
    correo VARCHAR(50)
);

-- Tabla de empleados que atienden ventas y gestionan proveedores
CREATE TABLE Empleado (
    id_empleado INT PRIMARY KEY,
    nombre VARCHAR(50),
    cargo VARCHAR(30),
    salario DECIMAL(10,2)
);

-- Tabla de productos disponibles en el almacén
CREATE TABLE Producto (
    id_producto INT PRIMARY KEY,
    nombre VARCHAR(50),
    precio DECIMAL(8,2)
);

-- Tabla de ventas realizadas por clientes
CREATE TABLE Venta (
    id_venta INT PRIMARY KEY,
    id_cliente INT,
    id_empleado INT,
    fecha DATE,
    total DECIMAL(10,2),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado)
);

-- Tabla de proveedores de ropa
CREATE TABLE Proveedor (
    id_proveedor INT PRIMARY KEY,
    nombre VARCHAR(50),
    contacto VARCHAR(50)
);

-- Tabla pivote: productos vendidos en cada venta
CREATE TABLE Venta_Producto (
    id_venta INT,
    id_producto INT,
    cantidad INT,
    PRIMARY KEY (id_venta, id_producto),
    FOREIGN KEY (id_venta) REFERENCES Venta(id_venta),
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

-- Tabla pivote: empleados asignados a proveedores
CREATE TABLE Empleado_Proveedor (
    id_empleado INT,
    id_proveedor INT,
    turno VARCHAR(20),
    PRIMARY KEY (id_empleado, id_proveedor),
    FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado),
    FOREIGN KEY (id_proveedor) REFERENCES Proveedor(id_proveedor)
);

-- 3. INSERT: Agregar registros de ejemplo
INSERT INTO Cliente VALUES
(1, 'Ana', 'ana@mail.com'),
(2, 'Luis', 'luis@mail.com'),
(3, 'Marta', 'marta@mail.com'),
(4, 'Pedro', 'pedro@mail.com'),
(5, 'Sofia', 'sofia@mail.com');

INSERT INTO Empleado VALUES
(1, 'Carlos', 'Cajero', 1500),
(2, 'Laura', 'Bodega', 1600),
(3, 'Luis', 'Vendedor', 1700),
(4, 'Sandra', 'Gerente', 2000),
(5, 'Nico', 'Reparto', 1400);

INSERT INTO Producto VALUES
(1, 'Camisa', 20.00),
(2, 'Jeans', 35.50),
(3, 'Chaqueta', 60.00),
(4, 'Zapatos', 45.25),
(5, 'Gorra', 15.00);

INSERT INTO Proveedor VALUES
(1, 'TextilesA', 'contacto@a.com'),
(2, 'ModaExpress', 'contacto@moda.com'),
(3, 'FashionCol', 'ventas@fc.com'),
(4, 'RopaYa', 'info@ropaya.com'),
(5, 'DistribuRopa', 'ventas@disropa.com');

INSERT INTO Venta VALUES
(1, 1, 1, '2024-06-01', 100.00),
(2, 2, 2, '2024-06-02', 150.00),
(3, 3, 3, '2024-06-03', 200.00),
(4, 4, 4, '2024-06-04', 250.00),
(5, 5, 5, '2024-06-05', 300.00);

INSERT INTO Venta_Producto VALUES
(1, 1, 2), (1, 2, 1), (2, 3, 1), (3, 4, 2), (4, 5, 3);

INSERT INTO Empleado_Proveedor VALUES
(1, 1, 'Mañana'), (2, 2, 'Tarde'), (3, 3, 'Mañana'), (4, 4, 'Noche'), (5, 5, 'Tarde');

-- 4. UPDATE: Modificar información
UPDATE Cliente SET nombre = 'Ana María' WHERE id_cliente = 1;
UPDATE Empleado SET salario = 1800 WHERE id_empleado = 2;
UPDATE Producto SET precio = 38.00 WHERE id_producto = 2;
UPDATE Proveedor SET nombre = 'TextilesAliados' WHERE id_proveedor = 1;
UPDATE Venta SET total = 120.00 WHERE id_venta = 1;

-- 5. DELETE: Eliminar registros con control de llaves foráneas
DELETE FROM Venta_Producto WHERE id_venta = 1;
DELETE FROM Empleado_Proveedor WHERE id_empleado = 2;
DELETE FROM Venta WHERE id_venta = 2;
DELETE FROM Cliente WHERE id_cliente = 2;
DELETE FROM Producto WHERE id_producto = 2;

-- 6. SELECT JOIN: Consultas que cruzan varias tablas
SELECT c.nombre, v.total FROM Cliente c JOIN Venta v ON c.id_cliente = v.id_cliente;
SELECT e.nombre, p.nombre FROM Empleado e 
JOIN Empleado_Proveedor ep ON e.id_empleado = ep.id_empleado 
JOIN Proveedor p ON ep.id_proveedor = p.id_proveedor;
SELECT vp.id_venta, pr.nombre, vp.cantidad FROM Venta_Producto vp 
JOIN Producto pr ON vp.id_producto = pr.id_producto;
SELECT v.id_venta, e.nombre FROM Venta v JOIN Empleado e ON v.id_empleado = e.id_empleado;
SELECT pr.nombre, ep.turno FROM Proveedor pr 
JOIN Empleado_Proveedor ep ON pr.id_proveedor = ep.id_proveedor;

-- 7. SUBCONSULTAS: Consultas anidadas
SELECT nombre FROM Cliente WHERE id_cliente IN (SELECT id_cliente FROM Venta WHERE total > 150);
SELECT nombre FROM Producto WHERE precio = (SELECT MAX(precio) FROM Producto);
SELECT nombre FROM Empleado WHERE salario > (SELECT AVG(salario) FROM Empleado);
SELECT nombre FROM Proveedor WHERE id_proveedor IN (SELECT id_proveedor FROM Empleado_Proveedor);
SELECT nombre FROM Producto WHERE precio < (SELECT AVG(precio) FROM Producto);

-- 8. ALTER: Agregar columnas nuevas
ALTER TABLE Cliente ADD telefono VARCHAR(20);
ALTER TABLE Empleado ADD extension INT;
ALTER TABLE Producto ADD stock INT;
ALTER TABLE Venta ADD metodo_pago VARCHAR(20);
ALTER TABLE Proveedor ADD ciudad VARCHAR(50);

-- 9. FUNCIONES AGREGADAS

-- MAX: mayor precio entre productos
SELECT MAX(precio) AS max_precio FROM Producto;

-- MIN: menor precio
SELECT MIN(precio) AS min_precio FROM Producto;

-- SUM: suma total de ventas
SELECT SUM(total) AS suma_total FROM Venta;

-- AVG: promedio de salarios
SELECT AVG(salario) AS salario_prom FROM Empleado;

-- COUNT: número total de clientes
SELECT COUNT(*) AS total_clientes FROM Cliente;

-- CONCAT: unir nombre y teléfono
SELECT CONCAT(nombre, ' - ', telefono) AS cliente_info FROM Cliente;

-- UPPER: pasar nombre a mayúsculas
SELECT UPPER(nombre) FROM Empleado;

-- LOWER: pasar nombre a minúsculas
SELECT LOWER(nombre) FROM Proveedor;

-- ROUND: redondear precio promedio
SELECT ROUND(AVG(precio), 0) FROM Producto;

-- LEFT: primeras letras de nombres
SELECT LEFT(nombre, 3) FROM Producto;

-- 10. PROCEDIMIENTO ALMACENADO
CREATE PROCEDURE VentasPorEmpleado
@ID INT
AS
BEGIN
    SELECT v.id_venta, v.fecha, v.total
    FROM Venta v
    WHERE v.id_empleado = @ID;
END;

-- 11. TRUNCATE: Vaciar tablas manteniendo su estructura
TRUNCATE TABLE Venta_Producto;
TRUNCATE TABLE Empleado_Proveedor;
TRUNCATE TABLE Venta;
TRUNCATE TABLE Producto;
TRUNCATE TABLE Cliente;

-- 12. DROP TABLE: Eliminar estructura de tablas
DROP TABLE IF EXISTS Venta_Producto;
DROP TABLE IF EXISTS Empleado_Proveedor;
DROP TABLE IF EXISTS Venta;
DROP TABLE IF EXISTS Producto;
DROP TABLE IF EXISTS Cliente;

-- 13. DROP DATABASE: Eliminar la base de datos completa
DROP DATABASE IF EXISTS AlmacenRopa;
