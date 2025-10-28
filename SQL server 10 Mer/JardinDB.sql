CREATE DATABASE JardinDB;
GO
USE JardinDB;
GO
CREATE TABLE Estudiantes (
    idEstudiante INT PRIMARY KEY,
    nombre VARCHAR(20),
    correo VARCHAR(30),
    ciudad VARCHAR(20),
    telefono VARCHAR(15)
);

CREATE TABLE Profesores (
    idProfesor INT PRIMARY KEY,
    nombre VARCHAR(20),
    especialidad VARCHAR(20)
);

CREATE TABLE Actividades (
    idActividad INT PRIMARY KEY,
    nombre VARCHAR(20),
    descripcion VARCHAR(50),
    cupos INT NOT NULL
);

CREATE TABLE Clases (
    idClase INT PRIMARY KEY,
    fecha DATE,
    idEstudiante INT,
    idProfesor INT,
    FOREIGN KEY (idEstudiante) REFERENCES Estudiantes(idEstudiante),
    FOREIGN KEY (idProfesor) REFERENCES Profesores(idProfesor)
);

CREATE TABLE Materiales (
    idMaterial INT PRIMARY KEY,
    nombre VARCHAR(20),
    cantidad INT
);

CREATE TABLE Clase_Actividad (
    idClase INT,
    idActividad INT,
    PRIMARY KEY(idClase, idActividad),
    FOREIGN KEY (idClase) REFERENCES Clases(idClase),
    FOREIGN KEY (idActividad) REFERENCES Actividades(idActividad)
);

CREATE TABLE Actividad_Material (
    idActividad INT,
    idMaterial INT,
    PRIMARY KEY(idActividad, idMaterial),
    FOREIGN KEY (idActividad) REFERENCES Actividades(idActividad),
    FOREIGN KEY (idMaterial) REFERENCES Materiales(idMaterial)
);
INSERT INTO Estudiantes VALUES
(1,'Ana','a@correo.com','Bogotá','3001'),(2,'Luis','l@correo.com','castilla','3002'),
(3,'Mia','m@correo.com','Neiva','3003'),(4,'Leo','leo@correo.com','Tolima','3004'),
(5,'Sofi','s@correo.com','Cali','3005'),(6,'Max','max@correo.com','Medellín','3006'),(7,'Eva','eva@correo.com','Bogotá','3007'),
(8,'Ian','ian@correo.com','Guamo','3008'),(9,'Luz','luz@correo.com','Medellín','3009'),(10,'Tom','tom@correo.com','Melgar','3010');


INSERT INTO Profesores VALUES
(1,'Profe Ana','Música'),(2,'Profe Luis','Arte'),(3,'Profe Mia','Matemáticas'),(4,'Profe Leo','Educación Física'),(5,'Profe Sofi','Lenguaje'),
(6,'Profe Max','Ciencias'),(7,'Profe Eva','Música'),(8,'Profe Ian','Arte'),(9,'Profe Luz','Matemáticas'),(10,'Profe Tom','Ciencias');

INSERT INTO Actividades VALUES
(1,'Pintura','Actividad',10),(2,'Canciones','Aprender ',8),
(3,'Matemáticas','Sumas y restas',12),(4,'Lectura','Leer',15),(5,'Dibujo','Dibujos ',10),(6,'Juego','Juegos ',20),
(7,'Ciencia','Pequeños experimentos',10),(8,'Baile','Baile creativo',8),(9,'Manualidad','manualidades',12),(10,'Yoga',' relajación',15);


INSERT INTO Materiales VALUES
(1,'Papel',100),(2,'Crayones',50),(3,'Tijeras',20),(4,'Pegamento',30),
(5,'Cuerda',15),(6,'Balones',10),(7,'Pintura',25),(8,'Libros',40),(9,'Figuras',15),(10,'Colchon',10);


INSERT INTO Clases VALUES
(1,'2025-01-10',1,1),(2,'2025-02-12',2,2),(3,'2025-03-15',3,3),(4,'2025-04-20',4,4),(5,'2025-05-05',5,5),
(6,'2025-06-25',6,6),(7,'2025-07-30',7,7),(8,'2025-08-18',8,8),(9,'2025-09-22',9,9),(10,'2025-10-01',10,10);

-- Clase_Actividad
INSERT INTO Clase_Actividad VALUES
(1,1),(1,2),(2,3),(3,4),(4,5),
(5,6),(6,7),(7,8),(8,9),(9,10);

-- Actividad_Material
INSERT INTO Actividad_Material VALUES
(1,1),(2,2),(3,3),(4,4),(5,5),
(6,6),(7,7),(8,8),(9,9),(10,10);

DROP VIEW IF EXISTS V_EstudiantesClases;
GO
CREATE VIEW V_EstudiantesClases AS
SELECT e.idEstudiante, e.nombre, c.idClase, c.fecha
FROM Estudiantes e
JOIN Clases c ON e.idEstudiante = c.idEstudiante;
GO

DROP VIEW IF EXISTS V_ActividadesMateriales;
GO
CREATE VIEW V_ActividadesMateriales AS
SELECT a.idActividad, a.nombre AS Actividad, m.nombre AS Material
FROM Actividades a
JOIN Actividad_Material am ON a.idActividad = am.idActividad
JOIN Materiales m ON m.idMaterial = am.idMaterial;
GO

DROP VIEW IF EXISTS V_ProfesoresClases;
GO
CREATE VIEW V_ProfesoresClases AS
SELECT p.idProfesor, p.nombre AS Profesor, c.idClase, c.fecha
FROM Profesores p
JOIN Clases c ON p.idProfesor = c.idProfesor;
GO

DROP VIEW IF EXISTS V_ActividadesCupos;
GO
CREATE VIEW V_ActividadesCupos AS
SELECT nombre, cupos
FROM Actividades
WHERE cupos > (SELECT AVG(cupos) FROM Actividades);
GO

DROP VIEW IF EXISTS V_EstudiantesCiudad;
GO
CREATE VIEW V_EstudiantesCiudad AS
SELECT ciudad, COUNT(*) AS TotalEstudiantes
FROM Estudiantes
GROUP BY ciudad;
GO

IF OBJECT_ID('AuditoriaGeneral','U') IS NOT NULL
    DROP TABLE AuditoriaGeneral;
GO

CREATE TABLE AuditoriaGeneral (
    idAuditoria INT IDENTITY(1,1) PRIMARY KEY,
    tabla VARCHAR(100),
    operacion VARCHAR(10),
    id_registro INT,
    datos_previos NVARCHAR(MAX),
    datos_nuevos NVARCHAR(MAX),
    fechaCambio DATETIME DEFAULT GETDATE(),
    usuarioSistema NVARCHAR(100) DEFAULT SUSER_SNAME()
);
GO

IF OBJECT_ID('trg_auditoria_estudiantes','TR') IS NOT NULL
    DROP TRIGGER trg_auditoria_estudiantes;
GO

CREATE TRIGGER trg_auditoria_estudiantes
ON Estudiantes
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- INSERT
    INSERT INTO AuditoriaGeneral(tabla, operacion, id_registro, datos_nuevos, usuarioSistema)
    SELECT 'Estudiantes','INSERT',i.idEstudiante,(SELECT * FROM inserted i FOR JSON AUTO),SUSER_SNAME() 
    FROM inserted i;

    -- DELETE
    INSERT INTO AuditoriaGeneral(tabla, operacion, id_registro, datos_previos, usuarioSistema)
    SELECT 'Estudiantes','DELETE',d.idEstudiante,(SELECT * FROM deleted d FOR JSON AUTO),SUSER_SNAME() 
    FROM deleted d;

    -- UPDATE
    INSERT INTO AuditoriaGeneral(tabla, operacion, id_registro, datos_previos, datos_nuevos, usuarioSistema)
    SELECT 'Estudiantes','UPDATE',d.idEstudiante,(SELECT * FROM deleted d FOR JSON AUTO),(SELECT * FROM inserted i FOR JSON AUTO),SUSER_SNAME()
    FROM deleted d 
    JOIN inserted i ON d.idEstudiante=i.idEstudiante;
END;
GO

IF OBJECT_ID('trg_auditoria_profesores','TR') IS NOT NULL
    DROP TRIGGER trg_auditoria_profesores;
GO

CREATE TRIGGER trg_auditoria_profesores
ON Profesores
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO AuditoriaGeneral(tabla, operacion, id_registro, datos_nuevos, usuarioSistema)
    SELECT 'Profesores','INSERT',i.idProfesor,(SELECT * FROM inserted i FOR JSON AUTO),SUSER_SNAME() FROM inserted i;

    INSERT INTO AuditoriaGeneral(tabla, operacion, id_registro, datos_previos, usuarioSistema)
    SELECT 'Profesores','DELETE',d.idProfesor,(SELECT * FROM deleted d FOR JSON AUTO),SUSER_SNAME() FROM deleted d;

    INSERT INTO AuditoriaGeneral(tabla, operacion, id_registro, datos_previos, datos_nuevos, usuarioSistema)
    SELECT 'Profesores','UPDATE',d.idProfesor,(SELECT * FROM deleted d FOR JSON AUTO),(SELECT * FROM inserted i FOR JSON AUTO),SUSER_SNAME()
    FROM deleted d JOIN inserted i ON d.idProfesor=i.idProfesor;
END;
GO

IF OBJECT_ID('trg_auditoria_actividades','TR') IS NOT NULL
    DROP TRIGGER trg_auditoria_actividades;
GO

CREATE TRIGGER trg_auditoria_actividades
ON Actividades
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO AuditoriaGeneral(tabla, operacion, id_registro, datos_nuevos, usuarioSistema)
    SELECT 'Actividades','INSERT',i.idActividad,(SELECT * FROM inserted i FOR JSON AUTO),SUSER_SNAME() FROM inserted i;

    INSERT INTO AuditoriaGeneral(tabla, operacion, id_registro, datos_previos, usuarioSistema)
    SELECT 'Actividades','DELETE',d.idActividad,(SELECT * FROM deleted d FOR JSON AUTO),SUSER_SNAME() FROM deleted d;

    INSERT INTO AuditoriaGeneral(tabla, operacion, id_registro, datos_previos, datos_nuevos, usuarioSistema)
    SELECT 'Actividades','UPDATE',d.idActividad,(SELECT * FROM deleted d FOR JSON AUTO),(SELECT * FROM inserted i FOR JSON AUTO),SUSER_SNAME()
    FROM deleted d JOIN inserted i ON d.idActividad=i.idActividad;
END;
GO

IF OBJECT_ID('trg_auditoria_materiales','TR') IS NOT NULL
    DROP TRIGGER trg_auditoria_materiales;
GO

CREATE TRIGGER trg_auditoria_materiales
ON Materiales
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO AuditoriaGeneral(tabla, operacion, id_registro, datos_nuevos, usuarioSistema)
    SELECT 'Materiales','INSERT',i.idMaterial,(SELECT * FROM inserted i FOR JSON AUTO),SUSER_SNAME() FROM inserted i;

    INSERT INTO AuditoriaGeneral(tabla, operacion, id_registro, datos_previos, usuarioSistema)
    SELECT 'Materiales','DELETE',d.idMaterial,(SELECT * FROM deleted d FOR JSON AUTO),SUSER_SNAME() FROM deleted d;

    INSERT INTO AuditoriaGeneral(tabla, operacion, id_registro, datos_previos, datos_nuevos, usuarioSistema)
    SELECT 'Materiales','UPDATE',d.idMaterial,(SELECT * FROM deleted d FOR JSON AUTO),(SELECT * FROM inserted i FOR JSON AUTO),SUSER_SNAME()
    FROM deleted d JOIN inserted i ON d.idMaterial=i.idMaterial;
END;
GO

IF OBJECT_ID('trg_auditoria_clases','TR') IS NOT NULL
    DROP TRIGGER trg_auditoria_clases;
GO

CREATE TRIGGER trg_auditoria_clases
ON Clases
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO AuditoriaGeneral(tabla, operacion, id_registro, datos_nuevos, usuarioSistema)
    SELECT 'Clases','INSERT',i.idClase,(SELECT * FROM inserted i FOR JSON AUTO),SUSER_SNAME() FROM inserted i;

    INSERT INTO AuditoriaGeneral(tabla, operacion, id_registro, datos_previos, usuarioSistema)
    SELECT 'Clases','DELETE',d.idClase,(SELECT * FROM deleted d FOR JSON AUTO),SUSER_SNAME() FROM deleted d;

    INSERT INTO AuditoriaGeneral(tabla, operacion, id_registro, datos_previos, datos_nuevos, usuarioSistema)
    SELECT 'Clases','UPDATE',d.idClase,(SELECT * FROM deleted d FOR JSON AUTO),(SELECT * FROM inserted i FOR JSON AUTO),SUSER_SNAME()
    FROM deleted d JOIN inserted i ON d.idClase=i.idClase;
END;
GO

IF OBJECT_ID('trg_auditoria_clase_actividad','TR') IS NOT NULL
    DROP TRIGGER trg_auditoria_clase_actividad;
GO

CREATE TRIGGER trg_auditoria_clase_actividad
ON Clase_Actividad
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO AuditoriaGeneral(tabla, operacion, id_registro, datos_nuevos, usuarioSistema)
    SELECT 'Clase_Actividad','INSERT',i.idClase,(SELECT * FROM inserted i FOR JSON AUTO),SUSER_SNAME() FROM inserted i;

    INSERT INTO AuditoriaGeneral(tabla, operacion, id_registro, datos_previos, usuarioSistema)
    SELECT 'Clase_Actividad','DELETE',d.idClase,(SELECT * FROM deleted d FOR JSON AUTO),SUSER_SNAME() FROM deleted d;

    INSERT INTO AuditoriaGeneral(tabla, operacion, id_registro, datos_previos, datos_nuevos, usuarioSistema)
    SELECT 'Clase_Actividad','UPDATE',d.idClase,(SELECT * FROM deleted d FOR JSON AUTO),(SELECT * FROM inserted i FOR JSON AUTO),SUSER_SNAME()
    FROM deleted d JOIN inserted i ON d.idClase=i.idClase;
END;
GO


-- Este índice organiza a los estudiantes por ciudad.
-- Sirve para buscar más rápido los que viven en una ciudad específica.
CREATE NONCLUSTERED INDEX idx_estudiantes_ciudad
ON Estudiantes(ciudad);
GO

-- ver estudiantes de Medellín
SELECT * 
FROM Estudiantes
WHERE ciudad = 'Medellín';
GO


Este índice organiza a los profesores según su especialidad.
-- Hace más rápidas las búsquedas de profesores por materia.
CREATE NONCLUSTERED INDEX idx_profesores_especialidad
ON Profesores(especialidad);
GO

-- ver profesores de Arte
SELECT * 
FROM Profesores
WHERE especialidad = 'Arte';
GO


-- Este índice organiza las actividades por la cantidad de cupos.
-- Es útil cuando se buscan actividades con cierto número de cupos.
CREATE NONCLUSTERED INDEX idx_actividades_cupos
ON Actividades(cupos);
GO

-- Ejemplo: ver actividades con 10 cupos
SELECT * FROM Actividades WHERE cupos = 10; GO