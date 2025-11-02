-- ==========================================================
-- FERIA GENERAL - Script convertido a PostgreSQL (funcional)
-- Conversión desde SQL Server -> PostgreSQL (PL/pgSQL)
-- ==========================================================

-- 0) Si ya existe, eliminar y crear base de datos
DROP DATABASE IF EXISTS feriageneral;
CREATE DATABASE feriageneral;
\c feriageneral;

-- ==========================================================
-- 1) CREACIÓN DE TABLAS
-- ==========================================================
CREATE TABLE feria (
    idferia SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    ciudad VARCHAR(100),
    fechainicio DATE,
    fechafin DATE
);

CREATE TABLE tematica (
    idtematica SERIAL PRIMARY KEY,
    nombre VARCHAR(100)
);

CREATE TABLE pabellon (
    idpabellon SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    capacidad INT,
    idferia INT REFERENCES feria(idferia),
    idtematica INT REFERENCES tematica(idtematica)
);

CREATE TABLE empresa (
    idempresa SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    contacto VARCHAR(50)
);

CREATE TABLE persona (
    idpersona SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    email VARCHAR(100),
    telefono VARCHAR(50)
);

CREATE TABLE stand (
    idstand SERIAL PRIMARY KEY,
    idempresa INT REFERENCES empresa(idempresa),
    idpabellon INT REFERENCES pabellon(idpabellon),
    nombre VARCHAR(100),
    descripcion VARCHAR(200)
);

CREATE TABLE responsable (
    idresponsable SERIAL PRIMARY KEY,
    idempresa INT REFERENCES empresa(idempresa),
    idpersona INT REFERENCES persona(idpersona)
);

CREATE TABLE producto (
    idproducto SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    descripcion VARCHAR(200),
    idresponsable INT REFERENCES responsable(idresponsable),
    idstand INT REFERENCES stand(idstand)
);

CREATE TABLE tipovisitante (
    idtipovisitante SERIAL PRIMARY KEY,
    tipo VARCHAR(50)
);

CREATE TABLE visitante (
    idvisitante SERIAL PRIMARY KEY,
    idtipovisitante INT REFERENCES tipovisitante(idtipovisitante),
    idpersona INT REFERENCES persona(idpersona)
);

CREATE TABLE ponente (
    idponente SERIAL PRIMARY KEY,
    idpersona INT REFERENCES persona(idpersona)
);

CREATE TABLE charla (
    idcharla SERIAL PRIMARY KEY,
    tema VARCHAR(100),
    fecha DATE,
    hora TIME,
    idponente INT REFERENCES ponente(idponente),
    idempresa INT REFERENCES empresa(idempresa)
);

CREATE TABLE demostracion (
    iddemostracion SERIAL PRIMARY KEY,
    tema VARCHAR(150),
    fecha DATE,
    hora TIME
);

CREATE TABLE registro (
    idregistro SERIAL PRIMARY KEY,
    idvisitante INT REFERENCES visitante(idvisitante),
    idcharla INT REFERENCES charla(idcharla),
    iddemostracion INT REFERENCES demostracion(iddemostracion)
);

-- ==========================================================
-- 2) INSERTS INICIALES (valores fijos que tenías)
-- Notas: insertamos explicitamente id's; después sincronizaremos sequences.
-- ==========================================================
-- FERIAS
INSERT INTO feria (idferia, nombre, ciudad, fechainicio, fechafin) VALUES
(1, 'Feria Tecnología', 'Medellin', '2025-08-01', '2025-08-05'),
(2, 'Feria Innovación', 'Bogotá', '2025-09-01', '2025-09-05'),
(3, 'Feria Robótica', 'Cali', '2025-10-01', '2025-10-05'),
(4, 'Feria Hardware', 'Barranquilla', '2025-11-01', '2025-11-05'),
(5, 'Feria Software', 'Cartagena', '2025-12-01', '2025-12-05'),
(6, 'Feria IA', 'Medellin', '2026-01-01', '2026-01-05'),
(7, 'Feria Ciencia', 'Bogotá', '2026-02-01', '2026-02-05'),
(8, 'Feria Startups', 'Cali', '2026-03-01', '2026-03-05'),
(9, 'Feria Estudiantes', 'Medellin', '2026-04-01', '2026-04-05'),
(10, 'Feria Empresarial', 'Bogotá', '2026-05-01', '2026-05-05');

-- TEMATICAS
INSERT INTO tematica (idtematica, nombre) VALUES
(1, 'Software'),
(2, 'Hardware'),
(3, 'Robótica'),
(4, 'Inteligencia Artificial'),
(5, 'Ciberseguridad'),
(6, 'IoT'),
(7, 'Cloud Computing'),
(8, 'Realidad Virtual'),
(9, 'Blockchain'),
(10, 'Automatización');

-- PABELLONES
INSERT INTO pabellon (idpabellon, nombre, capacidad, idferia, idtematica) VALUES
(1, 'Pabellón A', 100, 1, 1),
(2, 'Pabellón B', 200, 1, 2),
(3, 'Pabellón C', 300, 2, 3),
(4, 'Pabellón D', 400, 3, 4),
(5, 'Pabellón E', 500, 4, 5),
(6, 'Pabellón F', 600, 5, 6),
(7, 'Pabellón G', 700, 6, 7),
(8, 'Pabellón H', 800, 7, 8),
(9, 'Pabellón I', 900, 8, 9),
(10, 'Pabellón J', 1000, 9, 10);

-- EMPRESAS
INSERT INTO empresa (idempresa, nombre, contacto) VALUES
(1, 'MecaniJR', 'Carlos Pérez'),
(2, 'BasePR', 'Laura Gómez'),
(3, 'RoboTT', 'Andrés Silva'),
(4, 'SoftCol', 'Pedro Ruiz'),
(5, 'InnovaTech', 'María Ríos'),
(6, 'DataAI', 'Jorge Mendoza'),
(7, 'CyberSafe', 'Luisa Pérez'),
(8, 'VRWorld', 'Andrés Torres'),
(9, 'BlockChainX', 'Sofía Morales'),
(10, 'AutoSys', 'Felipe Castro');

-- PERSONAS (no tenías datos de persona en el script original)
-- Para mantener consistencia con referencias 1..10, insertamos placeholders.
INSERT INTO persona (idpersona, nombre, apellido, email, telefono) VALUES
(1,'Carlos','Perez','carlos.perez@example.com','3000000001'),
(2,'Laura','Gomez','laura.gomez@example.com','3000000002'),
(3,'Andres','Silva','andres.silva@example.com','3000000003'),
(4,'Pedro','Ruiz','pedro.ruiz@example.com','3000000004'),
(5,'Maria','Rios','maria.rios@example.com','3000000005'),
(6,'Jorge','Mendoza','jorge.mendoza@example.com','3000000006'),
(7,'Luisa','Perez','luisa.perez@example.com','3000000007'),
(8,'Andres','Torres','andres.torres@example.com','3000000008'),
(9,'Sofia','Morales','sofia.morales@example.com','3000000009'),
(10,'Felipe','Castro','felipe.castro@example.com','3000000010');

-- STANDS
INSERT INTO stand (idstand, idempresa, idpabellon, nombre, descripcion) VALUES
(1, 1, 1, 'Stand JR', 'Proyectos mecánicos'),
(2, 2, 2, 'Stand PR', 'Bases de datos'),
(3, 3, 3, 'Stand TT', 'Robots industriales'),
(4, 4, 4, 'Stand SC', 'Soluciones empresariales'),
(5, 5, 5, 'Stand IT', 'Innovaciones tecnológicas'),
(6, 6, 6, 'Stand DA', 'Inteligencia artificial'),
(7, 7, 7, 'Stand CS', 'Ciberseguridad avanzada'),
(8, 8, 8, 'Stand VR', 'Realidad virtual'),
(9, 9, 9, 'Stand BC', 'Blockchain avanzado'),
(10, 10, 10, 'Stand AS', 'Automatización de procesos');

-- RESPONSABLES (seed inicial)
INSERT INTO responsable (idresponsable, idempresa, idpersona) VALUES
(1,1,1),(2,2,2),(3,3,3),(4,4,4),(5,5,5),
(6,6,6),(7,7,7),(8,8,8),(9,9,9),(10,10,10);

-- PRODUCTOS
INSERT INTO producto (idproducto, nombre, descripcion, idresponsable, idstand) VALUES
(1, 'Superficie JR', 'Suelo de prueba', 1, 1),
(2, 'Datos PR', 'Bases demostrativas', 2, 2),
(3, 'Robot Asistente', 'Robot tareas', 3, 3),
(4, 'SoftCol', 'Sistema empresarial', 4, 4),
(5, 'InnovaCHIP', 'Chip innovador', 5, 5),
(6, 'AI Trainer', 'Entrenador IA', 6, 6),
(7, 'CyberWall', 'Seguridad avanzada', 7, 7),
(8, 'Gaf3D', 'Gafas de realidad aumentada', 8, 8),
(9, 'DocumentacionPRO', 'Documentación avanzada', 9, 9),
(10, 'AutoBot', 'Robot automatizado', 10, 10);

-- TIPOS DE VISITANTE
INSERT INTO tipovisitante (idtipovisitante, tipo) VALUES
(1,'Estudiante'),(2,'Profesional'),(3,'Inversionista'),(4,'Docente'),(5,'Investigador'),
(6,'Empresario'),(7,'Desarrollador'),(8,'Freelancer'),(9,'Analista'),(10,'Gerente');

-- VISITANTES (seed)
INSERT INTO visitante (idvisitante, idtipovisitante, idpersona) VALUES
(1,1,1),(2,2,2),(3,3,3),(4,4,4),(5,5,5),(6,6,6),(7,7,7),(8,8,8),(9,9,9),(10,10,10);

-- PONENTES
INSERT INTO ponente (idponente, idpersona) VALUES
(1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10);

-- CHARLAS
INSERT INTO charla (idcharla, tema, fecha, hora, idponente, idempresa) VALUES
(1, 'Avances Mecánica', '2025-08-02', '10:00', 1, 1),
(2, 'Robots Avanzados', '2025-08-03', '14:00', 2, 2),
(3, 'Ciberseguridad', '2025-08-04', '09:00', 3, 3),
(4, 'Códigos en Finanzas', '2025-08-05', '11:00', 4, 4),
(5, 'IoT en Hogar', '2025-09-01', '13:00', 5, 5),
(6, 'Documentación Técnica', '2025-09-02', '15:00', 6, 6),
(7, 'Automatización Evolutiva', '2025-09-03', '16:00', 7, 7),
(8, 'Gestión de Procesos', '2025-09-04', '10:00', 8, 8),
(9, 'IA en Medicina', '2025-09-05', '11:00', 9, 9),
(10, 'Software Ágil', '2025-09-06', '14:00', 10, 10);

-- DEMOSTRACIONES
INSERT INTO demostracion (iddemostracion, tema, fecha, hora) VALUES
(1, 'Prueba Mecánica', '2025-08-02', '11:00'),
(2, 'Robot Simulación', '2025-08-03', '15:00'),
(3, 'Ciberseguridad', '2025-08-04', '12:00'),
(4, 'Códigos', '2025-08-05', '14:00'),
(5, 'IoT', '2025-09-01', '16:00'),
(6, 'Documentación', '2025-09-02', '17:00'),
(7, 'Automatización', '2025-09-03', '18:00'),
(8, 'Gestión', '2025-09-04', '19:00'),
(9, 'IA', '2025-09-05', '20:00'),
(10, 'Software', '2025-09-06', '21:00');

-- REGISTROS
INSERT INTO registro (idregistro, idvisitante, idcharla, iddemostracion) VALUES
(1,1,1,1),(2,2,2,2),(3,3,3,3),(4,4,4,4),(5,5,5,5),
(6,6,6,6),(7,7,7,7),(8,8,8,8),(9,9,9,9),(10,10,10,10);

-- ==========================================================
-- 3) PROCEDIMIENTOS MASIVOS (convertidos a CREATE OR REPLACE PROCEDURE)
--    Los hice permanentes y en PL/pgSQL (LANGUAGE plpgsql).
-- ==========================================================

-- FERIAS MASIVAS
CREATE OR REPLACE PROCEDURE sp_insertarferiasmasivas()
LANGUAGE plpgsql
AS $$
DECLARE
    i INT := 11;
BEGIN
    WHILE i <= 1000 LOOP
        INSERT INTO feria (idferia, nombre, ciudad, fechainicio, fechafin)
        VALUES (
            i,
            CONCAT('Feria_', i),
            CASE 
                WHEN MOD(i, 5) = 0 THEN 'Medellín'
                WHEN MOD(i, 5) = 1 THEN 'Bogotá'
                WHEN MOD(i, 5) = 2 THEN 'Cali'
                WHEN MOD(i, 5) = 3 THEN 'Barranquilla'
                ELSE 'Cartagena'
            END,
            DATE '2025-01-01' + (i * INTERVAL '1 day'),
            DATE '2025-01-01' + ((i + 3) * INTERVAL '1 day')
        );
        i := i + 1;
    END LOOP;
END;
$$;

-- TEMATICAS MASIVAS
CREATE OR REPLACE PROCEDURE sp_insertartematicasmasivas()
LANGUAGE plpgsql
AS $$
DECLARE
    i INT := 11;
BEGIN
    WHILE i <= 1000 LOOP
        INSERT INTO tematica (idtematica, nombre)
        VALUES (i, CONCAT('Tematica_', i));
        i := i + 1;
    END LOOP;
END;
$$;

-- PABELLONES MASIVOS
CREATE OR REPLACE PROCEDURE sp_insertarpabellonesmasivos()
LANGUAGE plpgsql
AS $$
DECLARE
    i INT := 11;
BEGIN
    WHILE i <= 1000 LOOP
        INSERT INTO pabellon (idpabellon, nombre, capacidad, idferia, idtematica)
        VALUES (
            i,
            CONCAT('Pabellon_', i),
            100 + i,
            ((i - 1) % 10) + 1,  -- asigna ferias existentes
            ((i - 1) % 10) + 1   -- asigna temáticas existentes
        );
        i := i + 1;
    END LOOP;
END;
$$;

-- EMPRESAS MASIVAS
CREATE OR REPLACE PROCEDURE sp_insertarempresasmasivas()
LANGUAGE plpgsql
AS $$
DECLARE
    i INT := 11;
BEGIN
    WHILE i <= 1000 LOOP
        INSERT INTO empresa (idempresa, nombre, contacto)
        VALUES (
            i,
            CONCAT('Empresa_', i),
            CONCAT('Contacto_', i)
        );
        i := i + 1;
    END LOOP;
END;
$$;

-- STANDS MASIVOS
CREATE OR REPLACE PROCEDURE sp_insertarstandsmasivos()
LANGUAGE plpgsql
AS $$
DECLARE
    i INT := 11;
BEGIN
    WHILE i <= 1000 LOOP
        INSERT INTO stand (idstand, idempresa, idpabellon, nombre, descripcion)
        VALUES (
            i,
            ((i-1)%10)+1,
            ((i-1)%10)+1,
            CONCAT('Stand_', i),
            CONCAT('Descripción stand ', i)
        );
        i := i + 1;
    END LOOP;
END;
$$;

-- RESPONSABLES MASIVOS
-- Nota: ajustado para insertar (idresponsable, idempresa, idpersona) coherente con la tabla.
CREATE OR REPLACE PROCEDURE sp_insertarresponsablesmasivos()
LANGUAGE plpgsql
AS $$
DECLARE
    i INT := 11;
BEGIN
    WHILE i <= 1000 LOOP
        INSERT INTO responsable (idresponsable, idempresa, idpersona)
        VALUES (i, ((i - 1) % 10) + 1, ((i - 1) % 10) + 1);
        i := i + 1;
    END LOOP;
END;
$$;

-- PRODUCTOS MASIVOS
CREATE OR REPLACE PROCEDURE sp_insertarproductosmasivos()
LANGUAGE plpgsql
AS $$
DECLARE
    i INT := 11;
BEGIN
    WHILE i <= 1000 LOOP
        INSERT INTO producto (idproducto, nombre, descripcion, idresponsable, idstand)
        VALUES (
            i,
            CONCAT('Producto_', i),
            CONCAT('Descripción del producto número ', i),
            ((i - 1) % 10) + 1, 
            ((i - 1) % 10) + 1
        );
        i := i + 1;
    END LOOP;
END;
$$;

-- TIPOS VISITANTE MASIVOS
CREATE OR REPLACE PROCEDURE sp_insertartipovisitantesmasivos()
LANGUAGE plpgsql
AS $$
DECLARE
    i INT := 11;
BEGIN
    WHILE i <= 1000 LOOP
        INSERT INTO tipovisitante (idtipovisitante, tipo)
        VALUES (i, CONCAT('TipoVisitante_', i));
        i := i + 1;
    END LOOP;
END;
$$;

-- VISITANTES MASIVOS
CREATE OR REPLACE PROCEDURE sp_insertarvisitantesmasivos()
LANGUAGE plpgsql
AS $$
DECLARE
    i INT := 11;
BEGIN
    WHILE i <= 1000 LOOP
        INSERT INTO visitante (idvisitante, idtipovisitante, idpersona)
        VALUES (i, ((i - 1) % 10) + 1, ((i - 1) % 10) + 1);
        i := i + 1;
    END LOOP;
END;
$$;

-- PONENTES MASIVOS
CREATE OR REPLACE PROCEDURE sp_insertarpontentesmasivos()
LANGUAGE plpgsql
AS $$
DECLARE
    i INT := 11;
BEGIN
    WHILE i <= 1000 LOOP
        INSERT INTO ponente (idponente, idpersona)
        VALUES (i, ((i - 1) % 10) + 1);
        i := i + 1;
    END LOOP;
END;
$$;

-- CHARLAS MASIVAS
CREATE OR REPLACE PROCEDURE sp_insertarcharlasmasivas()
LANGUAGE plpgsql
AS $$
DECLARE
    i INT := 11;
BEGIN
    WHILE i <= 1000 LOOP
        INSERT INTO charla (idcharla, tema, fecha, hora, idponente, idempresa)
        VALUES (
            i,
            CONCAT('Charla_Tecnologia_', i),
            DATE '2025-08-01' + (i * INTERVAL '1 day'),
            TIME '10:00',
            ((i - 1) % 10) + 1,
            ((i - 1) % 10) + 1
        );
        i := i + 1;
    END LOOP;
END;
$$;

-- DEMOSTRACIONES MASIVAS
CREATE OR REPLACE PROCEDURE sp_insertardemostracionesmasivas()
LANGUAGE plpgsql
AS $$
DECLARE
    i INT := 11;
BEGIN
    WHILE i <= 1000 LOOP
        INSERT INTO demostracion (iddemostracion, tema, fecha, hora)
        VALUES (
            i,
            CONCAT('Demostracion_Tecnologia_', i),
            DATE '2025-08-01' + (i * INTERVAL '1 day'),
            TIME '10:00'
        );
        i := i + 1;
    END LOOP;
END;
$$;

-- REGISTROS MASIVOS
CREATE OR REPLACE PROCEDURE sp_insertarregistrosmasivos()
LANGUAGE plpgsql
AS $$
DECLARE
    i INT := 11;
BEGIN
    WHILE i <= 1000 LOOP
        INSERT INTO registro (idregistro, idvisitante, idcharla, iddemostracion)
        VALUES (
            i,
            ((i - 1) % 10) + 1,
            ((i - 1) % 10) + 1,
            ((i - 1) % 10) + 1
        );
        i := i + 1;
    END LOOP;
END;
$$;

-- ==========================================================
-- 4) SINCRONIZAR sequences (importante si usamos ids explícitos)
--Después de insertar filas con id explícito, ajustar las sequences para no chocar en futuros SERIAL inserts.
-- ==========================================================
SELECT setval(pg_get_serial_sequence('feria','idferia'), COALESCE(MAX(idferia),1)) FROM feria;
SELECT setval(pg_get_serial_sequence('tematica','idtematica'), COALESCE(MAX(idtematica),1)) FROM tematica;
SELECT setval(pg_get_serial_sequence('pabellon','idpabellon'), COALESCE(MAX(idpabellon),1)) FROM pabellon;
SELECT setval(pg_get_serial_sequence('empresa','idempresa'), COALESCE(MAX(idempresa),1)) FROM empresa;
SELECT setval(pg_get_serial_sequence('persona','idpersona'), COALESCE(MAX(idpersona),1)) FROM persona;
SELECT setval(pg_get_serial_sequence('stand','idstand'), COALESCE(MAX(idstand),1)) FROM stand;
SELECT setval(pg_get_serial_sequence('responsable','idresponsable'), COALESCE(MAX(idresponsable),1)) FROM responsable;
SELECT setval(pg_get_serial_sequence('producto','idproducto'), COALESCE(MAX(idproducto),1)) FROM producto;
SELECT setval(pg_get_serial_sequence('tipovisitante','idtipovisitante'), COALESCE(MAX(idtipovisitante),1)) FROM tipovisitante;
SELECT setval(pg_get_serial_sequence('visitante','idvisitante'), COALESCE(MAX(idvisitante),1)) FROM visitante;
SELECT setval(pg_get_serial_sequence('ponente','idponente'), COALESCE(MAX(idponente),1)) FROM ponente;
SELECT setval(pg_get_serial_sequence('charla','idcharla'), COALESCE(MAX(idcharla),1)) FROM charla;
SELECT setval(pg_get_serial_sequence('demostracion','iddemostracion'), COALESCE(MAX(iddemostracion),1)) FROM demostracion;
SELECT setval(pg_get_serial_sequence('registro','idregistro'), COALESCE(MAX(idregistro),1)) FROM registro;

-- ==========================================================
-- 5) SUBCONSULTAS / SELECTS de ejemplo (adaptadas a PostgreSQL)
-- ==========================================================

-- 1. Mostrar stands con su empresa
SELECT s.idstand, s.nombre, e.nombre AS empresa
FROM stand s
INNER JOIN empresa e ON s.idempresa = e.idempresa;

-- 2. Mostrar pabellones con sus stands
SELECT p.idpabellon, p.nombre AS pabellon, s.idstand, s.nombre AS stand
FROM pabellon p
INNER JOIN stand s ON p.idpabellon = s.idpabellon;

-- 3. Mostrar empresas con sus productos (mediante responsable)
SELECT e.idempresa, e.nombre AS empresa, pr.idproducto, pr.nombre AS producto
FROM empresa e
INNER JOIN responsable r ON e.idempresa = r.idempresa
INNER JOIN producto pr ON r.idresponsable = pr.idresponsable;

-- 4. Mostrar visitantes y las charlas a las que asistieron
SELECT v.idvisitante, per.nombre AS visitante, c.idcharla, c.tema AS charla
FROM visitante v
INNER JOIN persona per ON v.idpersona = per.idpersona
INNER JOIN registro reg ON v.idvisitante = reg.idvisitante
INNER JOIN charla c ON reg.idcharla = c.idcharla;

-- SUBCONSULTAS anidadas (ejemplos)
-- Charlas que existen en la tabla registro
SELECT tema
FROM charla
WHERE idcharla IN (
    SELECT idcharla FROM registro
);

-- Pabellones que tienen stands
SELECT nombre
FROM pabellon
WHERE idpabellon IN (
    SELECT idpabellon FROM stand
);

-- Visitantes inscritos en alguna charla (por nombre)
SELECT per.nombre
FROM visitante v
INNER JOIN persona per ON v.idpersona = per.idpersona
WHERE v.idvisitante IN (
    SELECT idvisitante FROM registro
);

-- Empresas que participaron en alguna charla (distinct)
SELECT DISTINCT e.nombre
FROM empresa e
WHERE e.idempresa IN (
    SELECT idempresa FROM charla
);

-- ==========================================================
-- 6) EJEMPLOS DE UPDATE / DELETE
-- ==========================================================
-- DELETE de ejemplo
DELETE FROM producto WHERE idproducto = 3;

-- UPDATE de ejemplo
UPDATE empresa SET nombre = 'MecaniJRR' WHERE idempresa = 1;

-- ==========================================================
-- 7) SEGURIDAD / ROLES (equivalente a lo que tenías en SQL Server)
-- ==========================================================
CREATE ROLE usuariolectura LOGIN PASSWORD 'Lectura123*';
CREATE ROLE usuarioescritura LOGIN PASSWORD 'Escritura123*';

GRANT CONNECT ON DATABASE feriageneral TO usuariolectura, usuarioescritura;
GRANT USAGE ON SCHEMA public TO usuariolectura, usuarioescritura;

GRANT SELECT ON ALL TABLES IN SCHEMA public TO usuariolectura;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO usuarioescritura;

-- Fin del script.
