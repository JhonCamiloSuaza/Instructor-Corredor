CREATE DATABASE CineDB;
GO
USE CineDB;
GO

CREATE TABLE Clientes (
    idCliente INT PRIMARY KEY,
    nombre VARCHAR(20),
    correo VARCHAR(30),
    ciudad VARCHAR(20),
    telefono VARCHAR(15)
);

CREATE TABLE Empleados (
    idEmpleado INT PRIMARY KEY,
    nombre VARCHAR(20),
    cargo VARCHAR(20)
);

CREATE TABLE Peliculas (
    idPelicula INT PRIMARY KEY,
    titulo VARCHAR(50),
    genero VARCHAR(20),
    duracion INT 
);

CREATE TABLE Funciones (
    idFuncion INT PRIMARY KEY,
    fecha DATE,
    idCliente INT,
    idEmpleado INT,
    FOREIGN KEY (idCliente) REFERENCES Clientes(idCliente),
    FOREIGN KEY (idEmpleado) REFERENCES Empleados(idEmpleado)
);

CREATE TABLE Snacks (
    idSnack INT PRIMARY KEY,
    nombre VARCHAR(20),
    cantidad INT
);

CREATE TABLE Funcion_Pelicula (
    idFuncion INT,
    idPelicula INT,
    PRIMARY KEY(idFuncion, idPelicula),
    FOREIGN KEY (idFuncion) REFERENCES Funciones(idFuncion),
    FOREIGN KEY (idPelicula) REFERENCES Peliculas(idPelicula)
);

CREATE TABLE Pelicula_Snack (
    idPelicula INT,
    idSnack INT,
    PRIMARY KEY(idPelicula, idSnack),
    FOREIGN KEY (idPelicula) REFERENCES Peliculas(idPelicula),
    FOREIGN KEY (idSnack) REFERENCES Snacks(idSnack)
);

INSERT INTO Clientes VALUES
(1,'Ana','A@correo.com','Bogotá','3101'),(2,'Luis','l@correo.com','Medellín','3102'),
(3,'Mia','M@correo.com','Cali','3103'),(4,'Leo','L@correo.com','Neiva','3104'),
(5,'Sofi','S@correo.com','Cartagena','3105'),(6,'Max','M@correo.com','Bogotá','3106'),
(7,'Eva','E@correo.com','Pereira','3107'),(8,'Ian','I@correo.com','Manizales','3108'),
(9,'Luz','l@correo.com','Bucaramanga','3109'),(10,'Tom','T@correo.com','Santa Marta','3110');

INSERT INTO Empleados VALUES
(1,'Carlos','Cajero'),(2,'María','Taquillera'),(3,'Pedro','Proyeccionista'),(4,'Laura','Gerente'),
(5,'Andrés','Limpieza'),(6,'Valentina','Supervisor'),(7,'Daniel','Seguridad'),(8,'Paula','Cajera'),
(9,'Santiago','Proyeccionista'),(10,'Camila','Taquillera');

INSERT INTO Peliculas VALUES
(1,'Avatar 2','Ciencia',190),(2,'El Conjuro','Terror',112),
(3,'Toy Story ','Animación',100),(4,'Rápidos y Furiosos 9','Acción',145),
(5,'Coco','Animación',105),(6,'Avengers Endgame','Superhéroes',180),
(7,'Frozen 2','Animación',103),(8,'Batman','Acción',175),
(9,'Titanic','Romance',195),(10,'Jurassic World','Aventura',124);

INSERT INTO Snacks VALUES
(1,'Crispetas',200),(2,'Gaseosa',150),(3,'Perro Caliente',50),(4,'Nachos',70),
(5,'Chocolate',60),(6,'Helado',40),(7,'Agua',100),(8,'Pizza',30),(9,'Sandwich',25),(10,'Cerveza',20);

INSERT INTO Funciones VALUES
(1,'2025-01-10',1,1),(2,'2025-02-12',2,2),(3,'2025-03-15',3,3),(4,'2025-04-20',4,4),(5,'2025-05-05',5,5),
(6,'2025-06-25',6,6),(7,'2025-07-30',7,7),(8,'2025-08-18',8,8),(9,'2025-09-22',9,9),(10,'2025-10-01',10,10);

INSERT INTO Funcion_Pelicula VALUES
(1,1),(1,2),(2,3),(3,4),(4,5),
(5,6),(6,7),(7,8),(8,9),(9,10);

INSERT INTO Pelicula_Snack VALUES
(1,1),(2,2),(3,3),(4,4),(5,5),
(6,6),(7,7),(8,8),(9,9),(10,10);

DROP VIEW IF EXISTS V_ClientesFunciones;
GO
CREATE VIEW V_ClientesFunciones AS
SELECT c.idCliente, c.nombre, f.idFuncion, f.fecha
FROM Clientes c
JOIN Funciones f ON c.idCliente = f.idCliente;
GO

DROP VIEW IF EXISTS V_PeliculasSnacks;
GO
CREATE VIEW V_PeliculasSnacks AS
SELECT p.idPelicula, p.titulo AS Pelicula, s.nombre AS Snack
FROM Peliculas p
JOIN Pelicula_Snack ps ON p.idPelicula = ps.idPelicula
JOIN Snacks s ON s.idSnack = ps.idSnack;
GO

DROP VIEW IF EXISTS V_EmpleadosFunciones;
GO
CREATE VIEW V_EmpleadosFunciones AS
SELECT e.idEmpleado, e.nombre AS Empleado, f.idFuncion, f.fecha
FROM Empleados e
JOIN Funciones f ON e.idEmpleado = f.idEmpleado;
GO

DROP VIEW IF EXISTS V_PeliculasLargas;
GO
CREATE VIEW V_PeliculasLargas AS
SELECT titulo, duracion
FROM Peliculas
WHERE duracion > (SELECT AVG(duracion) FROM Peliculas);
GO

DROP VIEW IF EXISTS V_ClientesCiudad;
GO
CREATE VIEW V_ClientesCiudad AS
SELECT ciudad, COUNT(*) AS TotalClientes
FROM Clientes
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

IF OBJECT_ID('trg_auditoria_clientes','TR') IS NOT NULL
    DROP TRIGGER trg_auditoria_clientes;
GO
CREATE TRIGGER trg_auditoria_clientes
ON Clientes
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO AuditoriaGeneral(tabla, operacion, id_registro, datos_nuevos, usuarioSistema)
    SELECT 'Clientes','INSERT',i.idCliente,(SELECT * FROM inserted i FOR JSON AUTO),SUSER_SNAME() FROM inserted i;
    INSERT INTO AuditoriaGeneral(tabla, operacion, id_registro, datos_previos, usuarioSistema)
    SELECT 'Clientes','DELETE',d.idCliente,(SELECT * FROM deleted d FOR JSON AUTO),SUSER_SNAME() FROM deleted d;
    INSERT INTO AuditoriaGeneral(tabla, operacion, id_registro, datos_previos, datos_nuevos, usuarioSistema)
    SELECT 'Clientes','UPDATE',d.idCliente,(SELECT * FROM deleted d FOR JSON AUTO),(SELECT * FROM inserted i FOR JSON AUTO),SUSER_SNAME()
    FROM deleted d JOIN inserted i ON d.idCliente=i.idCliente;
END;
GO

-- Empleados
IF OBJECT_ID('trg_auditoria_empleados','TR') IS NOT NULL
    DROP TRIGGER trg_auditoria_empleados;
GO
CREATE TRIGGER trg_auditoria_empleados
ON Empleados
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO AuditoriaGeneral(tabla, operacion, id_registro, datos_nuevos, usuarioSistema)
    SELECT 'Empleados','INSERT',i.idEmpleado,(SELECT * FROM inserted i FOR JSON AUTO),SUSER_SNAME() FROM inserted i;
    INSERT INTO AuditoriaGeneral(tabla, operacion, id_registro, datos_previos, usuarioSistema)
    SELECT 'Empleados','DELETE',d.idEmpleado,(SELECT * FROM deleted d FOR JSON AUTO),SUSER_SNAME() FROM deleted d;
    INSERT INTO AuditoriaGeneral(tabla, operacion, id_registro, datos_previos, datos_nuevos, usuarioSistema)
    SELECT 'Empleados','UPDATE',d.idEmpleado,(SELECT * FROM deleted d FOR JSON AUTO),(SELECT * FROM inserted i FOR JSON AUTO),SUSER_SNAME()
    FROM deleted d JOIN inserted i ON d.idEmpleado=i.idEmpleado;
END;
GO

-- Peliculas
IF OBJECT_ID('trg_auditoria_peliculas','TR') IS NOT NULL
    DROP TRIGGER trg_auditoria_peliculas;
GO
CREATE TRIGGER trg_auditoria_peliculas
ON Peliculas
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO AuditoriaGeneral(tabla, operacion, id_registro, datos_nuevos, usuarioSistema)
    SELECT 'Peliculas','INSERT',i.idPelicula,(SELECT * FROM inserted i FOR JSON AUTO),SUSER_SNAME() FROM inserted i;
    INSERT INTO AuditoriaGeneral(tabla, operacion, id_registro, datos_previos, usuarioSistema)
    SELECT 'Peliculas','DELETE',d.idPelicula,(SELECT * FROM deleted d FOR JSON AUTO),SUSER_SNAME() FROM deleted d;
    INSERT INTO AuditoriaGeneral(tabla, operacion, id_registro, datos_previos, datos_nuevos, usuarioSistema)
    SELECT 'Peliculas','UPDATE',d.idPelicula,(SELECT * FROM deleted d FOR JSON AUTO),(SELECT * FROM inserted i FOR JSON AUTO),SUSER_SNAME()
    FROM deleted d JOIN inserted i ON d.idPelicula=i.idPelicula;
END;
GO

-- Funciones
IF OBJECT_ID('trg_auditoria_funciones','TR') IS NOT NULL
    DROP TRIGGER trg_auditoria_funciones;
GO
CREATE TRIGGER trg_auditoria_funciones
ON Funciones
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO AuditoriaGeneral(tabla, operacion, id_registro, datos_nuevos, usuarioSistema)
    SELECT 'Funciones','INSERT',i.idFuncion,(SELECT * FROM inserted i FOR JSON AUTO),SUSER_SNAME() FROM inserted i;
    INSERT INTO AuditoriaGeneral(tabla, operacion, id_registro, datos_previos, usuarioSistema)
    SELECT 'Funciones','DELETE',d.idFuncion,(SELECT * FROM deleted d FOR JSON AUTO),SUSER_SNAME() FROM deleted d;
    INSERT INTO AuditoriaGeneral(tabla, operacion, id_registro, datos_previos, datos_nuevos, usuarioSistema)
    SELECT 'Funciones','UPDATE',d.idFuncion,(SELECT * FROM deleted d FOR JSON AUTO),(SELECT * FROM inserted i FOR JSON AUTO),SUSER_SNAME()
    FROM deleted d JOIN inserted i ON d.idFuncion=i.idFuncion;
END;
GO

-- Snacks
IF OBJECT_ID('trg_auditoria_snacks','TR') IS NOT NULL
    DROP TRIGGER trg_auditoria_snacks;
GO
CREATE TRIGGER trg_auditoria_snacks
ON Snacks
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO AuditoriaGeneral(tabla, operacion, id_registro, datos_nuevos, usuarioSistema)
    SELECT 'Snacks','INSERT',i.idSnack,(SELECT * FROM inserted i FOR JSON AUTO),SUSER_SNAME() FROM inserted i;
    INSERT INTO AuditoriaGeneral(tabla, operacion, id_registro, datos_previos, usuarioSistema)
    SELECT 'Snacks','DELETE',d.idSnack,(SELECT * FROM deleted d FOR JSON AUTO),SUSER_SNAME() FROM deleted d;
    INSERT INTO AuditoriaGeneral(tabla, operacion, id_registro, datos_previos, datos_nuevos, usuarioSistema)
    SELECT 'Snacks','UPDATE',d.idSnack,(SELECT * FROM deleted d FOR JSON AUTO),(SELECT * FROM inserted i FOR JSON AUTO),SUSER_SNAME()
    FROM deleted d JOIN inserted i ON d.idSnack=i.idSnack;
END;
GO

-- Funcion_Pelicula
IF OBJECT_ID('trg_auditoria_funcion_pelicula','TR') IS NOT NULL
    DROP TRIGGER trg_auditoria_funcion_pelicula;
GO
CREATE TRIGGER trg_auditoria_funcion_pelicula
ON Funcion_Pelicula
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO AuditoriaGeneral(tabla, operacion, id_registro, datos_nuevos, usuarioSistema)
    SELECT 'Funcion_Pelicula','INSERT',i.idFuncion,(SELECT * FROM inserted i FOR JSON AUTO),SUSER_SNAME() FROM inserted i;
    INSERT INTO AuditoriaGeneral(tabla, operacion, id_registro, datos_previos, usuarioSistema)
    SELECT 'Funcion_Pelicula','DELETE',d.idFuncion,(SELECT * FROM deleted d FOR JSON AUTO),SUSER_SNAME() FROM deleted d;
    INSERT INTO AuditoriaGeneral(tabla, operacion, id_registro, datos_previos, datos_nuevos, usuarioSistema)
    SELECT 'Funcion_Pelicula','UPDATE',d.idFuncion,(SELECT * FROM deleted d FOR JSON AUTO),(SELECT * FROM inserted i FOR JSON AUTO),SUSER_SNAME()
    FROM deleted d JOIN inserted i ON d.idFuncion=i.idFuncion;
END;
GO

IF OBJECT_ID('trg_auditoria_pelicula_snack','TR') IS NOT NULL
    DROP TRIGGER trg_auditoria_pelicula_snack;
GO
CREATE TRIGGER trg_auditoria_pelicula_snack
ON Pelicula_Snack
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO AuditoriaGeneral(tabla, operacion, id_registro, datos_nuevos, usuarioSistema)
    SELECT 'Pelicula_Snack','INSERT',i.idPelicula,(SELECT * FROM inserted i FOR JSON AUTO),SUSER_SNAME() FROM inserted i;
    INSERT INTO AuditoriaGeneral(tabla, operacion, id_registro, datos_previos, usuarioSistema)
    SELECT 'Pelicula_Snack','DELETE',d.idPelicula,(SELECT * FROM deleted d FOR JSON AUTO),SUSER_SNAME() FROM deleted d;
    INSERT INTO AuditoriaGeneral(tabla, operacion, id_registro, datos_previos, datos_nuevos, usuarioSistema)
    SELECT 'Pelicula_Snack','UPDATE',d.idPelicula,(SELECT * FROM deleted d FOR JSON AUTO),(SELECT * FROM inserted i FOR JSON AUTO),SUSER_SNAME()
    FROM deleted d JOIN inserted i ON d.idPelicula=i.idPelicula;
END;
GO



-- Índice para buscar clientes por ciudad
CREATE INDEX idx_Clientes_Ciudad
ON Clientes(ciudad);

-- Seleccionar todos los clientes de Bogotá (usa idx_Clientes_Ciudad)
SELECT idCliente, nombre, correo, ciudad, telefono
FROM Clientes
WHERE ciudad = 'Bogotá';

-- Índice para buscar funciones por fecha
CREATE INDEX idx_Funciones_Fecha
ON Funciones(fecha);

-- Seleccionar todas las funciones el 2025-01-10 (usa idx_Funciones_Fecha)
SELECT idFuncion, fecha, idCliente, idEmpleado
FROM Funciones
WHERE fecha = '2025-01-10';



-- Índice para buscar películas según el snack
CREATE INDEX idx_PeliculaSnack_idSnack
ON Pelicula_Snack(idSnack);

-- Seleccionar todas las películas que tienen el snack con id 1 (usa idx_PeliculaSnack_idSnack)
SELECT ps.idPelicula, p.titulo, ps.idSnack, s.nombre AS Snack
FROM Pelicula_Snack ps
JOIN Peliculas p ON ps.idPelicula = p.idPelicula
JOIN Snacks s ON ps.idSnack = s.idSnack
WHERE ps.idSnack = 1;







