-- 1. CREAR BASE DE DATOS
CREATE DATABASE CentroSalud;
USE CentroSalud;

-- 2. CREAR TABLAS
CREATE TABLE Paciente (
    id_paciente INT PRIMARY KEY,
    nombre VARCHAR(50),
    correo VARCHAR(50)
);

CREATE TABLE Medico (
    id_medico INT PRIMARY KEY,
    nombre VARCHAR(50),
    especialidad VARCHAR(30),
    salario DECIMAL(10,2)
);

CREATE TABLE Tratamiento (
    id_tratamiento INT PRIMARY KEY,
    nombre VARCHAR(50),
    costo DECIMAL(8,2)
);

CREATE TABLE Cita (
    id_cita INT PRIMARY KEY,
    id_paciente INT,
    id_medico INT,
    fecha DATE,
    total DECIMAL(10,2),
    FOREIGN KEY (id_paciente) REFERENCES Paciente(id_paciente),
    FOREIGN KEY (id_medico) REFERENCES Medico(id_medico)
);

CREATE TABLE Clinica (
    id_clinica INT PRIMARY KEY,
    nombre VARCHAR(50),
    contacto VARCHAR(50)
);

CREATE TABLE Cita_Tratamiento (
    id_cita INT,
    id_tratamiento INT,
    cantidad INT,
    PRIMARY KEY (id_cita, id_tratamiento),
    FOREIGN KEY (id_cita) REFERENCES Cita(id_cita),
    FOREIGN KEY (id_tratamiento) REFERENCES Tratamiento(id_tratamiento)
);

CREATE TABLE Medico_Clinica (
    id_medico INT,
    id_clinica INT,
    turno VARCHAR(20),
    PRIMARY KEY (id_medico, id_clinica),
    FOREIGN KEY (id_medico) REFERENCES Medico(id_medico),
    FOREIGN KEY (id_clinica) REFERENCES Clinica(id_clinica)
);

-- 3. INSERT 
INSERT INTO Paciente VALUES
(1, 'Camila', 'c@c'), (2, 'Esteban', 'e@e'), (3, 'Valeria', 'v@v'), (4, 'Jorge', 'j@j'), (5, 'Laura', 'l@l');

INSERT INTO Medico VALUES
(1, 'Ana', 'Pediatría', 3000), (2, 'Luis', 'Cardio', 4000), (3, 'Pilar', 'Derma', 3500), (4, 'Mateo', 'Interna', 3800), (5, 'Sara', 'Gineco', 3700);

INSERT INTO Tratamiento VALUES
(1, 'Consulta', 40), (2, 'ECG', 80), (3, 'Prenatal', 100), (4, 'Terapia', 60), (5, 'Derma', 70);

INSERT INTO Clinica VALUES
(1, 'Salud', 's@s'), (2, 'Viva', 'v@v'), (3, 'Clini', 'c@c'), (4, 'Bien', 'b@b'), (5, 'Cor', 'c@c');

INSERT INTO Cita VALUES
(1, 1, 1, '2024-07-01', 120), (2, 2, 2, '2024-07-02', 160), (3, 3, 3, '2024-07-03', 200), (4, 4, 4, '2024-07-04', 180), (5, 5, 5, '2024-07-05', 210);

INSERT INTO Cita_Tratamiento VALUES
(1,1,1), (1,2,1), (2,2,1), (3,3,1), (4,4,1), (5,5,1);

INSERT INTO Medico_Clinica VALUES
(1,1,'Mañana'), (2,2,'Tarde'), (3,3,'Mañana'), (4,4,'Noche'), (5,5,'Tarde');

-- 4. UPDATE
UPDATE Paciente SET nombre = 'Cami G' WHERE id_paciente = 1;
UPDATE Medico SET salario = 4200 WHERE id_medico = 2;
UPDATE Tratamiento SET costo = 85 WHERE id_tratamiento = 2;
UPDATE Clinica SET nombre = 'Integral' WHERE id_clinica = 1;
UPDATE Cita SET total = 130 WHERE id_cita = 1;

-- 5. DELETE
DELETE FROM Cita_Tratamiento WHERE id_cita = 1 AND id_tratamiento = 1;
DELETE FROM Medico_Clinica WHERE id_medico = 2 AND id_clinica = 2;
DELETE FROM Cita WHERE id_cita = 2;
DELETE FROM Paciente WHERE id_paciente = 1;
DELETE FROM Tratamiento WHERE id_tratamiento = 1;

-- 6. SELECT JOIN
SELECT p.nombre FROM Paciente p JOIN Cita c ON p.id_paciente = c.id_paciente;
SELECT m.nombre FROM Medico m JOIN Medico_Clinica mc ON m.id_medico = mc.id_medico;
SELECT t.nombre FROM Cita_Tratamiento ct JOIN Tratamiento t ON ct.id_tratamiento = t.id_tratamiento;
SELECT m.nombre FROM Cita c JOIN Medico m ON c.id_medico = m.id_medico;
SELECT cl.nombre FROM Clinica cl JOIN Medico_Clinica mc ON cl.id_clinica = mc.id_clinica;

-- 7. SUBCONSULTAS 
SELECT nombre FROM Paciente WHERE id_paciente IN (SELECT id_paciente FROM Cita);
SELECT nombre FROM Tratamiento WHERE costo = (SELECT MAX(costo) FROM Tratamiento);
SELECT nombre FROM Medico WHERE salario > (SELECT AVG(salario) FROM Medico);
SELECT nombre FROM Clinica WHERE id_clinica IN (SELECT id_clinica FROM Medico_Clinica);
SELECT nombre FROM Tratamiento WHERE costo < (SELECT AVG(costo) FROM Tratamiento);

-- 8. ALTER
ALTER TABLE Paciente ADD telefono VARCHAR(20);
ALTER TABLE Medico ADD extension INT;
ALTER TABLE Tratamiento ADD duracion_min INT;
ALTER TABLE Cita ADD metodo_pago VARCHAR(20);
ALTER TABLE Clinica ADD ciudad VARCHAR(50);

-- 9. FUNCIONES AGREGADAS
SELECT MAX(costo) AS max_costo FROM Tratamiento;
SELECT MIN(costo) AS min_costo FROM Tratamiento;
SELECT SUM(total) AS suma_total FROM Cita;
SELECT AVG(salario) AS salario_prom FROM Medico;
SELECT COUNT(*) AS total_pacientes FROM Paciente;
SELECT CONCAT(nombre, ' - ', telefono) AS paciente_info FROM Paciente;
SELECT UPPER(nombre) FROM Medico;
SELECT LOWER(nombre) FROM Clinica;
SELECT ROUND(AVG(costo), 0) FROM Tratamiento;
SELECT LEFT(nombre, 3) FROM Tratamiento;

-- 10. PROCEDIMIENTO ALMACENADO
CREATE PROCEDURE CitasPorMedico
@ID INT
AS
BEGIN
    SELECT id_cita, fecha FROM Cita WHERE id_medico = @ID;
END;

-- 11. TRUNCATE
TRUNCATE TABLE Cita_Tratamiento;
TRUNCATE TABLE Medico_Clinica;
TRUNCATE TABLE Cita;
TRUNCATE TABLE Tratamiento;
TRUNCATE TABLE Paciente;

-- 12. DROP TABLE
DROP TABLE IF EXISTS Cita_Tratamiento;
DROP TABLE IF EXISTS Medico_Clinica;
DROP TABLE IF EXISTS Cita;
DROP TABLE IF EXISTS Tratamiento;
DROP TABLE IF EXISTS Paciente;

-- 13. DROP DATABASE
DROP DATABASE IF EXISTS CentroSalud;
