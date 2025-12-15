--Crear la base de Datos

CREATE DATABASE GestionConjuntoArtistico;
USE GestionConjuntoArtistico;

-- Tabla Disciplina
CREATE TABLE Disciplina (
    id_disciplina INT PRIMARY KEY,
    nombre_disciplina VARCHAR(50) NOT NULL
);

-- Tabla Artista
CREATE TABLE Artista (
    id_artista INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) UNIQUE NOT NULL,
    edad INT NOT NULL,
    id_disciplina INT,
    FOREIGN KEY (id_disciplina) REFERENCES Disciplina(id_disciplina)
);

-- Tabla Evento
CREATE TABLE Evento (
    id_evento INT PRIMARY KEY,
    nombre_evento VARCHAR(100) NOT NULL,
    fecha DATE NOT NULL,
    lugar VARCHAR(100) NOT NULL
);

-- Tabla Pago
CREATE TABLE Pago (
    id_pago INT PRIMARY KEY,
    id_artista INT,
    monto DECIMAL(10,2) NOT NULL,
    fecha_pago DATE NOT NULL,
    FOREIGN KEY (id_artista) REFERENCES Artista(id_artista)
);

-- Tabla Beneficio
CREATE TABLE Beneficio (
    id_beneficio INT PRIMARY KEY,
    nombre_beneficio VARCHAR(100) NOT NULL,
    descripcion TEXT,
    monto DECIMAL(8,2)
);

-- Tabla pivote Artista_Evento
CREATE TABLE Artista_Evento (
    id_artista INT,
    id_evento INT,
    PRIMARY KEY (id_artista, id_evento),
    FOREIGN KEY (id_artista) REFERENCES Artista(id_artista),
    FOREIGN KEY (id_evento) REFERENCES Evento(id_evento)
);

-- Tabla pivote Artista_Beneficio
CREATE TABLE Artista_Beneficio (
    id_artista INT,
    id_beneficio INT,
    PRIMARY KEY (id_artista, id_beneficio),
    FOREIGN KEY (id_artista) REFERENCES Artista(id_artista),
    FOREIGN KEY (id_beneficio) REFERENCES Beneficio(id_beneficio)
);

-- Insertar datos en Disciplina
INSERT INTO Disciplina VALUES 
(1, 'Música'),
(2, 'Teatro'),
(3, 'Danza');

-- Insertar datos en Artista
INSERT INTO Artista VALUES 
(1, 'Luis Bravo', 'luis@arte.com', 30, 1),
(2, 'Sofía Ríos', 'sofia@arte.com', 25, 2);

-- Insertar datos en Evento
INSERT INTO Evento VALUES 
(1, 'Festival de Verano', '2025-07-10', 'Parque Central'),
(2, 'Noche de Teatro', '2025-08-20', 'Auditorio Nacional');

-- Insertar datos en Pago
INSERT INTO Pago VALUES 
(1, 1, 1200.00, '2025-06-01'),
(2, 2, 1350.00, '2025-06-02');

-- Insertar datos en Beneficio
INSERT INTO Beneficio VALUES 
(1, 'Bono Cultural', 'Apoyo económico anual', 800.00),
(2, 'Seguro de Salud', 'Cobertura médica básica', 500.00);

-- Insertar datos en Artista_Evento
INSERT INTO Artista_Evento VALUES 
(1, 1),
(2, 2);

-- Insertar datos en Artista_Beneficio
INSERT INTO Artista_Beneficio VALUES 
(1, 1),
(2, 2);

-- Actualizar edad de un artista
UPDATE Artista SET edad = 31 WHERE id_artista = 1;

-- Eliminar un artista correctamente (respetando dependencias)
DELETE FROM Artista_Evento WHERE id_artista = 2;
DELETE FROM Artista_Beneficio WHERE id_artista = 2;
DELETE FROM Pago WHERE id_artista = 2;
DELETE FROM Artista WHERE id_artista = 2;

-- Consulta con JOIN: artistas y sus eventos
SELECT 
    a.nombre AS artista,
    e.nombre_evento AS evento,
    e.fecha
FROM Artista a
JOIN Artista_Evento ae ON a.id_artista = ae.id_artista
JOIN Evento e ON ae.id_evento = e.id_evento;

-- Subconsulta: artistas con pagos mayores al promedio
-- AVG (average / promedio): calcula el valor promedio de una columna numérica
SELECT nombre FROM Artista 
WHERE id_artista IN (
    SELECT id_artista FROM Pago 
    GROUP BY id_artista
    HAVING AVG(monto) > (SELECT AVG(monto) FROM Pago)
);

-- Funciones agregadas

-- AVG (average / promedio): calcula el promedio de los montos de pago
SELECT AVG(monto) AS pago_promedio FROM Pago;

-- MAX (máximo): obtiene el valor máximo registrado en la columna monto
SELECT MAX(monto) AS pago_maximo FROM Pago;

-- MIN (mínimo): obtiene el valor mínimo registrado en la columna monto
SELECT MIN(monto) AS pago_minimo FROM Pago;

-- SUM (suma): calcula la suma total de los montos registrados
SELECT SUM(monto) AS total_pagado FROM Pago;

-- Crear vista de artistas con beneficios
CREATE VIEW Vista_Artistas_Beneficios AS
SELECT 
    a.nombre AS artista,
    b.nombre_beneficio AS beneficio,
    b.monto
FROM Artista a
JOIN Artista_Beneficio ab ON a.id_artista = ab.id_artista
JOIN Beneficio b ON ab.id_beneficio = b.id_beneficio;

-- ALTER TABLE: agregar columna teléfono al artista
ALTER TABLE Artista ADD telefono VARCHAR(20);

-- TRUNCATE: borrar pagos (solo datos)
TRUNCATE TABLE Pago;

-- Eliminación ordenada de tablas
DROP TABLE Artista_Evento;
DROP TABLE Artista_Beneficio;
DROP TABLE Pago;
DROP TABLE Beneficio;
DROP TABLE Evento;
DROP TABLE Artista;
DROP TABLE Disciplina;

-- Eliminar la base de datos
DROP DATABASE GestionConjuntoArtistico;


-- FUNCIONES AGREGADAS EN ESTE CÓDIGO (RESUMEN):

-- AVG (average / promedio): se utilizó 3 veces en el código
-- MAX (máximo): se utilizó 1 vez en el código
-- MIN (mínimo): se utilizó 1 vez en el código
-- SUM (suma): se utilizó 1 vez en el código

