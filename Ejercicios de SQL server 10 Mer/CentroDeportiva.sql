-- 1. BASE DE DATOS
CREATE DATABASE CentroDeportiva;
USE CentroDeportiva;

-- 2. TABLAS
CREATE TABLE Usuario (
    id_usuario INT PRIMARY KEY,
    nombre VARCHAR(50),
    correo VARCHAR(50)
);

CREATE TABLE Entrenador (
    id_entrenador INT PRIMARY KEY,
    nombre VARCHAR(50),
    especialidad VARCHAR(30),
    salario DECIMAL(10,2)
);

CREATE TABLE Rutina (
    id_rutina INT PRIMARY KEY,
    nombre VARCHAR(50),
    duracion INT
);

CREATE TABLE Clase (
    id_clase INT PRIMARY KEY,
    id_usuario INT,
    id_entrenador INT,
    fecha DATE,
    total DECIMAL(10,2),
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
    FOREIGN KEY (id_entrenador) REFERENCES Entrenador(id_entrenador)
);

CREATE TABLE Gimnasio (
    id_gimnasio INT PRIMARY KEY,
    nombre VARCHAR(50),
    ciudad VARCHAR(50)
);

CREATE TABLE Clase_Rutina (
    id_clase INT,
    id_rutina INT,
    repeticiones INT,
    PRIMARY KEY (id_clase, id_rutina),
    FOREIGN KEY (id_clase) REFERENCES Clase(id_clase),
    FOREIGN KEY (id_rutina) REFERENCES Rutina(id_rutina)
);

CREATE TABLE Entrenador_Gimnasio (
    id_entrenador INT,
    id_gimnasio INT,
    turno VARCHAR(20),
    PRIMARY KEY (id_entrenador, id_gimnasio),
    FOREIGN KEY (id_entrenador) REFERENCES Entrenador(id_entrenador),
    FOREIGN KEY (id_gimnasio) REFERENCES Gimnasio(id_gimnasio)
);

-- 3. INSERTS 
INSERT INTO Usuario VALUES (1,'Leo','l@l'),(2,'Tania','t@t'),(3,'Dani','d@d');
INSERT INTO Entrenador VALUES (1,'Ana','Cardio',2000),(2,'Luis','Pesas',2500),(3,'Cris','Yoga',2200);
INSERT INTO Rutina VALUES (1,'Cardio',30),(2,'Fuerza',45),(3,'Yoga',40);
INSERT INTO Gimnasio VALUES (1,'FitZone','Cali'),(2,'MoveIt','Bogotá'),(3,'TopFit','Medellín');
INSERT INTO Clase VALUES (1,1,1,'2024-07-01',100),(2,2,2,'2024-07-02',120),(3,3,3,'2024-07-03',90);
INSERT INTO Clase_Rutina VALUES (1,1,3),(2,2,2),(3,3,1);
INSERT INTO Entrenador_Gimnasio VALUES (1,1,'Mañana'),(2,2,'Tarde'),(3,3,'Noche');

-- 4. UPDATE 
UPDATE Usuario SET nombre = 'Leonardo' WHERE id_usuario = 1;
UPDATE Entrenador SET salario = 2600 WHERE id_entrenador = 2;
UPDATE Rutina SET duracion = 35 WHERE id_rutina = 1;
UPDATE Clase SET total = 110 WHERE id_clase = 1;

-- 5. DELETE 
DELETE FROM Clase_Rutina WHERE id_clase = 1;
DELETE FROM Entrenador_Gimnasio WHERE id_entrenador = 2;
DELETE FROM Clase WHERE id_clase = 1;
DELETE FROM Usuario WHERE id_usuario = 1;

-- 6. SELECT JOIN 
SELECT u.nombre FROM Usuario u JOIN Clase c ON u.id_usuario = c.id_usuario;
SELECT r.nombre FROM Clase_Rutina cr JOIN Rutina r ON cr.id_rutina = r.id_rutina;
SELECT g.nombre FROM Gimnasio g JOIN Entrenador_Gimnasio eg ON g.id_gimnasio = eg.id_gimnasio;

-- 7. SUBCONSULTAS 
SELECT nombre FROM Usuario WHERE id_usuario IN (SELECT id_usuario FROM Clase);
SELECT nombre FROM Entrenador WHERE salario > (SELECT AVG(salario) FROM Entrenador);
SELECT nombre FROM Rutina WHERE duracion < (SELECT AVG(duracion) FROM Rutina);

-- 8. ALTER 
ALTER TABLE Usuario ADD telefono VARCHAR(20);
ALTER TABLE Clase ADD metodo_pago VARCHAR(20);
ALTER TABLE Rutina ADD nivel VARCHAR(20);

-- 9. FUNCIONES AGREGADAS (10)
SELECT MAX(salario) FROM Entrenador;
SELECT MIN(salario) FROM Entrenador;
SELECT SUM(total) FROM Clase;
SELECT AVG(duracion) FROM Rutina;
SELECT COUNT(*) FROM Usuario;
SELECT CONCAT(nombre, ' - ', correo) FROM Usuario;
SELECT UPPER(nombre) FROM Entrenador;
SELECT LOWER(nombre) FROM Gimnasio;
SELECT ROUND(AVG(salario), 0) FROM Entrenador;
SELECT LEFT(nombre, 4) FROM Rutina;

-- 10. PROCEDIMIENTO
CREATE PROCEDURE ClasesPorEntrenador
@ID INT
AS
BEGIN
    SELECT id_clase, fecha FROM Clase WHERE id_entrenador = @ID;
END;

-- 11. TRUNCATE
TRUNCATE TABLE Clase_Rutina;
TRUNCATE TABLE Clase;
TRUNCATE TABLE Usuario;

-- 12. DROP TABLE
DROP TABLE IF EXISTS Clase_Rutina;
DROP TABLE IF EXISTS Clase;
DROP TABLE IF EXISTS Usuario;

-- 13. DROP DATABASE
DROP DATABASE IF EXISTS CentroDeportiva;
