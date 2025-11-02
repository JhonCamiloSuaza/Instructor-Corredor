CREATE DATABASE FeriaGeneral;
USE FeriaGeneral;

CREATE TABLE Feria (
    idFeria INT PRIMARY KEY,
    nombre VARCHAR(100),
    ciudad VARCHAR(100),
    fechaInicio DATE,
    fechaFin DATE
);

CREATE TABLE Tematica (
    idTematica INT PRIMARY KEY,
    nombre VARCHAR(100)
);

CREATE TABLE Pabellon (
    idPabellon INT PRIMARY KEY,
    nombre VARCHAR(100),
    capacidad INT,
    idFeria INT,
    idTematica INT,
    FOREIGN KEY (idFeria) REFERENCES Feria(idFeria),
    FOREIGN KEY (idTematica) REFERENCES Tematica(idTematica)
);

CREATE TABLE Empresa (
    idEmpresa INT PRIMARY KEY,
    nombre VARCHAR(100),
    contacto VARCHAR(50)
);

CREATE TABLE Persona ( 
    idPersona INT PRIMARY KEY,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    email VARCHAR(100), 
    telefono VARCHAR(50)
);

CREATE TABLE Stand (
    idStand INT PRIMARY KEY,
    idEmpresa INT,
    idPabellon INT,
    nombre VARCHAR(100),
    descripcion VARCHAR(200),
    FOREIGN KEY (idPabellon) REFERENCES Pabellon(idPabellon),
    FOREIGN KEY (idEmpresa) REFERENCES Empresa(idEmpresa)
);

CREATE TABLE Responsable (
    idResponsable INT PRIMARY KEY,
    idEmpresa INT,
    idPersona INT,
    FOREIGN KEY (idEmpresa) REFERENCES Empresa(idEmpresa),
    FOREIGN KEY (idPersona) REFERENCES Persona(idPersona)
);

CREATE TABLE Producto (
    idProducto INT PRIMARY KEY,
    nombre VARCHAR(100),
    descripcion VARCHAR(200),
    idResponsable INT,
    idStand INT,
    FOREIGN KEY (idResponsable) REFERENCES Responsable(idResponsable),
    FOREIGN KEY (idStand) REFERENCES Stand(idStand)
);

CREATE TABLE TipoVisitante (
    idTipoVisitante INT PRIMARY KEY,
    tipo VARCHAR(50)
);

CREATE TABLE Visitante (
    idVisitante INT PRIMARY KEY,
    idTipoVisitante INT,
    idPersona INT,
    FOREIGN KEY (idTipoVisitante) REFERENCES TipoVisitante(idTipoVisitante),
    FOREIGN KEY (idPersona) REFERENCES Persona(idPersona)
);

CREATE TABLE Ponente (
    idPonente INT PRIMARY KEY,
    idPersona INT,
    FOREIGN KEY (idPersona) REFERENCES Persona(idPersona)
);

CREATE TABLE Charla (
    idCharla INT PRIMARY KEY,
    tema VARCHAR(100),
    fecha DATE,
    hora TIME,
    idPonente INT,
    idEmpresa INT,
    FOREIGN KEY (idPonente) REFERENCES Ponente(idPonente),
    FOREIGN KEY (idEmpresa) REFERENCES Empresa(idEmpresa)
);

CREATE TABLE Demostracion( 
    idDemostracion INT PRIMARY KEY,
    tema VARCHAR(150),
    fecha DATE,
    hora TIME
);

CREATE TABLE Registro (
    idRegistro INT PRIMARY KEY,
    idVisitante INT,
    idCharla INT,
    idDemostracion INT,
    FOREIGN KEY (idVisitante) REFERENCES Visitante(idVisitante),
    FOREIGN KEY (idCharla) REFERENCES Charla(idCharla),
    FOREIGN KEY (idDemostracion) REFERENCES Demostracion(idDemostracion)
);


INSERT INTO Feria VALUES
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

CREATE OR ALTER PROCEDURE SP_InsertarFeriasMasivas
AS
BEGIN
    DECLARE @i INT = 11;
    WHILE @i <= 1000
    BEGIN
        INSERT INTO Feria (idFeria, nombre, ciudad, fechaInicio, fechaFin)
        VALUES (
            @i,
            CONCAT('Feria_', @i),
            CASE 
                WHEN @i % 5 = 0 THEN 'Medellín'
                WHEN @i % 5 = 1 THEN 'Bogotá'
                WHEN @i % 5 = 2 THEN 'Cali'
                WHEN @i % 5 = 3 THEN 'Barranquilla'
                ELSE 'Cartagena'
            END,
            DATEADD(DAY, @i, '2025-01-01'),
            DATEADD(DAY, @i + 3, '2025-01-01')
        );
        SET @i = @i + 1;
    END
END;
GO


INSERT INTO Tematica VALUES
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

CREATE OR ALTER PROCEDURE SP_InsertarTematicasMasivas
AS
BEGIN
    DECLARE @i INT = 11;
    WHILE @i <= 1000
    BEGIN
        INSERT INTO Tematica (idTematica, nombre)
        VALUES (@i, CONCAT('Tematica_', @i));
        SET @i = @i + 1;
    END
END;
GO

INSERT INTO Pabellon VALUES
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

CREATE OR ALTER PROCEDURE SP_InsertarPabellonesMasivos
AS
BEGIN
    DECLARE @i INT = 11;
    WHILE @i <= 1000
    BEGIN
        INSERT INTO Pabellon (idPabellon, nombre, capacidad, idFeria, idTematica)
        VALUES (
            @i,
            CONCAT('Pabellon_', @i),
            100 + @i,
            ((@i - 1) % 10) + 1,  -- asigna ferias existentes
            ((@i - 1) % 10) + 1   -- asigna temáticas existentes
        );
        SET @i = @i + 1;
    END
END;
GO


INSERT INTO Empresa VALUES
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

CREATE OR ALTER PROCEDURE SP_InsertarEmpresasMasivas
AS
BEGIN
    DECLARE @i INT = 11;
    WHILE @i <= 1000
    BEGIN
        INSERT INTO Empresa (idEmpresa, nombre, contacto)
        VALUES (
            @i,
            CONCAT('Empresa_', @i),
            CONCAT('Contacto_', @i)
        );
        SET @i = @i + 1;
    END
END;
GO


INSERT INTO Stand VALUES
(1, 1, 1, 'Stand JR', 'Proyectos mecánicos'),
(2, 2, 2, 'Stand PR', 'Bases de datos'),
(3, 3, 3, 'Stand TT', 'Robots industriales'),
(4, 4, 4, 'Stand SC', 'Soluciones Empresarial'),
(5, 5, 5, 'Stand IT', 'Innovaciones tecnológicas'),
(6, 6, 6, 'Stand DA', 'Inteligencia artificial'),
(7, 7, 7, 'Stand CS', 'Ciberseguridad avanzada'),
(8, 8, 8, 'Stand VR', 'Realidad virtual'),
(9, 9, 9, 'Stand BC', 'Documentacion SobreValorada'),
(10, 10, 10, 'Stand AS', 'Automatización procesos');
 
 CREATE OR ALTER PROCEDURE SP_InsertarStandsMasivos
AS
BEGIN
    DECLARE @i INT = 11;
    WHILE @i <= 1000
    BEGIN
        INSERT INTO Stand (idStand, idEmpresa, idPabellon, nombre, descripcion)
        VALUES (
            @i,
            ((@i-1)%10)+1,
            ((@i-1)%10)+1,
            CONCAT('Stand_', @i),
            CONCAT('Descripción stand ', @i)
        );
        SET @i = @i + 1;
    END
END;
GO




INSERT INTO Responsable VALUES
(1,1,1),(2,2,2),(3,3,3),(4,4,4),(5,5,5),
(6,6,6),(7,7,7),(8,8,8),(9,9,9),(10,10,10);

DECLARE @i INT = 11;
WHILE @i <= 1000
BEGIN
    INSERT INTO Responsable (idResponsable, idPersona, idStand)
    VALUES (@i, ((@i - 1) % 10) + 1, ((@i - 1) % 10) + 1);
    SET @i = @i + 1;
END;
GO

INSERT INTO Producto VALUES
(1, 'Superficie JR', 'Suelo de prueba', 1, 1),
(2, 'Datos PR', 'Bases demostrativas', 2, 2),
(3, 'Robot Asistente', 'Robot tareas', 3, 3),
(4, 'SoftCol ', 'Sistema empresarial', 4, 4),
(5, 'InnovaCHIP', 'Chip innovador', 5, 5),
(6, 'AI Trainer', 'Entrenador IA', 6, 6),
(7, 'CyberWall', 'Seguridad avanzada', 7, 7),
(8, ' Gaf3D', 'Gafas Realidad Aumentada', 8, 8),
(9, 'DocumentacionPRO', 'Documentacion en Nivel Top', 9, 9),
(10, 'AutoBot', 'Robot automatizado', 10, 10);

SET @i = 11;
WHILE @i <= 1000
BEGIN
    INSERT INTO Producto (idProducto, nombre, descripcion, idEmpresa, idStand)
    VALUES (
        @i,
        CONCAT('Producto_', @i),
        CONCAT('Descripción del producto número ', @i),
        ((@i - 1) % 10) + 1, 
        ((@i - 1) % 10) + 1
    );
    SET @i = @i + 1;
END;
GO


INSERT INTO TipoVisitante VALUES
(1,'Estudiante'),(2,'Profesional'),(3,'Inversionista'),(4,'Docente'),(5,'Investigador'),
(6,'Empresario'),(7,'Desarrollador'),(8,'Freelancer'),(9,'Analista'),(10,'Gerente');

SET @i = 11;
WHILE @i <= 1000
BEGIN
    INSERT INTO TipoVisitante (idTipoVisitante, nombre)
    VALUES (@i, CONCAT('TipoVisitante_', @i));
    SET @i = @i + 1;
END;
GO



INSERT INTO Visitante VALUES
(1,1,1),(2,2,2),(3,3,3),(4,4,4),(5,5,5),(6,6,6),(7,7,7),(8,8,8),(9,9,9),(10,10,10);

SET @i = 11;
WHILE @i <= 1000
BEGIN
    INSERT INTO Visitante (idVisitante, idPersona, idTipoVisitante)
    VALUES (@i, ((@i - 1) % 10) + 1, ((@i - 1) % 10) + 1);
    SET @i = @i + 1;
END;
GO


INSERT INTO Ponente VALUES
(1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10);

SET @i = 11;
WHILE @i <= 1000
BEGIN
    INSERT INTO Ponente (idPonente, idPersona)
    VALUES (@i, ((@i - 1) % 10) + 1);
    SET @i = @i + 1;
END;
GO


INSERT INTO Charla VALUES
(1, 'Avances Mecánica', '2025-08-02', '10:00', 1, 1),
(2, 'Robots Avanzados', '2025-08-03', '14:00', 2, 2),
(3, 'Ciberseguridad ', '2025-08-04', '09:00', 3, 3),
(4, 'Codigos en Finanzas', '2025-08-05', '11:00', 4, 4),
(5, 'IoT en Hogar', '2025-09-01', '13:00', 5, 5),
(6, 'Documentazacion', '2025-09-02', '15:00', 6, 6),
(7, 'Automatización Evolutiva', '2025-09-03', '16:00', 7, 7),
(8, 'Gestionar procesos', '2025-09-04', '10:00', 8, 8),
(9, 'IA en Medicina', '2025-09-05', '11:00', 9, 9),
(10, 'Software Ágil', '2025-09-06', '14:00', 10, 10);

SET @i = 11;
WHILE @i <= 1000
BEGIN
    INSERT INTO Charla (idCharla, nombre, fecha, hora, idFeria, idPonente)
    VALUES (
        @i,
        CONCAT('Charla_Tecnologia_', @i),
        DATEADD(DAY, @i, '2025-08-01'),
        '10:00',
        ((@i - 1) % 10) + 1,
        ((@i - 1) % 10) + 1
    );
    SET @i = @i + 1;
END;
GO

INSERT INTO Demostracion VALUES
(1, 'Prueba Mecánica', '2025-08-02', '11:00'),
(2, 'Robot Simulación', '2025-08-03', '15:00'),
(3, 'Ciberseguridad ', '2025-08-04', '12:00'),
(4, 'Codigos', '2025-08-05', '14:00'),
(5, 'IoT ', '2025-09-01', '16:00'),
(6, 'Documentacion', '2025-09-02', '17:00'),
(7, 'Automatización ', '2025-09-03', '18:00'),
(8, 'Gestion', '2025-09-04', '19:00'),
(9, 'IA ', '2025-09-05', '20:00'),
(10, 'Software ', '2025-09-06', '21:00');

SET @i = 11;
WHILE @i <= 1000
BEGIN
    INSERT INTO Demostracion (idDemostracion, nombre, fecha, hora)
    VALUES (
        @i,
        CONCAT('Demostracion_Tecnologia_', @i),
        DATEADD(DAY, @i, '2025-08-01'),
        '10:00'
    );
    SET @i = @i + 1;
END;
GO



INSERT INTO Registro VALUES
(1,1,1,1),(2,2,2,2),(3,3,3,3),(4,4,4,4),(5,5,5,5),
(6,6,6,6),(7,7,7,7),(8,8,8,8),(9,9,9,9),(10,10,10,10);

SET @i = 11;
WHILE @i <= 1000
BEGIN
    INSERT INTO Registro (idRegistro, idVisitante, idFeria, idDemostracion)
    VALUES (
        @i,
        ((@i - 1) % 10) + 1,
        ((@i - 1) % 10) + 1,
        ((@i - 1) % 10) + 1
    );
    SET @i = @i + 1;
END;
GO

-- 1. Mostrar stands con su empresa
SELECT s.idStand, s.nombre, e.nombre AS Empresa
FROM Stand s
INNER JOIN Empresa e ON s.idEmpresa = e.idEmpresa;

-- 2. Mostrar pabellones con sus stands
SELECT p.idPabellon, p.nombre AS Pabellon, s.idStand, s.nombre AS Stand
FROM Pabellon p
INNER JOIN Stand s ON p.idPabellon = s.idPabellon;

-- 3. Mostrar empresas con sus productos
SELECT e.idEmpresa, e.nombre AS Empresa, pr.idProducto, pr.nombre AS Producto
FROM Empresa e
INNER JOIN Responsable r ON e.idEmpresa = r.idEmpresa
INNER JOIN Producto pr ON r.idResponsable = pr.idResponsable;

-- 4. Mostrar visitantes y los eventos (charlas) a los que asistieron
SELECT v.idVisitante, p.nombre AS Visitante, c.idCharla, c.tema AS Charla
FROM Visitante v
INNER JOIN Persona p ON v.idPersona = p.idPersona
INNER JOIN Registro r ON v.idVisitante = r.idVisitante
INNER JOIN Charla c ON r.idCharla = c.idCharla;

-- SUBCONSULTAS 


-- Charlas que existen en la feria
SELECT tema
FROM Charla
WHERE idCharla IN (
    SELECT idCharla FROM Registro
);

-- Pabellones con stands
SELECT nombre
FROM Pabellon
WHERE idPabellon IN (
    SELECT idPabellon FROM Stand
);

-- Visitantes inscritos en alguna charla
SELECT p.nombre
FROM Visitante v
INNER JOIN Persona p ON v.idPersona = p.idPersona
WHERE v.idVisitante IN (
    SELECT idVisitante FROM Registro
);

-- Empresas que participan en alguna charla
SELECT DISTINCT e.nombre
FROM Empresa e
WHERE e.idEmpresa IN (
    SELECT idEmpresa FROM Charla
);

-- DELETE de ejemplo 
DELETE FROM Producto WHERE idProducto = 3;

-- UPDATE de ejemplo 
UPDATE Empresa SET nombre = 'MecaniJRR' WHERE idEmpresa = 1;


-- ======================================================
-- SEGURIDAD PARA BASE DE DATOS FERIA GENERAL
-- ======================================================
-- Este script crea:
-- 1. Logins en master (credenciales de acceso)
-- 2. Esquemas en la base FeriaGeneral
-- 3. Usuarios internos conectados a los logins
-- 4. Roles (lectura y escritura)
-- 5. Permisos sobre los esquemas
-- ======================================================

-- 1. CREACIÓN DE LOGINS EN MASTER
USE master;
GO

CREATE LOGIN UsuarioLectura WITH PASSWORD = 'Lectura123*';
CREATE LOGIN UsuarioEscritura WITH PASSWORD = 'Escritura123*';
GO

-- 2. USAR LA BASE DE DATOS FERIA GENERAL
USE FeriaGeneral;
GO

-- 3. CREACIÓN DE ESQUEMAS
CREATE SCHEMA esquemaLectura AUTHORIZATION dbo;
GO

CREATE SCHEMA esquemaEscritura AUTHORIZATION dbo;
GO

-- 4. CREACIÓN DE USUARIOS INTERNOS
-- Cada usuario de la BD se conecta con un login de master.
CREATE USER UsuarioLectura FOR LOGIN UsuarioLectura WITH DEFAULT_SCHEMA = esquemaLectura;
CREATE USER UsuarioEscritura FOR LOGIN UsuarioEscritura WITH DEFAULT_SCHEMA = esquemaEscritura;
GO

-- 5. CREACIÓN DE ROLES
CREATE ROLE RolLectura;
CREATE ROLE RolEscritura;
GO

-- 6. ASIGNACIÓN DE PERMISOS A LOS ROLES
-- RolLectura → solo puede consultar (SELECT)
GRANT SELECT ON SCHEMA::dbo TO RolLectura;
GRANT SELECT ON SCHEMA::esquemaLectura TO RolLectura;
GRANT SELECT ON SCHEMA::esquemaEscritura TO RolLectura;

-- RolEscritura → puede consultar y modificar (INSERT, UPDATE, DELETE)
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::dbo TO RolEscritura;
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::esquemaEscritura TO RolEscritura;
GO

-- 7. CONEXIÓN DE USUARIOS A ROLES
ALTER ROLE RolLectura ADD MEMBER UsuarioLectura;
ALTER ROLE RolEscritura ADD MEMBER UsuarioEscritura;
GO