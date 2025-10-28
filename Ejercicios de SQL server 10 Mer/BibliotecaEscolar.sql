-- 1. BASE DE DATOS
CREATE DATABASE BibliotecaEscolar;
USE BibliotecaEscolar;

-- 2. TABLAS
CREATE TABLE Estudiante (
    id_estudiante INT PRIMARY KEY,
    nombre VARCHAR(30),
    grado VARCHAR(10)
);

CREATE TABLE Libro (
    id_libro INT PRIMARY KEY,
    titulo VARCHAR(30),
    area VARCHAR(20)
);

CREATE TABLE Prestamo (
    id_prestamo INT PRIMARY KEY,
    id_estudiante INT,
    id_libro INT,
    fecha DATE,
    FOREIGN KEY (id_estudiante) REFERENCES Estudiante(id_estudiante),
    FOREIGN KEY (id_libro) REFERENCES Libro(id_libro)
);

CREATE TABLE Bibliotecario (
    id_bibliotecario INT PRIMARY KEY,
    nombre VARCHAR(30),
    turno VARCHAR(15)
);

CREATE TABLE Editorial (
    id_editorial INT PRIMARY KEY,
    nombre VARCHAR(30),
    contacto VARCHAR(30)
);

CREATE TABLE Libro_Editorial (
    id_libro INT,
    id_editorial INT,
    PRIMARY KEY (id_libro, id_editorial),
    FOREIGN KEY (id_libro) REFERENCES Libro(id_libro),
    FOREIGN KEY (id_editorial) REFERENCES Editorial(id_editorial)
);

CREATE TABLE Bibliotecario_Editorial (
    id_bibliotecario INT,
    id_editorial INT,
    horario VARCHAR(15),
    PRIMARY KEY (id_bibliotecario, id_editorial),
    FOREIGN KEY (id_bibliotecario) REFERENCES Bibliotecario(id_bibliotecario),
    FOREIGN KEY (id_editorial) REFERENCES Editorial(id_editorial)
);

-- 3. INSERTS 
INSERT INTO Estudiante VALUES (1,'Ana','5A'), (2,'Luis','6B'), (3,'Marta','7C');
INSERT INTO Libro VALUES (1,'Cuentos','Inf'), (2,'Álgebra','Mat'), (3,'Hist','Soc');
INSERT INTO Prestamo VALUES (1,1,1,'2024-07-01'), (2,2,2,'2024-07-02'), (3,3,3,'2024-07-03');
INSERT INTO Bibliotecario VALUES (1,'Car','AM'), (2,'Lau','PM'), (3,'Ped','Noc');
INSERT INTO Editorial VALUES (1,'Pla','p@p'), (2,'San','s@s'), (3,'Nor','n@n');
INSERT INTO Libro_Editorial VALUES (1,1), (2,2), (3,3);
INSERT INTO Bibliotecario_Editorial VALUES (1,1,'AM'), (2,2,'PM'), (3,3,'Noc');

-- 4. UPDATE 
UPDATE Estudiante SET nombre='Anita' WHERE id_estudiante=1;
UPDATE Libro SET area='Infantil' WHERE id_libro=1;
UPDATE Bibliotecario SET turno='Tarde' WHERE id_bibliotecario=1;
UPDATE Editorial SET contacto='edit@pla.com' WHERE id_editorial=1;

-- 5. DELETE 
DELETE FROM Libro_Editorial WHERE id_libro=1;
DELETE FROM Bibliotecario_Editorial WHERE id_bibliotecario=1;
DELETE FROM Prestamo WHERE id_prestamo=1;
DELETE FROM Estudiante WHERE id_estudiante=1;

-- 6. SELECT JOIN 
SELECT e.nombre FROM Estudiante e JOIN Prestamo p ON e.id_estudiante = p.id_estudiante;
SELECT l.titulo FROM Libro l JOIN Prestamo p ON l.id_libro = p.id_libro;
SELECT b.nombre FROM Bibliotecario b JOIN Bibliotecario_Editorial be ON b.id_bibliotecario = be.id_bibliotecario;

-- 7. SUBCONSULTAS 
SELECT nombre FROM Estudiante WHERE id_estudiante IN (SELECT id_estudiante FROM Prestamo);
SELECT titulo FROM Libro WHERE id_libro IN (SELECT id_libro FROM Prestamo);
SELECT nombre FROM Editorial WHERE id_editorial IN (SELECT id_editorial FROM Libro_Editorial);

-- 8. ALTER 
ALTER TABLE Estudiante ADD telefono VARCHAR(15);
ALTER TABLE Libro ADD stock INT;
ALTER TABLE Prestamo ADD metodo_pago VARCHAR(20);

-- 9. FUNCIONES (10)
SELECT MAX(stock) FROM Libro;
SELECT MIN(stock) FROM Libro;
SELECT SUM(stock) FROM Libro;
SELECT AVG(stock) FROM Libro;
SELECT COUNT(*) FROM Estudiante;
SELECT CONCAT(nombre,' - ',telefono) FROM Estudiante;
SELECT UPPER(nombre) FROM Bibliotecario;
SELECT LOWER(nombre) FROM Editorial;
SELECT ROUND(AVG(stock),0) FROM Libro;
SELECT LEFT(nombre, 3) FROM Editorial;

-- 10. PROCEDIMIENTO
CREATE PROCEDURE PrestamosPorEstudiante
@ID INT
AS
BEGIN
  SELECT id_prestamo, fecha FROM Prestamo WHERE id_estudiante = @ID;
END;

-- 11. TRUNCATE 
TRUNCATE TABLE Libro_Editorial;
TRUNCATE TABLE Prestamo;
TRUNCATE TABLE Estudiante;

-- 12. DROP TABLE
DROP TABLE IF EXISTS Libro_Editorial;
DROP TABLE IF EXISTS Prestamo;
DROP TABLE IF EXISTS Estudiante;

-- 13. DROP DATABASE
DROP DATABASE IF EXISTS BibliotecaEscolar;
