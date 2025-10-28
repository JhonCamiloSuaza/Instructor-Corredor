-- BASE DE DATOS
CREATE DATABASE CineClub;
USE CineClub;

-- TABLAS
CREATE TABLE Socio (
  id_socio INT PRIMARY KEY,
  nombre VARCHAR(30),
  tipo VARCHAR(15)
);

CREATE TABLE Pelicula (
  id_pelicula INT PRIMARY KEY,
  titulo VARCHAR(30),
  genero VARCHAR(20)
);

CREATE TABLE Reserva (
  id_reserva INT PRIMARY KEY,
  id_socio INT,
  id_pelicula INT,
  fecha DATE,
  FOREIGN KEY (id_socio) REFERENCES Socio(id_socio),
  FOREIGN KEY (id_pelicula) REFERENCES Pelicula(id_pelicula)
);

CREATE TABLE Empleado (
  id_empleado INT PRIMARY KEY,
  nombre VARCHAR(30),
  turno VARCHAR(15)
);

CREATE TABLE Productora (
  id_productora INT PRIMARY KEY,
  nombre VARCHAR(30),
  contacto VARCHAR(30)
);

CREATE TABLE Pelicula_Productora (
  id_pelicula INT,
  id_productora INT,
  PRIMARY KEY (id_pelicula, id_productora),
  FOREIGN KEY (id_pelicula) REFERENCES Pelicula(id_pelicula),
  FOREIGN KEY (id_productora) REFERENCES Productora(id_productora)
);

CREATE TABLE Empleado_Productora (
  id_empleado INT,
  id_productora INT,
  horario VARCHAR(15),
  PRIMARY KEY (id_empleado, id_productora),
  FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado),
  FOREIGN KEY (id_productora) REFERENCES Productora(id_productora)
);

-- INSERTS
INSERT INTO Socio VALUES (1,'Ana','Oro'),(2,'Leo','Plata'),(3,'Eva','Bronce');
INSERT INTO Pelicula VALUES (1,'Duna','SciFi'),(2,'Up','Anim'),(3,'Red','Com');
INSERT INTO Reserva VALUES (1,1,1,'2024-07-01'),(2,2,2,'2024-07-02'),(3,3,3,'2024-07-03');
INSERT INTO Empleado VALUES (1,'Tom','AM'),(2,'Liz','PM'),(3,'Max','Noc');
INSERT INTO Productora VALUES (1,'Fox','f@f'),(2,'Pix','p@p'),(3,'WB','w@w');
INSERT INTO Pelicula_Productora VALUES (1,1),(2,2),(3,3);
INSERT INTO Empleado_Productora VALUES (1,1,'AM'),(2,2,'PM'),(3,3,'Noc');

-- UPDATE 
UPDATE Socio SET nombre='Ani' WHERE id_socio=1;
UPDATE Pelicula SET genero='Drama' WHERE id_pelicula=1;
UPDATE Empleado SET turno='Tarde' WHERE id_empleado=1;
UPDATE Productora SET contacto='fox@mail' WHERE id_productora=1;

-- DELETE 
DELETE FROM Pelicula_Productora WHERE id_pelicula=1;
DELETE FROM Empleado_Productora WHERE id_empleado=1;
DELETE FROM Reserva WHERE id_reserva=1;
DELETE FROM Socio WHERE id_socio=1;

-- SELECT JOIN 
SELECT s.nombre FROM Socio s JOIN Reserva r ON s.id_socio = r.id_socio;
SELECT p.titulo FROM Pelicula p JOIN Reserva r ON p.id_pelicula = r.id_pelicula;
SELECT e.nombre FROM Empleado e JOIN Empleado_Productora ep ON e.id_empleado = ep.id_empleado;

-- SUBCONSULTAS 
SELECT nombre FROM Socio WHERE id_socio IN (SELECT id_socio FROM Reserva);
SELECT titulo FROM Pelicula WHERE id_pelicula IN (SELECT id_pelicula FROM Reserva);
SELECT nombre FROM Productora WHERE id_productora IN (SELECT id_productora FROM Pelicula_Productora);

-- ALTER 
ALTER TABLE Socio ADD telefono VARCHAR(15);
ALTER TABLE Pelicula ADD stock INT;
ALTER TABLE Reserva ADD metodo_pago VARCHAR(20);

-- FUNCIONES (10 compactas)
SELECT MAX(stock) FROM Pelicula;
SELECT MIN(stock) FROM Pelicula;
SELECT SUM(stock) FROM Pelicula;
SELECT AVG(stock) FROM Pelicula;
SELECT COUNT(*) FROM Socio;
SELECT CONCAT(nombre,' - ',telefono) FROM Socio;
SELECT UPPER(nombre) FROM Empleado;
SELECT LOWER(nombre) FROM Productora;
SELECT ROUND(AVG(stock),0) FROM Pelicula;
SELECT LEFT(nombre,3) FROM Productora;

-- PROCEDIMIENTO
CREATE PROCEDURE ReservasPorSocio
@ID INT
AS
BEGIN
  SELECT id_reserva, fecha FROM Reserva WHERE id_socio = @ID;
END;

-- TRUNCATE
TRUNCATE TABLE Pelicula_Productora;
TRUNCATE TABLE Reserva;
TRUNCATE TABLE Socio;

-- DROP
DROP TABLE IF EXISTS Pelicula_Productora;
DROP TABLE IF EXISTS Reserva;
DROP TABLE IF EXISTS Socio;

-- DROP DATABASE
DROP DATABASE IF EXISTS CineClub;
