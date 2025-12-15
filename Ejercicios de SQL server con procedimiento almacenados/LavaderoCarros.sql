-- 1. Crear la base de datos
CREATE DATABASE LavaderoCarros;
USE LavaderoCarros;

-- 2. Crear tablas principales

-- Tabla Cliente
CREATE TABLE Cliente (
    id_cliente INT PRIMARY KEY,
    nombre VARCHAR(50),
    telefono VARCHAR(20)
);

-- Tabla Empleado
CREATE TABLE Empleado (
    id_empleado INT PRIMARY KEY,
    nombre VARCHAR(50),
    cargo VARCHAR(30)
);

-- Tabla Vehiculo
CREATE TABLE Vehiculo (
    id_vehiculo INT PRIMARY KEY,
    placa VARCHAR(10),
    id_cliente INT,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

-- Tabla Servicio
CREATE TABLE Servicio (
    id_servicio INT PRIMARY KEY,
    nombre_servicio VARCHAR(50),
    precio DECIMAL(8,2)
);

-- Tabla Lavado
CREATE TABLE Lavado (
    id_lavado INT PRIMARY KEY,
    fecha DATE,
    id_vehiculo INT,
    FOREIGN KEY (id_vehiculo) REFERENCES Vehiculo(id_vehiculo)
);

-- Tabla pivote Vehiculo_Servicio
CREATE TABLE Vehiculo_Servicio (
    id_vehiculo INT,
    id_servicio INT,
    PRIMARY KEY (id_vehiculo, id_servicio),
    FOREIGN KEY (id_vehiculo) REFERENCES Vehiculo(id_vehiculo),
    FOREIGN KEY (id_servicio) REFERENCES Servicio(id_servicio)
);

-- Tabla pivote Empleado_Servicio
CREATE TABLE Empleado_Servicio (
    id_empleado INT,
    id_servicio INT,
    PRIMARY KEY (id_empleado, id_servicio),
    FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado),
    FOREIGN KEY (id_servicio) REFERENCES Servicio(id_servicio)
);

-- 3. Insertar datos
INSERT INTO Cliente VALUES 
(1, 'Carlos', '3011111111'),
(2, 'Ana', '3022222222'),
(3, 'Luis', '3033333333'),
(4, 'Marta', '3044444444'),
(5, 'Pedro', '3055555555');

INSERT INTO Empleado VALUES
(1, 'Laura', 'Lavador'),
(2, 'Andrés', 'Lavador'),
(3, 'Luisa', 'Cajera'),
(4, 'Cata', 'Supervisor'),
(5, 'Mario', 'Lavador');

INSERT INTO Vehiculo VALUES
(1, 'ABC123', 1),
(2, 'XYZ789', 2),
(3, 'DEF456', 3),
(4, 'JKL321', 4),
(5, 'QWE987', 5);

INSERT INTO Servicio VALUES
(1, 'Lavado básico', 10000),
(2, 'Lavado completo', 20000),
(3, 'Polichado', 30000),
(4, 'Aspirado', 5000),
(5, 'Desinfección', 15000);

INSERT INTO Lavado VALUES
(1, '2024-06-01', 1),
(2, '2024-06-02', 2),
(3, '2024-06-03', 3),
(4, '2024-06-04', 4),
(5, '2024-06-05', 5);

INSERT INTO Vehiculo_Servicio VALUES
(1, 1), (1, 2),
(2, 3), (3, 4),
(4, 5);

INSERT INTO Empleado_Servicio VALUES
(1, 1), (1, 2),
(2, 3), (3, 4),
(4, 5);

-- 4. UPDATE
UPDATE Cliente SET telefono = '3110000000' WHERE id_cliente = 1;
UPDATE Cliente SET telefono = '3111111111' WHERE id_cliente = 2;
UPDATE Empleado SET cargo = 'Encargado' WHERE id_empleado = 3;
UPDATE Servicio SET precio = 12000 WHERE id_servicio = 1;
UPDATE Lavado SET fecha = '2024-06-10' WHERE id_lavado = 1;

-- 5. DELETE
DELETE FROM Vehiculo_Servicio WHERE id_vehiculo = 1;
DELETE FROM Empleado_Servicio WHERE id_empleado = 1;
DELETE FROM Lavado WHERE id_lavado = 5;
DELETE FROM Vehiculo WHERE id_vehiculo = 5;
DELETE FROM Cliente WHERE id_cliente = 5;

-- 6. SELECT JOIN
SELECT c.nombre, v.placa FROM Cliente c JOIN Vehiculo v ON c.id_cliente = v.id_cliente;
SELECT v.placa, l.fecha FROM Vehiculo v JOIN Lavado l ON v.id_vehiculo = l.id_vehiculo;
SELECT es.id_empleado, s.nombre_servicio FROM Empleado_Servicio es JOIN Servicio s ON es.id_servicio = s.id_servicio;
SELECT e.nombre, es.id_servicio FROM Empleado e JOIN Empleado_Servicio es ON e.id_empleado = es.id_empleado;
SELECT v.placa, vs.id_servicio FROM Vehiculo v JOIN Vehiculo_Servicio vs ON v.id_vehiculo = vs.id_vehiculo;

-- 7. SUBCONSULTAS
SELECT nombre FROM Cliente WHERE id_cliente IN (SELECT id_cliente FROM Vehiculo WHERE id_vehiculo = 1);
SELECT nombre_servicio FROM Servicio WHERE precio > (SELECT AVG(precio) FROM Servicio);
SELECT nombre FROM Empleado WHERE id_empleado IN (SELECT id_empleado FROM Empleado_Servicio WHERE id_servicio = 1);
SELECT placa FROM Vehiculo WHERE id_vehiculo NOT IN (SELECT id_vehiculo FROM Lavado);
SELECT fecha FROM Lavado WHERE id_vehiculo = (SELECT id_vehiculo FROM Vehiculo WHERE placa = 'XYZ789');

-- 8. ALTER
ALTER TABLE Cliente ADD direccion VARCHAR(100);
ALTER TABLE Empleado ADD correo VARCHAR(100);
ALTER TABLE Servicio ADD descripcion VARCHAR(100);
ALTER TABLE Lavado ADD observacion VARCHAR(100);
ALTER TABLE Vehiculo ADD modelo VARCHAR(20);

-- 9. FUNCIONES AGREGADAS
-- MAX: servicio más caro
SELECT MAX(precio) AS precio_maximo FROM Servicio;
-- MIN: servicio más barato
SELECT MIN(precio) AS precio_minimo FROM Servicio;
-- SUM: total recaudado
SELECT SUM(precio) AS total_ingresos FROM Servicio;
-- COUNT: total empleados
SELECT COUNT(*) AS total_empleados FROM Empleado;
-- CONCAT: nombre completo
SELECT CONCAT(nombre, ' (', cargo, ')') AS info FROM Empleado;
-- AVG: promedio de precios
SELECT AVG(precio) AS promedio_precios FROM Servicio;
-- UPPER: nombre del servicio en mayúsculas
SELECT UPPER(nombre_servicio) FROM Servicio;
-- LOWER: nombre del cliente en minúsculas
SELECT LOWER(nombre) FROM Cliente;
-- ROUND: redondear precio promedio
SELECT ROUND(AVG(precio), 0) FROM Servicio;
-- LEFT: primeras letras del nombre del empleado
SELECT LEFT(nombre, 3) FROM Empleado;

-- 10. PROCEDIMIENTO ALMACENADO
CREATE PROCEDURE EstadisticasPorEmpleado
@Cargo VARCHAR(30)
AS
BEGIN
    IF OBJECT_ID('tempdb..#empleados_estadisticas') IS NOT NULL
        DROP TABLE #empleados_estadisticas;

    CREATE TABLE #empleados_estadisticas (
        cargo VARCHAR(30),
        total INT
    );

    INSERT INTO #empleados_estadisticas
    SELECT cargo, COUNT(*) FROM Empleado WHERE cargo = @Cargo GROUP BY cargo;

    SELECT * FROM #empleados_estadisticas;
END;

-- 11. TRUNCATE
TRUNCATE TABLE Vehiculo_Servicio;
TRUNCATE TABLE Empleado_Servicio;
TRUNCATE TABLE Lavado;
TRUNCATE TABLE Vehiculo;
TRUNCATE TABLE Servicio;

-- 12. DROP TABLE
DROP TABLE Vehiculo_Servicio;
DROP TABLE Empleado_Servicio;
DROP TABLE Lavado;
DROP TABLE Vehiculo;
DROP TABLE Servicio;

-- 13. DROP DATABASE
DROP DATABASE LavaderoCarros;

-- FUNCIONES AGREGADAS RESUMEN:
-- MAX: 1 vez
-- MIN: 1 vez
-- SUM: 1 vez
-- COUNT: 1 vez
-- CONCAT: 1 vez
-- AVG: 1 vez
-- UPPER: 1 vez
-- LOWER: 1 vez
-- ROUND: 1 vez
-- LEFT: 1 vez