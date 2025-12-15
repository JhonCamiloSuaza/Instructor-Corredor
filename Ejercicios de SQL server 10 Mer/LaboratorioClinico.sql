-- 1. BASE DE DATOS
CREATE DATABASE LaboratorioClinico;
USE LaboratorioClinico;

-- 2. TABLAS
CREATE TABLE Paciente (
  id_paciente INT PRIMARY KEY,
  nombre VARCHAR(30),
  edad INT,
  correo VARCHAR(30)
);

CREATE TABLE Prueba (
  id_prueba INT PRIMARY KEY,
  nombre VARCHAR(30),
  tipo VARCHAR(20)
);

CREATE TABLE Cita (
  id_cita INT PRIMARY KEY,
  id_paciente INT,
  id_prueba INT,
  fecha DATE,
  FOREIGN KEY (id_paciente) REFERENCES Paciente(id_paciente),
  FOREIGN KEY (id_prueba) REFERENCES Prueba(id_prueba)
);

CREATE TABLE Tecnico (
  id_tecnico INT PRIMARY KEY,
  nombre VARCHAR(30),
  turno VARCHAR(15)
);

CREATE TABLE Laboratorio (
  id_laboratorio INT PRIMARY KEY,
  nombre VARCHAR(30),
  ubicacion VARCHAR(30)
);

CREATE TABLE Cita_Prueba (
  id_cita INT,
  id_prueba INT,
  resultado VARCHAR(50),
  PRIMARY KEY (id_cita, id_prueba),
  FOREIGN KEY (id_cita) REFERENCES Cita(id_cita),
  FOREIGN KEY (id_prueba) REFERENCES Prueba(id_prueba)
);

CREATE TABLE Tecnico_Laboratorio (
  id_tecnico INT,
  id_laboratorio INT,
  horario VARCHAR(15),
  PRIMARY KEY (id_tecnico, id_laboratorio),
  FOREIGN KEY (id_tecnico) REFERENCES Tecnico(id_tecnico),
  FOREIGN KEY (id_laboratorio) REFERENCES Laboratorio(id_laboratorio)
);

-- 3. INSERTS 
INSERT INTO Paciente VALUES (1,'Ana',28,'ana@mail.com'), (2,'Luis',35,'luis@mail.com');
INSERT INTO Prueba VALUES (1,'Sangre','Hematología'), (2,'Orina','Bioquímica');
INSERT INTO Cita VALUES (1,1,1,'2024-07-10'), (2,2,2,'2024-07-11');
INSERT INTO Tecnico VALUES (1,'Laura','AM'), (2,'Pedro','PM');
INSERT INTO Laboratorio VALUES (1,'Lab1','Piso 1'), (2,'Lab2','Piso 2');
INSERT INTO Cita_Prueba VALUES (1,1,'Normal'), (2,2,'Anormal');
INSERT INTO Tecnico_Laboratorio VALUES (1,1,'AM'), (2,2,'PM');

-- 4. UPDATE
UPDATE Paciente SET nombre='Anita' WHERE id_paciente=1;
UPDATE Prueba SET tipo='Química' WHERE id_prueba=1;
UPDATE Tecnico SET turno='Tarde' WHERE id_tecnico=1;
UPDATE Laboratorio SET ubicacion='Subsuelo' WHERE id_laboratorio=1;

-- 5. DELETE
DELETE FROM Cita_Prueba WHERE id_cita=1;
DELETE FROM Tecnico_Laboratorio WHERE id_tecnico=1;
DELETE FROM Cita WHERE id_cita=1;
DELETE FROM Paciente WHERE id_paciente=1;

-- 6. SELECT JOIN 
SELECT nombre FROM Paciente;
SELECT nombre FROM Prueba;
SELECT nombre FROM Laboratorio;

-- 7. SUBCONSULTAS 
SELECT nombre FROM Paciente WHERE id_paciente IN (SELECT id_paciente FROM Cita);
SELECT nombre FROM Prueba WHERE id_prueba IN (SELECT id_prueba FROM Cita_Prueba);
SELECT nombre FROM Laboratorio WHERE id_laboratorio IN (SELECT id_laboratorio FROM Tecnico_Laboratorio);

-- 8. ALTER
ALTER TABLE Paciente ADD telefono VARCHAR(15);
ALTER TABLE Prueba ADD precio DECIMAL(6,2);
ALTER TABLE Cita ADD estado VARCHAR(15);

-- 9. FUNCIONES AGREGADAS
SELECT COUNT(*) FROM Paciente;
SELECT MAX(edad) FROM Paciente;
SELECT MIN(edad) FROM Paciente;
SELECT SUM(precio) FROM Prueba;
SELECT AVG(precio) FROM Prueba;
SELECT CONCAT(nombre,' - ',correo) FROM Paciente;
SELECT UPPER(nombre) FROM Tecnico;
SELECT LOWER(nombre) FROM Laboratorio;
SELECT ROUND(AVG(precio),0) FROM Prueba;
SELECT LEFT(nombre,3) FROM Laboratorio;

-- 10. PROCEDIMIENTO
CREATE PROCEDURE CitasPorPaciente @ID INT
AS
BEGIN
  SELECT id_cita, fecha FROM Cita WHERE id_paciente = @ID;
END;

-- 11. TRUNCATE
TRUNCATE TABLE Cita_Prueba;
TRUNCATE TABLE Cita;
TRUNCATE TABLE Paciente;

-- 12. DROP TABLE
DROP TABLE IF EXISTS Cita_Prueba;
DROP TABLE IF EXISTS Cita;
DROP TABLE IF EXISTS Paciente;

-- 13. DROP DATABASE
DROP DATABASE IF EXISTS LaboratorioClinico;
