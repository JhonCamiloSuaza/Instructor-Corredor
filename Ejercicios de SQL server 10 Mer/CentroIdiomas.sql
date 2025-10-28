-- 1. BASE DE DATOS
CREATE DATABASE CentroIdiomas;
USE CentroIdiomas;

-- 2. TABLAS
CREATE TABLE Estudiante (
  id_estudiante INT PRIMARY KEY,
  nombre VARCHAR(30),
  nivel VARCHAR(20)
);

CREATE TABLE Idioma (
  id_idioma INT PRIMARY KEY,
  nombre VARCHAR(20),
  region VARCHAR(30)
);

CREATE TABLE Curso (
  id_curso INT PRIMARY KEY,
  id_estudiante INT,
  id_idioma INT,
  fecha DATE,
  FOREIGN KEY (id_estudiante) REFERENCES Estudiante(id_estudiante),
  FOREIGN KEY (id_idioma) REFERENCES Idioma(id_idioma)
);

CREATE TABLE Profesor (
  id_profesor INT PRIMARY KEY,
  nombre VARCHAR(30),
  horario VARCHAR(15)
);

CREATE TABLE Aula (
  id_aula INT PRIMARY KEY,
  nombre VARCHAR(30),
  piso VARCHAR(10)
);

CREATE TABLE Curso_Idioma (
  id_curso INT,
  id_idioma INT,
  duracion INT,
  PRIMARY KEY (id_curso, id_idioma),
  FOREIGN KEY (id_curso) REFERENCES Curso(id_curso),
  FOREIGN KEY (id_idioma) REFERENCES Idioma(id_idioma)
);

CREATE TABLE Profesor_Aula (
  id_profesor INT,
  id_aula INT,
  turno VARCHAR(15),
  PRIMARY KEY (id_profesor, id_aula),
  FOREIGN KEY (id_profesor) REFERENCES Profesor(id_profesor),
  FOREIGN KEY (id_aula) REFERENCES Aula(id_aula)
);

-- 3. INSERTS
INSERT INTO Estudiante VALUES (1,'Ana','Básico'), (2,'Luis','Inter');
INSERT INTO Idioma VALUES (1,'Inglés','Europa'), (2,'Japonés','Asia');
INSERT INTO Curso VALUES (1,1,1,'2024-07-01'), (2,2,2,'2024-07-02');
INSERT INTO Profesor VALUES (1,'Sara','AM'), (2,'Leo','PM');
INSERT INTO Aula VALUES (1,'A1','1'), (2,'B2','2');
INSERT INTO Curso_Idioma VALUES (1,1,40), (2,2,35);
INSERT INTO Profesor_Aula VALUES (1,1,'AM'), (2,2,'PM');

-- 4. UPDATE
UPDATE Estudiante SET nombre='Anita' WHERE id_estudiante=1;
UPDATE Idioma SET region='América' WHERE id_idioma=1;
UPDATE Curso SET fecha='2024-08-01' WHERE id_curso=1;
UPDATE Aula SET piso='Sótano' WHERE id_aula=1;

-- 5. DELETE
DELETE FROM Curso_Idioma WHERE id_curso=1;
DELETE FROM Profesor_Aula WHERE id_profesor=1;
DELETE FROM Curso WHERE id_curso=1;
DELETE FROM Estudiante WHERE id_estudiante=1;

-- 6. SELECT JOIN 
SELECT nombre FROM Estudiante;
SELECT nombre FROM Idioma;
SELECT nombre FROM Aula;

-- 7. SUBCONSULTAS 
SELECT nombre FROM Estudiante WHERE id_estudiante IN (SELECT id_estudiante FROM Curso);
SELECT nombre FROM Idioma WHERE id_idioma IN (SELECT id_idioma FROM Curso_Idioma);
SELECT nombre FROM Aula WHERE id_aula IN (SELECT id_aula FROM Profesor_Aula);

-- 8. ALTER
ALTER TABLE Estudiante ADD correo VARCHAR(30);
ALTER TABLE Idioma ADD nivel_requerido VARCHAR(20);
ALTER TABLE Curso ADD modalidad VARCHAR(15);

-- 9. FUNCIONES
SELECT COUNT(*) FROM Estudiante;
SELECT MAX(duracion) FROM Curso_Idioma;
SELECT MIN(duracion) FROM Curso_Idioma;
SELECT SUM(duracion) FROM Curso_Idioma;
SELECT AVG(duracion) FROM Curso_Idioma;
SELECT CONCAT(nombre,' - ',nivel) FROM Estudiante;
SELECT UPPER(nombre) FROM Profesor;
SELECT LOWER(nombre) FROM Aula;
SELECT ROUND(AVG(duracion),0) FROM Curso_Idioma;
SELECT LEFT(nombre,3) FROM Idioma;

-- 10. PROCEDIMIENTO
CREATE PROCEDURE CursosPorEstudiante @ID INT
AS
BEGIN
  SELECT id_curso, fecha FROM Curso WHERE id_estudiante = @ID;
END;

-- 11. TRUNCATE
TRUNCATE TABLE Curso_Idioma;
TRUNCATE TABLE Curso;
TRUNCATE TABLE Estudiante;

-- 12. DROP TABLE
DROP TABLE IF EXISTS Curso_Idioma;
DROP TABLE IF EXISTS Curso;
DROP TABLE IF EXISTS Estudiante;

-- 13. DROP DATABASE
DROP DATABASE IF EXISTS CentroIdiomas;
