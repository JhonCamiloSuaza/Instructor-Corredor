-- 1. BASE DE DATOS
CREATE DATABASE EscuelaMusica;
USE EscuelaMusica;

-- 2. TABLAS
CREATE TABLE Alumno (
  id_alumno INT PRIMARY KEY,
  nombre VARCHAR(30),
  nivel VARCHAR(15)
);

CREATE TABLE Instrumento (
  id_instrumento INT PRIMARY KEY,
  nombre VARCHAR(30),
  tipo VARCHAR(20)
);

CREATE TABLE Clase (
  id_clase INT PRIMARY KEY,
  id_alumno INT,
  id_instrumento INT,
  fecha DATE,
  FOREIGN KEY (id_alumno) REFERENCES Alumno(id_alumno),
  FOREIGN KEY (id_instrumento) REFERENCES Instrumento(id_instrumento)
);

CREATE TABLE Profesor (
  id_profesor INT PRIMARY KEY,
  nombre VARCHAR(30),
  turno VARCHAR(15)
);

CREATE TABLE Sala (
  id_sala INT PRIMARY KEY,
  nombre VARCHAR(30),
  ubicacion VARCHAR(30)
);

CREATE TABLE Clase_Instrumento (
  id_clase INT,
  id_instrumento INT,
  duracion INT,
  PRIMARY KEY (id_clase, id_instrumento),
  FOREIGN KEY (id_clase) REFERENCES Clase(id_clase),
  FOREIGN KEY (id_instrumento) REFERENCES Instrumento(id_instrumento)
);

CREATE TABLE Profesor_Sala (
  id_profesor INT,
  id_sala INT,
  horario VARCHAR(15),
  PRIMARY KEY (id_profesor, id_sala),
  FOREIGN KEY (id_profesor) REFERENCES Profesor(id_profesor),
  FOREIGN KEY (id_sala) REFERENCES Sala(id_sala)
);

-- 3. INSERTS 
INSERT INTO Alumno VALUES (1,'Luna','Básico'), (2,'Max','Intermedio');
INSERT INTO Instrumento VALUES (1,'Piano','Tecla'), (2,'Guitarra','Cuerda');
INSERT INTO Clase VALUES (1,1,1,'2024-07-01'), (2,2,2,'2024-07-02');
INSERT INTO Profesor VALUES (1,'Sara','AM'), (2,'Leo','PM');
INSERT INTO Sala VALUES (1,'Sala1','Piso 1'), (2,'Sala2','Piso 2');
INSERT INTO Clase_Instrumento VALUES (1,1,60), (2,2,45);
INSERT INTO Profesor_Sala VALUES (1,1,'AM'), (2,2,'PM');

-- 4. UPDATE
UPDATE Alumno SET nombre='Lunita' WHERE id_alumno=1;
UPDATE Instrumento SET tipo='Percusión' WHERE id_instrumento=1;
UPDATE Profesor SET turno='Tarde' WHERE id_profesor=1;
UPDATE Sala SET ubicacion='Subsuelo' WHERE id_sala=1;

-- 5. DELETE
DELETE FROM Clase_Instrumento WHERE id_clase=1;
DELETE FROM Profesor_Sala WHERE id_profesor=1;
DELETE FROM Clase WHERE id_clase=1;
DELETE FROM Alumno WHERE id_alumno=1;

-- 6. SELECT JOIN
SELECT nombre FROM Alumno;
SELECT nombre FROM Instrumento;
SELECT nombre FROM Sala;

-- 7. SUBCONSULTAS 
SELECT nombre FROM Alumno WHERE id_alumno IN (SELECT id_alumno FROM Clase);
SELECT nombre FROM Instrumento WHERE id_instrumento IN (SELECT id_instrumento FROM Clase_Instrumento);
SELECT nombre FROM Sala WHERE id_sala IN (SELECT id_sala FROM Profesor_Sala);

-- 8. ALTER
ALTER TABLE Alumno ADD correo VARCHAR(30);
ALTER TABLE Instrumento ADD precio DECIMAL(6,2);
ALTER TABLE Clase ADD modalidad VARCHAR(15);

-- 9. FUNCIONES AGREGADAS
SELECT COUNT(*) FROM Alumno;
SELECT MAX(duracion) FROM Clase_Instrumento;
SELECT MIN(duracion) FROM Clase_Instrumento;
SELECT SUM(duracion) FROM Clase_Instrumento;
SELECT AVG(duracion) FROM Clase_Instrumento;
SELECT CONCAT(nombre,' - ',nivel) FROM Alumno;
SELECT UPPER(nombre) FROM Profesor;
SELECT LOWER(nombre) FROM Sala;
SELECT ROUND(AVG(duracion),0) FROM Clase_Instrumento;
SELECT LEFT(nombre,3) FROM Sala;

-- 10. PROCEDIMIENTO
CREATE PROCEDURE ClasesPorAlumno @ID INT
AS
BEGIN
  SELECT id_clase, fecha FROM Clase WHERE id_alumno = @ID;
END;

-- 11. TRUNCATE
TRUNCATE TABLE Clase_Instrumento;
TRUNCATE TABLE Clase;
TRUNCATE TABLE Alumno;

-- 12. DROP TABLE
DROP TABLE IF EXISTS Clase_Instrumento;
DROP TABLE IF EXISTS Clase;
DROP TABLE IF EXISTS Alumno;

-- 13. DROP DATABASE
DROP DATABASE IF EXISTS EscuelaMusica;
