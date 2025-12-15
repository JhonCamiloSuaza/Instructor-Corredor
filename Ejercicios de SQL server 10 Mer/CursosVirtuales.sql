-- 1. BASE DE DATOS
CREATE DATABASE CursosVirtuales;
USE CursosVirtuales;

-- 2. TABLAS
CREATE TABLE Estudiante (
  id_estudiante INT PRIMARY KEY,
  nombre VARCHAR(30),
  grado VARCHAR(10)
);

CREATE TABLE Curso (
  id_curso INT PRIMARY KEY,
  nombre VARCHAR(30),
  area VARCHAR(20)
);

CREATE TABLE Inscripcion (
  id_inscripcion INT PRIMARY KEY,
  id_estudiante INT,
  id_curso INT,
  fecha DATE,
  FOREIGN KEY (id_estudiante) REFERENCES Estudiante(id_estudiante),
  FOREIGN KEY (id_curso) REFERENCES Curso(id_curso)
);

CREATE TABLE Docente (
  id_docente INT PRIMARY KEY,
  nombre VARCHAR(30),
  horario VARCHAR(15)
);

CREATE TABLE Plataforma (
  id_plataforma INT PRIMARY KEY,
  nombre VARCHAR(30),
  contacto VARCHAR(30)
);

CREATE TABLE Curso_Plataforma (
  id_curso INT,
  id_plataforma INT,
  PRIMARY KEY (id_curso, id_plataforma),
  FOREIGN KEY (id_curso) REFERENCES Curso(id_curso),
  FOREIGN KEY (id_plataforma) REFERENCES Plataforma(id_plataforma)
);

CREATE TABLE Docente_Plataforma (
  id_docente INT,
  id_plataforma INT,
  horario VARCHAR(15),
  PRIMARY KEY (id_docente, id_plataforma),
  FOREIGN KEY (id_docente) REFERENCES Docente(id_docente),
  FOREIGN KEY (id_plataforma) REFERENCES Plataforma(id_plataforma)
);

-- 3. INSERTS 
INSERT INTO Estudiante VALUES (1,'Ana','5A'), (2,'Leo','6B'), (3,'Mia','7C');
INSERT INTO Curso VALUES (1,'Mate','Mat'), (2,'His','Soc'), (3,'Bio','Cie');
INSERT INTO Inscripcion VALUES (1,1,1,'2024-07-01'), (2,2,2,'2024-07-02'), (3,3,3,'2024-07-03');
INSERT INTO Docente VALUES (1,'Car','AM'), (2,'Lau','PM'), (3,'Tom','Noc');
INSERT INTO Plataforma VALUES (1,'Zoom','z@z'), (2,'Meet','m@m'), (3,'Teams','t@t');
INSERT INTO Curso_Plataforma VALUES (1,1), (2,2), (3,3);
INSERT INTO Docente_Plataforma VALUES (1,1,'AM'), (2,2,'PM'), (3,3,'Noc');

-- 4. UPDATE
UPDATE Estudiante SET nombre='Anita' WHERE id_estudiante=1;
UPDATE Curso SET area='Matemáticas' WHERE id_curso=1;
UPDATE Docente SET horario='Tarde' WHERE id_docente=1;
UPDATE Plataforma SET contacto='zoom@correo.com' WHERE id_plataforma=1;

-- 5. DELETE
DELETE FROM Curso_Plataforma WHERE id_curso=1;
DELETE FROM Docente_Plataforma WHERE id_docente=1;
DELETE FROM Inscripcion WHERE id_inscripcion=1;
DELETE FROM Estudiante WHERE id_estudiante=1;

-- 6. SELECT JOIN 
SELECT e.nombre FROM Estudiante e JOIN Inscripcion i ON e.id_estudiante=i.id_estudiante;
SELECT c.nombre FROM Curso c JOIN Inscripcion i ON c.id_curso=i.id_curso;
SELECT d.nombre FROM Docente d JOIN Docente_Plataforma dp ON d.id_docente=dp.id_docente;

-- 7. SUBCONSULTAS 
SELECT nombre FROM Estudiante WHERE id_estudiante IN (SELECT id_estudiante FROM Inscripcion);
SELECT nombre FROM Curso WHERE id_curso IN (SELECT id_curso FROM Inscripcion);
SELECT nombre FROM Plataforma WHERE id_plataforma IN (SELECT id_plataforma FROM Curso_Plataforma);

-- 8. ALTER
ALTER TABLE Estudiante ADD telefono VARCHAR(15);
ALTER TABLE Curso ADD duracion INT;
ALTER TABLE Inscripcion ADD pago VARCHAR(15);

-- 9. FUNCIONES
SELECT MAX(duracion) FROM Curso;
SELECT MIN(duracion) FROM Curso;
SELECT SUM(duracion) FROM Curso;
SELECT AVG(duracion) FROM Curso;
SELECT COUNT(*) FROM Estudiante;
SELECT CONCAT(nombre,' - ',telefono) FROM Estudiante;
SELECT UPPER(nombre) FROM Docente;
SELECT LOWER(nombre) FROM Plataforma;
SELECT ROUND(AVG(duracion),0) FROM Curso;
SELECT LEFT(nombre,3) FROM Plataforma;

-- 10. PROCEDIMIENTO
CREATE PROCEDURE InscripcionesPorEstudiante @ID INT
AS
BEGIN
  SELECT id_inscripcion, fecha FROM Inscripcion WHERE id_estudiante = @ID;
END;

-- 11. TRUNCATE
TRUNCATE TABLE Curso_Plataforma;
TRUNCATE TABLE Inscripcion;
TRUNCATE TABLE Estudiante;

-- 12. DROP TABLE
DROP TABLE IF EXISTS Curso_Plataforma;
DROP TABLE IF EXISTS Inscripcion;
DROP TABLE IF EXISTS Estudiante;

-- 13. DROP DATABASE
DROP DATABASE IF EXISTS CursosVirtuales;
