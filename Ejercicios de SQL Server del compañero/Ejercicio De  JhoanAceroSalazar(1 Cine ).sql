-- Trabajo de Johan Acero Salazar 

-- Mer 3 Cine 

-- Crear la base de datos
CREATE DATABASE Cine;

-- Usar la base de datos
USE Cine;

-- Crear tabla Películas
CREATE TABLE Peliculas (
    id_pelicula INT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    duracion INT,
    clasificacion VARCHAR(100)
);

-- Crear tabla Salas
CREATE TABLE Salas (
    id_sala INT PRIMARY KEY,
    nombre VARCHAR(50),
    capacidad INT
);

-- Crear tabla Funciones (La tabla estaba mal ordenada y le faltaban datos)
/*
CREATE TABLE Funciones (
    id_funcion INT PRIMARY KEY,
    FOREIGN KEY (id_pelicula) REFERENCES Peliculas(id_pelicula),
    FOREIGN KEY (id_sala) REFERENCES Salas(id_sala),
    fecha DATE,
    hora TIME
);
*/

-- Versión corregida de la tabla Funciones
CREATE TABLE Funciones (
    id_funcion INT PRIMARY KEY,
    id_pelicula INT,
    id_sala INT,
    fecha DATE,
    hora TIME,
    FOREIGN KEY (id_sala) REFERENCES Salas(id_sala),
    FOREIGN KEY (id_pelicula) REFERENCES Peliculas(id_pelicula)
);

-- Crear tabla Boletos
CREATE TABLE Boletos (
    id_boleto INT PRIMARY KEY,
    id_funcion INT FOREIGN KEY REFERENCES Funciones(id_funcion),
    nombre_cliente VARCHAR(100),
    asiento VARCHAR(10),
    precio DECIMAL(8,2)
);

-- Insertar datos en Películas
INSERT INTO Peliculas VALUES
(1, 'Avengers: Endgame', 181, 'Supervisión parental'),
(2, 'Joker', 122, 'Mayores a 17'),
(3, 'Toy Story 4', 100, 'Para todo público');

-- Insertar datos en Salas
INSERT INTO Salas VALUES
(101, 'Sala 1', 100),
(102, 'Sala 2', 70),
(103, 'Sala 3', 60);

-- Insertar datos en Funciones
INSERT INTO Funciones VALUES
(10, 1, 101, '2025-05-28', '18:00:00'),
(20, 2, 102, '2025-06-01', '20:30:00'),
(30, 3, 103, '2025-06-07', '16:45:00');

-- Insertar datos en Boletos
INSERT INTO Boletos VALUES
(1001, 10, 'Pedro Diaz', 'A1', 25000.00),
(1002, 30, 'Luis Gomez', 'B5', 22000.00),
(1003, 30, 'Marta Rizzi', 'F2', 30000.00),
(1004, 20, 'Valery Chavez', 'B7', 25000.00);

-- Operaciones de actualización
UPDATE Peliculas SET titulo = 'Joker: La historia'
WHERE id_pelicula = 2;

UPDATE Funciones SET hora = '19:30:00'
WHERE id_funcion = 10;

-- Consultar todas las películas
SELECT * FROM Peliculas;

-- Consultar información de funciones
SELECT id_funcion, fecha, hora FROM Funciones;

-- Consultar información detallada de funciones
SELECT F.id_funcion, P.titulo, S.nombre, F.fecha, F.hora
FROM Funciones F
JOIN Peliculas P ON F.id_pelicula = P.id_pelicula
JOIN Salas S ON F.id_sala = S.id_sala;

/* Intercambió los valores en los delete 
DELETE FROM Funciones WHERE id_funcion = 20;
DELETE FROM Salas WHERE id_sala = 103;*/

-- Operaciones de eliminación
DELETE FROM Funciones WHERE id_funcion = 103;
DELETE FROM Salas WHERE id_sala = 20;
DELETE FROM Boletos WHERE nombre_cliente = 'Marta Ruiz';

-- Agregar columna género a Películas
ALTER TABLE Peliculas ADD genero VARCHAR(50);

/* Modificar columna precio en Boletos (no se puede modificar ya que utiliza valores de (8,2) 
entonces no se puede dejar menos, solo mayor)
ALTER TABLE Boletos ALTER COLUMN precio DECIMAL(6,2);*/

ALTER TABLE Boletos ALTER COLUMN precio DECIMAL(8,2);
ALTER TABLE Boletos ALTER COLUMN asiento VARCHAR(10); -- En vez de utilizar CHANGE se utiliza ALTER porque el lenguaje de SQL es diferente

/* Se tiene que borrar solo la tabla Boletos 
porque existen otras tablas que tienen relaciones con ella a través de claves foráneas (FOREIGN KEY).
Entonces da error al ejecutar:
TRUNCATE TABLE Peliculas;
TRUNCATE TABLE Funciones;
*/
TRUNCATE TABLE Boletos;

/* Se tiene que borrar todas las tablas
porque existen otras tablas que tienen relaciones con ella a través de claves foráneas (FOREIGN KEY).
Entonces da error al ejecutar:
DROP TABLE Salas;
DROP TABLE Funciones;
*/

DROP TABLE Boletos;
DROP TABLE Funciones;
DROP TABLE Peliculas;
DROP TABLE Salas;
