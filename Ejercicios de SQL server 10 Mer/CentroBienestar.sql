-- 1. CREAR BASE DE DATOS
CREATE DATABASE CentroBienestar;
USE CentroBienestar;

-- 2. CREAR TABLAS
CREATE TABLE Usuario (
    id_usuario INT PRIMARY KEY,
    nombre VARCHAR(50),
    correo VARCHAR(50)
);

CREATE TABLE Empleado (
    id_empleado INT PRIMARY KEY,
    nombre VARCHAR(50),
    especialidad VARCHAR(30),
    salario DECIMAL(10,2)
);

CREATE TABLE Servicio (
    id_servicio INT PRIMARY KEY,
    nombre VARCHAR(50),
    precio DECIMAL(8,2)
);

CREATE TABLE Sesion (
    id_sesion INT PRIMARY KEY,
    id_usuario INT,
    id_empleado INT,
    fecha DATE,
    total DECIMAL(10,2),
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
    FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado)
);

CREATE TABLE Aliado (
    id_aliado INT PRIMARY KEY,
    nombre VARCHAR(50),
    contacto VARCHAR(50)
);

CREATE TABLE Sesion_Servicio (
    id_sesion INT,
    id_servicio INT,
    cantidad INT,
    PRIMARY KEY (id_sesion, id_servicio),
    FOREIGN KEY (id_sesion) REFERENCES Sesion(id_sesion),
    FOREIGN KEY (id_servicio) REFERENCES Servicio(id_servicio)
);

CREATE TABLE Empleado_Aliado (
    id_empleado INT,
    id_aliado INT,
    horario VARCHAR(20),
    PRIMARY KEY (id_empleado, id_aliado),
    FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado),
    FOREIGN KEY (id_aliado) REFERENCES Aliado(id_aliado)
);

-- 3. INSERT
INSERT INTO Usuario VALUES
(1, 'Juan', 'juan@mail.com'),
(2, 'Carla', 'carla@mail.com'),
(3, 'Andrés', 'andres@mail.com'),
(4, 'Luisa', 'luisa@mail.com'),
(5, 'Mateo', 'mateo@mail.com');

INSERT INTO Empleado VALUES
(1, 'Sofia', 'Masajista', 1800),
(2, 'Mario', 'Entrenador', 2000),
(3, 'Diana', 'Nutricionista', 2200),
(4, 'Carlos', 'Yoga', 1900),
(5, 'Natalia', 'Fisioterapeuta', 2100);

INSERT INTO Servicio VALUES
(1, 'Masaje relajante', 50.00),
(2, 'Sesión de yoga', 30.00),
(3, 'Consulta nutricional', 45.00),
(4, 'Terapia física', 60.00),
(5, 'Spa completo', 90.00);

INSERT INTO Aliado VALUES
(1, 'TerapiasZen', 'contacto@zen.com'),
(2, 'NutriPro', 'info@nutri.com'),
(3, 'FitZone', 'ventas@fit.com'),
(4, 'RelaxSpa', 'contact@relax.com'),
(5, 'BodyCare', 'servicio@bodycare.com');

INSERT INTO Sesion VALUES
(1, 1, 1, '2024-07-01', 120.00),
(2, 2, 2, '2024-07-02', 150.00),
(3, 3, 3, '2024-07-03', 200.00),
(4, 4, 4, '2024-07-04', 250.00),
(5, 5, 5, '2024-07-05', 300.00);

INSERT INTO Sesion_Servicio VALUES
(1, 1, 2), (1, 2, 1), (2, 3, 1), (3, 4, 2), (4, 5, 3);

INSERT INTO Empleado_Aliado VALUES
(1, 1, 'Mañana'), (2, 2, 'Tarde'), (3, 3, 'Mañana'), (4, 4, 'Noche'), (5, 5, 'Tarde');

-- 4. UPDATE
UPDATE Usuario SET nombre = 'Juan Pablo' WHERE id_usuario = 1;
UPDATE Empleado SET salario = 2100 WHERE id_empleado = 2;
UPDATE Servicio SET precio = 35.00 WHERE id_servicio = 2;
UPDATE Aliado SET nombre = 'Terapias Vitales' WHERE id_aliado = 1;
UPDATE Sesion SET total = 130.00 WHERE id_sesion = 1;

-- 5. DELETE
DELETE FROM Sesion_Servicio WHERE id_sesion = 1 AND id_servicio = 1;
DELETE FROM Empleado_Aliado WHERE id_empleado = 2 AND id_aliado = 2;
DELETE FROM Sesion WHERE id_sesion = 1;
DELETE FROM Usuario WHERE id_usuario = 1;
DELETE FROM Servicio WHERE id_servicio = 1;

-- 6. SELECT JOIN
SELECT u.nombre, s.total FROM Usuario u JOIN Sesion s ON u.id_usuario = s.id_usuario;
SELECT e.nombre, a.nombre FROM Empleado e 
JOIN Empleado_Aliado ea ON e.id_empleado = ea.id_empleado 
JOIN Aliado a ON ea.id_aliado = a.id_aliado;
SELECT ss.id_sesion, se.nombre, ss.cantidad FROM Sesion_Servicio ss 
JOIN Servicio se ON ss.id_servicio = se.id_servicio;
SELECT s.id_sesion, e.nombre FROM Sesion s JOIN Empleado e ON s.id_empleado = e.id_empleado;
SELECT a.nombre, ea.horario FROM Aliado a 
JOIN Empleado_Aliado ea ON a.id_aliado = ea.id_aliado;

-- 7. SUBCONSULTAS
SELECT nombre FROM Usuario WHERE id_usuario IN (SELECT id_usuario FROM Sesion WHERE total > 150);
SELECT nombre FROM Servicio WHERE precio = (SELECT MAX(precio) FROM Servicio);
SELECT nombre FROM Empleado WHERE salario > (SELECT AVG(salario) FROM Empleado);
SELECT nombre FROM Aliado WHERE id_aliado IN (SELECT id_aliado FROM Empleado_Aliado);
SELECT nombre FROM Servicio WHERE precio < (SELECT AVG(precio) FROM Servicio);

-- 8. ALTER
ALTER TABLE Usuario ADD telefono VARCHAR(20);
ALTER TABLE Empleado ADD extension INT;
ALTER TABLE Servicio ADD duracion_min INT;
ALTER TABLE Sesion ADD metodo_pago VARCHAR(20);
ALTER TABLE Aliado ADD ciudad VARCHAR(50);

-- 9. FUNCIONES AGREGADAS
SELECT MAX(precio) AS max_precio FROM Servicio;
SELECT MIN(precio) AS min_precio FROM Servicio;
SELECT SUM(total) AS suma_total FROM Sesion;
SELECT AVG(salario) AS salario_prom FROM Empleado;
SELECT COUNT(*) AS total_usuarios FROM Usuario;
SELECT CONCAT(nombre, ' - ', telefono) AS usuario_info FROM Usuario;
SELECT UPPER(nombre) FROM Empleado;
SELECT LOWER(nombre) FROM Aliado;
SELECT ROUND(AVG(precio), 0) FROM Servicio;
SELECT LEFT(nombre, 3) FROM Servicio;

-- 10. PROCEDIMIENTO ALMACENADO
CREATE PROCEDURE SesionesPorEmpleado
@ID INT
AS
BEGIN
    SELECT s.id_sesion, s.fecha, s.total
    FROM Sesion s
    WHERE s.id_empleado = @ID;
END;

-- 11. TRUNCATE
TRUNCATE TABLE Sesion_Servicio;
TRUNCATE TABLE Empleado_Aliado;
TRUNCATE TABLE Sesion;
TRUNCATE TABLE Servicio;
TRUNCATE TABLE Usuario;

-- 12. DROP TABLE
DROP TABLE IF EXISTS Sesion_Servicio;
DROP TABLE IF EXISTS Empleado_Aliado;
DROP TABLE IF EXISTS Sesion;
DROP TABLE IF EXISTS Servicio;
DROP TABLE IF EXISTS Usuario;

-- 13. DROP DATABASE
DROP DATABASE IF EXISTS CentroBienestar;
