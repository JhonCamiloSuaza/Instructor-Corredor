-- 1. CREAR BASE DE DATOS
CREATE DATABASE ParqueDiversiones;
USE ParqueDiversiones;

-- 2. CREAR TABLAS

-- Tabla de visitantes del parque
CREATE TABLE Visitante (
    id_visitante INT PRIMARY KEY,
    nombre VARCHAR(50),
    correo VARCHAR(50),
    edad INT
);

-- Tabla de empleados del parque
CREATE TABLE Empleado (
    id_empleado INT PRIMARY KEY,
    nombre VARCHAR(50),
    cargo VARCHAR(30),
    salario DECIMAL(10,2)
);

-- Tabla de atracciones
CREATE TABLE Atraccion (
    id_atraccion INT PRIMARY KEY,
    nombre VARCHAR(50),
    tipo VARCHAR(30),
    capacidad INT
);

-- Tabla de tiendas dentro del parque
CREATE TABLE Tienda (
    id_tienda INT PRIMARY KEY,
    nombre VARCHAR(50),
    tipo VARCHAR(30),
    precio DECIMAL(8,2)
);

-- Tabla de boletos vendidos
CREATE TABLE Boleto (
    id_boleto INT PRIMARY KEY,
    id_visitante INT,
    fecha DATE,
    precio DECIMAL(8,2),
    FOREIGN KEY (id_visitante) REFERENCES Visitante(id_visitante)
);

-- Tabla pivote: visitante usa atracción
CREATE TABLE Visitante_Atraccion (
    id_visitante INT,
    id_atraccion INT,
    PRIMARY KEY (id_visitante, id_atraccion),
    FOREIGN KEY (id_visitante) REFERENCES Visitante(id_visitante),
    FOREIGN KEY (id_atraccion) REFERENCES Atraccion(id_atraccion)
);

-- Tabla pivote: empleado asignado a tienda
CREATE TABLE Empleado_Tienda (
    id_empleado INT,
    id_tienda INT,
    turno VARCHAR(20),
    PRIMARY KEY (id_empleado, id_tienda),
    FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado),
    FOREIGN KEY (id_tienda) REFERENCES Tienda(id_tienda)
);

-- 3. INSERT
INSERT INTO Visitante VALUES
(1, 'Carlos', 'carlos@mail.com', 25),
(2, 'Ana', 'ana@mail.com', 30),
(3, 'Luis', 'luis@mail.com', 22),
(4, 'Marta', 'marta@mail.com', 28),
(5, 'Pedro', 'pedro@mail.com', 35);

INSERT INTO Empleado VALUES
(1, 'Laura', 'Taquilla', 1500),
(2, 'Diego', 'Seguridad', 1600),
(3, 'Juan', 'Guía', 1400),
(4, 'Elena', 'Limpieza', 1300),
(5, 'Pedro', 'Tienda', 1550);

INSERT INTO Atraccion VALUES
(1, 'Montaña Rusa', 'Adrenalina', 20),
(2, 'Carrusel', 'Familiar', 15),
(3, 'Rueda', 'Familiar', 25),
(4, 'Casa del Terror', 'Terror', 10),
(5, 'Splash', 'Agua', 18);

INSERT INTO Tienda VALUES
(1, 'HeladosYum', 'Comida', 3.50),
(2, 'RecuerdosMax', 'Souvenir', 10.00),
(3, 'Refrescos', 'Bebidas', 2.00),
(4, 'SnacksFast', 'Comida', 5.50),
(5, 'FotosMagia', 'Souvenir', 7.00);

INSERT INTO Boleto VALUES
(1, 1, '2024-06-01', 20.00),
(2, 2, '2024-06-01', 25.00),
(3, 3, '2024-06-02', 30.00),
(4, 4, '2024-06-02', 22.50),
(5, 5, '2024-06-03', 35.00);

INSERT INTO Visitante_Atraccion VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5);

INSERT INTO Empleado_Tienda VALUES
(1, 1, 'Mañana'), (2, 2, 'Tarde'), (3, 3, 'Mañana'), (4, 4, 'Noche'), (5, 5, 'Tarde');

-- 4. UPDATE
UPDATE Visitante SET nombre = 'Carlos R.' WHERE id_visitante = 1;
UPDATE Empleado SET salario = 1650 WHERE id_empleado = 2;
UPDATE Atraccion SET capacidad = 22 WHERE id_atraccion = 1;
UPDATE Tienda SET precio = 3.75 WHERE id_tienda = 1;
UPDATE Boleto SET precio = 21.50 WHERE id_boleto = 1;

-- 5. DELETE
DELETE FROM Visitante_Atraccion WHERE id_visitante = 2;
DELETE FROM Empleado_Tienda WHERE id_empleado = 2;
DELETE FROM Boleto WHERE id_boleto = 2;
DELETE FROM Visitante WHERE id_visitante = 2;
DELETE FROM Tienda WHERE id_tienda = 2;

-- 6. SELECT JOIN
SELECT v.nombre, a.nombre FROM Visitante v
JOIN Visitante_Atraccion va ON v.id_visitante = va.id_visitante
JOIN Atraccion a ON va.id_atraccion = a.id_atraccion;

SELECT e.nombre, t.nombre FROM Empleado e
JOIN Empleado_Tienda et ON e.id_empleado = et.id_empleado
JOIN Tienda t ON et.id_tienda = t.id_tienda;

SELECT b.id_boleto, v.nombre, b.precio FROM Boleto b
JOIN Visitante v ON b.id_visitante = v.id_visitante;

SELECT t.nombre, et.turno FROM Tienda t
JOIN Empleado_Tienda et ON t.id_tienda = et.id_tienda;

SELECT a.nombre, a.capacidad FROM Atraccion a
JOIN Visitante_Atraccion va ON a.id_atraccion = va.id_atraccion;

-- 7. SUBCONSULTAS
SELECT nombre FROM Visitante WHERE edad > (SELECT AVG(edad) FROM Visitante);
SELECT nombre FROM Atraccion WHERE id_atraccion IN (SELECT id_atraccion FROM Visitante_Atraccion);
SELECT nombre FROM Tienda WHERE precio = (SELECT MAX(precio) FROM Tienda);
SELECT nombre FROM Empleado WHERE salario > (SELECT AVG(salario) FROM Empleado);
SELECT nombre FROM Tienda WHERE precio < (SELECT AVG(precio) FROM Tienda);

-- 8. ALTER
ALTER TABLE Visitante ADD telefono VARCHAR(20);
ALTER TABLE Empleado ADD correo VARCHAR(50);
ALTER TABLE Atraccion ADD edad_minima INT;
ALTER TABLE Tienda ADD stock INT;
ALTER TABLE Empleado ADD estado VARCHAR(10);

-- 9. FUNCIONES AGREGADAS

-- MAX: Precio más alto
SELECT MAX(precio) AS mayor_precio FROM Boleto;

-- MIN: Precio más bajo
SELECT MIN(precio) AS menor_precio FROM Boleto;

-- SUM: Total ingresos por boletos
SELECT SUM(precio) AS total_ingresos FROM Boleto;

-- AVG: Edad promedio de visitantes
SELECT AVG(edad) AS promedio_edad FROM Visitante;

-- COUNT: Total empleados
SELECT COUNT(*) AS total_empleados FROM Empleado;

-- CONCAT: Nombre completo de visitante
SELECT CONCAT(nombre, ' - ', edad) AS info_visitante FROM Visitante;

-- UPPER: Mayúsculas en atracciones
SELECT UPPER(nombre) FROM Atraccion;

-- LOWER: Minúsculas en tiendas
SELECT LOWER(nombre) FROM Tienda;

-- ROUND: Redondear promedio de boletos
SELECT ROUND(AVG(precio), 0) FROM Boleto;

-- LEFT: Iniciales de empleados
SELECT LEFT(nombre, 3) FROM Empleado;

-- 10. PROCEDIMIENTO ALMACENADO
CREATE PROCEDURE TicketsPorVisitante
@ID INT
AS
BEGIN
    SELECT b.id_boleto, b.fecha, b.precio
    FROM Boleto b
    WHERE b.id_visitante = @ID;
END;

-- 11. TRUNCATE
TRUNCATE TABLE Visitante_Atraccion;
TRUNCATE TABLE Empleado_Tienda;
TRUNCATE TABLE Boleto;
TRUNCATE TABLE Visitante;
TRUNCATE TABLE Empleado;

-- 12. DROP TABLE
DROP TABLE IF EXISTS Visitante_Atraccion;
DROP TABLE IF EXISTS Empleado_Tienda;
DROP TABLE IF EXISTS Boleto;
DROP TABLE IF EXISTS Visitante;
DROP TABLE IF EXISTS Empleado;
DROP TABLE IF EXISTS Atraccion;
DROP TABLE IF EXISTS Tienda;

-- 13. DROP DATABASE
DROP DATABASE IF EXISTS ParqueDiversiones;
