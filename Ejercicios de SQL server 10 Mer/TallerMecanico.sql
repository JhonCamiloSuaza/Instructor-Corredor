-- 1. BASE DE DATOS
CREATE DATABASE TallerMecanico;
USE TallerMecanico;

-- 2. TABLAS PRINCIPALES 
CREATE TABLE Cliente (
  id_cliente INT PRIMARY KEY,
  nombre VARCHAR(30),
  telefono VARCHAR(15)
);

CREATE TABLE Vehiculo (
  id_vehiculo INT PRIMARY KEY,
  modelo VARCHAR(30),
  tipo VARCHAR(20)
);

CREATE TABLE Servicio (
  id_servicio INT PRIMARY KEY,
  nombre VARCHAR(30),
  costo DECIMAL(8,2)
);

CREATE TABLE Mecanico (
  id_mecanico INT PRIMARY KEY,
  nombre VARCHAR(30),
  turno VARCHAR(15)
);

CREATE TABLE Taller (
  id_taller INT PRIMARY KEY,
  nombre VARCHAR(30),
  ciudad VARCHAR(30)
);

CREATE TABLE Vehiculo_Servicio (
  id_vehiculo INT,
  id_servicio INT,
  fecha DATE,
  PRIMARY KEY (id_vehiculo, id_servicio),
  FOREIGN KEY (id_vehiculo) REFERENCES Vehiculo(id_vehiculo),
  FOREIGN KEY (id_servicio) REFERENCES Servicio(id_servicio)
);

CREATE TABLE Mecanico_Taller (
  id_mecanico INT,
  id_taller INT,
  horario VARCHAR(15),
  PRIMARY KEY (id_mecanico, id_taller),
  FOREIGN KEY (id_mecanico) REFERENCES Mecanico(id_mecanico),
  FOREIGN KEY (id_taller) REFERENCES Taller(id_taller)
);

-- 3. INSERTS (cortos)
INSERT INTO Cliente VALUES (1,'Ana','123'), (2,'Leo','456');
INSERT INTO Vehiculo VALUES (1,'Spark','Auto'), (2,'Logan','Sedan');
INSERT INTO Servicio VALUES (1,'Aceite',50), (2,'Frenos',80);
INSERT INTO Mecanico VALUES (1,'Carlos','AM'), (2,'Pedro','PM');
INSERT INTO Taller VALUES (1,'FixCar','Bogotá'), (2,'ProCar','Cali');
INSERT INTO Vehiculo_Servicio VALUES (1,1,'2024-07-01'), (2,2,'2024-07-02');
INSERT INTO Mecanico_Taller VALUES (1,1,'AM'), (2,2,'PM');

-- 4. UPDATE
UPDATE Cliente SET nombre='Anita' WHERE id_cliente=1;
UPDATE Vehiculo SET tipo='Pickup' WHERE id_vehiculo=1;
UPDATE Servicio SET costo=55 WHERE id_servicio=1;
UPDATE Taller SET ciudad='Cartagena' WHERE id_taller=1;

-- 5. DELETE
DELETE FROM Vehiculo_Servicio WHERE id_vehiculo=1;
DELETE FROM Mecanico_Taller WHERE id_mecanico=1;
DELETE FROM Vehiculo WHERE id_vehiculo=1;
DELETE FROM Cliente WHERE id_cliente=1;

-- 6. SELECT JOIN (cortas)
SELECT nombre FROM Cliente;
SELECT modelo FROM Vehiculo;
SELECT nombre FROM Taller;

-- 7. SUBCONSULTAS (cortas)
SELECT nombre FROM Servicio WHERE id_servicio IN (SELECT id_servicio FROM Vehiculo_Servicio);
SELECT modelo FROM Vehiculo WHERE id_vehiculo IN (SELECT id_vehiculo FROM Vehiculo_Servicio);
SELECT nombre FROM Taller WHERE id_taller IN (SELECT id_taller FROM Mecanico_Taller);

-- 8. ALTER
ALTER TABLE Cliente ADD correo VARCHAR(30);
ALTER TABLE Vehiculo ADD año INT;
ALTER TABLE Servicio ADD tipo VARCHAR(20);

-- 9. FUNCIONES
SELECT MAX(costo) FROM Servicio;
SELECT MIN(costo) FROM Servicio;
SELECT SUM(costo) FROM Servicio;
SELECT AVG(costo) FROM Servicio;
SELECT COUNT(*) FROM Cliente;
SELECT CONCAT(nombre,' - ',telefono) FROM Cliente;
SELECT UPPER(nombre) FROM Mecanico;
SELECT LOWER(nombre) FROM Taller;
SELECT ROUND(AVG(costo),0) FROM Servicio;
SELECT LEFT(nombre,3) FROM Taller;

-- 10. PROCEDIMIENTO
CREATE PROCEDURE ServiciosPorVehiculo @ID INT
AS
BEGIN
  SELECT id_servicio, fecha FROM Vehiculo_Servicio WHERE id_vehiculo = @ID;
END;

-- 11. TRUNCATE
TRUNCATE TABLE Vehiculo_Servicio;
TRUNCATE TABLE Cliente;
TRUNCATE TABLE Vehiculo;

-- 12. DROP TABLE
DROP TABLE IF EXISTS Vehiculo_Servicio;
DROP TABLE IF EXISTS Vehiculo;
DROP TABLE IF EXISTS Cliente;

-- 13. DROP DATABASE
DROP DATABASE IF EXISTS TallerMecanico;
