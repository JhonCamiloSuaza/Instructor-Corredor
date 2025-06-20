-- 1. CREAR BASE DE DATOS
CREATE DATABASE Gimnasio;
USE Gimnasio;

-- 2. CREAR TABLAS
CREATE TABLE Socio (
    id_socio INT PRIMARY KEY,
    nombre VARCHAR(50),
    edad INT,
    correo VARCHAR(100)
);

CREATE TABLE Entrenador (
    id_entrenador INT PRIMARY KEY,
    nombre VARCHAR(50),
    especialidad VARCHAR(50),
    telefono VARCHAR(20),
    salario DECIMAL(10,2)
);

CREATE TABLE Clase (
    id_clase INT PRIMARY KEY,
    nombre_clase VARCHAR(50),
    nivel VARCHAR(20),
    cupo INT,
    duracion INT
);

CREATE TABLE Equipo (
    id_equipo INT PRIMARY KEY,
    nombre_equipo VARCHAR(50),
    estado VARCHAR(20),
    capacidad INT
);

CREATE TABLE Membresia (
    id_membresia INT PRIMARY KEY,
    tipo VARCHAR(30),
    costo DECIMAL(8,2),
    duracion INT,
    fecha_inicio DATE,
    estado VARCHAR(20),
    id_socio INT,
    FOREIGN KEY (id_socio) REFERENCES Socio(id_socio)
);

CREATE TABLE Socio_Clase (
    id_socio INT,
    id_clase INT,
    asistencia INT,
    PRIMARY KEY (id_socio, id_clase),
    FOREIGN KEY (id_socio) REFERENCES Socio(id_socio),
    FOREIGN KEY (id_clase) REFERENCES Clase(id_clase)
);

CREATE TABLE Entrenador_Equipo (
    id_entrenador INT,
    id_equipo INT,
    horario VARCHAR(50),
    PRIMARY KEY (id_entrenador, id_equipo),
    FOREIGN KEY (id_entrenador) REFERENCES Entrenador(id_entrenador),
    FOREIGN KEY (id_equipo) REFERENCES Equipo(id_equipo)
);

-- 3. INSERT
INSERT INTO Socio VALUES
(1, 'Ana', 30, 'ana@mail.com'),
(2, 'Luis', 45, 'luis@mail.com'),
(3, 'Marta', 28, 'marta@mail.com'),
(4, 'Juan', 35, 'juan@mail.com'),
(5, 'Sara', 22, 'sara@mail.com');

INSERT INTO Entrenador VALUES
(1, 'Carlos', 'Pesas', '3000000000', 2000),
(2, 'Laura', 'Yoga', '3111111111', 2200),
(3, 'Leo', 'Boxeo', '3222222222', 2500),
(4, 'Cata', 'Spinning', '3333333333', 2300),
(5, 'Diego', 'Zumba', '3444444444', 2100);

INSERT INTO Clase VALUES
(1, 'Yoga', 'Basico', 20, 60),
(2, 'Spinning', 'Intermedio', 15, 50),
(3, 'Crossfit', 'Avanzado', 10, 45),
(4, 'Zumba', 'Basico', 25, 40),
(5, 'Funcional', 'Intermedio', 20, 55);

INSERT INTO Equipo VALUES
(1, 'Bicicleta', 'Activo', 10),
(2, 'Pesas', 'Activo', 8),
(3, 'Banda', 'Inactivo', 5),
(4, 'TRX', 'Activo', 6),
(5, 'Mancuernas', 'Activo', 12);

INSERT INTO Membresia VALUES
(1, 'Mensual', 80.00, 1, '2024-01-01', 'Activa', 1),
(2, 'Trimestral', 200.00, 3, '2024-02-01', 'Activa', 2),
(3, 'Semestral', 350.00, 6, '2024-03-01', 'Activa', 3),
(4, 'Anual', 600.00, 12, '2024-04-01', 'Activa', 4),
(5, 'Mensual', 90.00, 1, '2024-05-01', 'Activa', 5);

INSERT INTO Socio_Clase VALUES
(1, 1, 4), (2, 2, 3), (3, 3, 5), (4, 4, 2), (5, 5, 1);

INSERT INTO Entrenador_Equipo VALUES
(1, 2, 'Mañana'), (2, 1, 'Tarde'), (3, 3, 'Noche'), (4, 4, 'Tarde'), (5, 5, 'Mañana');

-- 4. UPDATE
UPDATE Socio SET edad = edad + 1 WHERE id_socio = 1;
UPDATE Socio SET edad = edad + 2 WHERE id_socio = 2;
UPDATE Socio SET edad = edad + 3 WHERE id_socio = 3;
UPDATE Socio SET edad = edad + 4 WHERE id_socio = 4;
UPDATE Socio SET edad = edad + 5 WHERE id_socio = 5;

-- 5. DELETE
DELETE FROM Socio_Clase WHERE id_socio = 1;
DELETE FROM Socio_Clase WHERE id_socio = 2;
DELETE FROM Socio_Clase WHERE id_socio = 3;
DELETE FROM Socio_Clase WHERE id_socio = 4;
DELETE FROM Socio_Clase WHERE id_socio = 5;

-- 6. SELECT JOIN
SELECT s.nombre, m.tipo FROM Socio s JOIN Membresia m ON s.id_socio = m.id_socio;
SELECT e.nombre, eq.nombre_equipo FROM Entrenador e JOIN Entrenador_Equipo ee ON e.id_entrenador = ee.id_entrenador JOIN Equipo eq ON ee.id_equipo = eq.id_equipo;
SELECT sc.id_socio, c.nombre_clase FROM Socio_Clase sc JOIN Clase c ON sc.id_clase = c.id_clase;
SELECT s.nombre, c.nombre_clase FROM Socio s JOIN Socio_Clase sc ON s.id_socio = sc.id_socio JOIN Clase c ON sc.id_clase = c.id_clase;
SELECT m.tipo, s.nombre FROM Membresia m JOIN Socio s ON m.id_socio = s.id_socio;

-- 7. SUBCONSULTAS
SELECT nombre FROM Socio WHERE edad > (SELECT AVG(edad) FROM Socio);
SELECT tipo FROM Membresia WHERE costo = (SELECT MAX(costo) FROM Membresia);
SELECT nombre_clase FROM Clase WHERE cupo = (SELECT MIN(cupo) FROM Clase);
SELECT nombre FROM Entrenador WHERE salario > (SELECT AVG(salario) FROM Entrenador);
SELECT nombre_equipo FROM Equipo WHERE capacidad = (SELECT MAX(capacidad) FROM Equipo);

-- 8. ALTER
ALTER TABLE Socio ADD direccion VARCHAR(100);
ALTER TABLE Entrenador ADD correo VARCHAR(100);
ALTER TABLE Clase ADD descripcion VARCHAR(100);
ALTER TABLE Equipo ADD marca VARCHAR(50);
ALTER TABLE Membresia ADD renovable BIT;

-- 9. FUNCIONES AGREGADAS
-- MAX: salario más alto
SELECT MAX(salario) AS salario_maximo FROM Entrenador;
-- MIN: menor cupo
SELECT MIN(cupo) AS menor_cupo FROM Clase;
-- SUM: total ingresos
SELECT SUM(costo) AS total_ingresos FROM Membresia;
-- AVG: promedio edad
SELECT AVG(edad) AS edad_promedio FROM Socio;
-- COUNT: entrenadores totales
SELECT COUNT(*) AS total_entrenadores FROM Entrenador;
-- CONCAT: socio nombre y correo
SELECT CONCAT(nombre, ' - ', correo) AS info FROM Socio;
-- UPPER: nombre en mayúsculas
SELECT UPPER(nombre) AS nombre_mayus FROM Entrenador;
-- LOWER: nombre de clase en minúsculas
SELECT LOWER(nombre_clase) FROM Clase;
-- ROUND: redondear duración
SELECT ROUND(AVG(duracion), 0) FROM Clase;
-- LEFT: primeras letras de equipo
SELECT LEFT(nombre_equipo, 3) FROM Equipo;

-- 10. PROCEDIMIENTO ALMACENADO
CREATE PROCEDURE EstadisticasClasesPorNivel
@NivelClase VARCHAR(20)
AS
BEGIN
    IF OBJECT_ID('tempdb..#estadisticas_clase') IS NOT NULL
        DROP TABLE #estadisticas_clase;

    CREATE TABLE #estadisticas_clase (
        nivel VARCHAR(20),
        total_clases INT,
        promedio_duracion INT,
        promedio_cupo INT
    );

    INSERT INTO #estadisticas_clase
    SELECT 
        c.nivel,
        COUNT(c.id_clase),
        AVG(c.duracion),
        AVG(c.cupo)
    FROM Clase c
    WHERE c.nivel = @NivelClase
    GROUP BY c.nivel;

    SELECT * FROM #estadisticas_clase;
END;

-- EXEC EstadisticasClasesPorNivel 'Basico';



-- 11. TRUNCATE
TRUNCATE TABLE Socio_Clase;
TRUNCATE TABLE Entrenador_Equipo;
TRUNCATE TABLE Membresia;
TRUNCATE TABLE Clase;
TRUNCATE TABLE Equipo;

-- 12. DROP TABLE (5 ejemplos)
DROP TABLE IF EXISTS Socio_Clase;
DROP TABLE IF EXISTS Entrenador_Equipo;
DROP TABLE IF EXISTS Membresia;
DROP TABLE IF EXISTS Clase;
DROP TABLE IF EXISTS Equipo;

-- 13. DROP DATABASE
DROP DATABASE IF EXISTS Gimnasio;



-- FUNCIONES AGREGADAS 
-- MAX: 1 vez
-- MIN: 1 vez
-- SUM: 1 vez
-- COUNT: 1 vez
-- CONCAT: 1 vez
-- AVG: 1 vez
-- UPPER: 1 vez
-- LOWER: 1 vez
-- ROUND: 1 vez
-- LEFT: 1 vez
