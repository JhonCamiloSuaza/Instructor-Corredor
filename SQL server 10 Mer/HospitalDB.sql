CREATE DATABASE HospitalDB;
USE HospitalDB;

CREATE TABLE Pacientes (
    idPaciente INT PRIMARY KEY,
    nombre VARCHAR(50),
    correo VARCHAR(50),
    ciudad VARCHAR(30)
);

CREATE TABLE Tratamientos (
    idTratamiento INT PRIMARY KEY,
    nombre VARCHAR(50),
    precio DECIMAL(10,2),
    stock INT
);

CREATE TABLE Medicos (
    idMedico INT PRIMARY KEY,
    nombre VARCHAR(50),
    especialidad VARCHAR(30)
);

CREATE TABLE Citas (
    idCita INT PRIMARY KEY,
    fecha DATE,
    idPaciente INT,
    idMedico INT,
    FOREIGN KEY (idPaciente) REFERENCES Pacientes(idPaciente),
    FOREIGN KEY (idMedico) REFERENCES Medicos(idMedico)
);

CREATE TABLE Proveedores (
    idProveedor INT PRIMARY KEY,
    nombre VARCHAR(50),
    telefono VARCHAR(20)
);

CREATE TABLE Cita_Tratamiento (
    idCita INT,
    idTratamiento INT,
    cantidad INT,
    PRIMARY KEY(idCita, idTratamiento),
    FOREIGN KEY (idCita) REFERENCES Citas(idCita),
    FOREIGN KEY (idTratamiento) REFERENCES Tratamientos(idTratamiento)
);

CREATE TABLE Tratamiento_Proveedor (
    idTratamiento INT,
    idProveedor INT,
    PRIMARY KEY(idTratamiento, idProveedor),
    FOREIGN KEY (idTratamiento) REFERENCES Tratamientos(idTratamiento),
    FOREIGN KEY (idProveedor) REFERENCES Proveedores(idProveedor)
);

-- INSERTS DE PACIENTES
INSERT INTO Pacientes VALUES
(1,'Carlos P','C.P@correo.com','Bogotá'),
(2,'María T','M.T@correo.com','Medellín'),
(3,'Juan G','J.G@correo.com','Cali'),
(4,'Laura R','L.R@correo.com','Tolima'),
(5,'Pedro L','P.L@correo.com','Choco'),
(6,'Sofía C','S.C@correo.com','Neiva'),
(7,'Diego M','D.M@correo.com','Bogotá'),
(8,'Valentina R','V.R@correo.com','Manizales'),
(9,'Felipe H','F.H@correo.com','Pereira'),
(10,'Camila D','C.D@correo.com','Armenia');
SELECT * FROM Pacientes;

INSERT INTO Medicos VALUES
(1,'Dr. Alejandro R','Cardiología'),
(2,'Dra. Natalia M','Pediatría'),
(3,'Dr. Jorge C','Ortopedia'),
(4,'Dra. Mariana V','Dermatología'),
(5,'Dr. Andrés L','Neurología'),
(6,'Dra. Juliana P','Ginecología'),
(7,'Dr. Ricardo S','Psiquiatría'),
(8,'Dra. Paula F','Oftalmología'),
(9,'Dr. Daniel O','Endocrinología'),
(10,'Dra. Andrea A','Medicina General');
SELECT * FROM Medicos;

INSERT INTO Tratamientos VALUES
(1,'Terapia ',12,50),
(2,'Radiografía',80,30),
(3,'Examen ',50,100),
(4,'Consulta ',70,80),
(5,'Resonancia ',30,20),
(6,'Vacunación',40,200),
(7,'Cirugía ',25,15),
(8,'Tratamiento',18,25),
(9,'Rehabilitación ',15,10),
(10,'TerapiA',90,60);
SELECT * FROM Tratamientos;

INSERT INTO Proveedores VALUES
(1,'Mediply','301'),
(2,'SaludPro','302'),
(3,'InsumosVita','303'),
(4,'BioMedic','304'),
(5,'Farmaplus','305'),
(6,'CliniExpress','306'),
(7,'VitalMedic','307'),
(8,'SuministrosSalud','308'),
(9,'MedicalPrO','309'),
(10,'Hospitec','300');
SELECT * FROM Proveedores;

INSERT INTO Citas VALUES
(1,'2025-01-10',1,1),
(2,'2025-02-12',2,2),
(3,'2025-03-15',3,3),
(4,'2025-04-20',4,4),
(5,'2025-05-05',5,5),
(6,'2025-06-25',6,6),
(7,'2025-07-30',7,7),
(8,'2025-08-18',8,8),
(9,'2025-09-22',9,9),
(10,'2025-10-01',10,10);
SELECT * FROM Citas;

INSERT INTO Cita_Tratamiento VALUES
(1,1,2),(1,2,1),(2,3,1),(3,4,2),(4,5,3),
(5,6,1),(6,7,2),(7,8,1),(8,9,3),(9,10,5);
SELECT * FROM Cita_Tratamiento;

INSERT INTO Tratamiento_Proveedor VALUES
(1,1),(2,2),(3,3),(4,4),(5,5),
(6,6),(7,7),(8,8),(9,9),(10,10);
SELECT * FROM Tratamiento_Proveedor;

UPDATE Tratamientos SET precio = 100000 WHERE idTratamiento = 2;

DELETE FROM Citas
WHERE idPaciente = 10;

DELETE FROM Pacientes
WHERE idPaciente = 10;

--: Pacientes con sus citas
SELECT p.nombre, c.idCita, c.fecha
FROM Pacientes p
JOIN Citas c ON p.idPaciente = c.idPaciente;

-- Cita con tratamientos
SELECT c.idCita, t.nombre, ct.cantidad
FROM Citas c
JOIN Cita_Tratamiento ct ON c.idCita = ct.idCita
JOIN Tratamientos t ON t.idTratamiento = ct.idTratamiento;

--  Tratamiento con su proveedor
SELECT t.nombre AS Tratamiento, prov.nombre AS Proveedor
FROM Tratamientos t
JOIN Tratamiento_Proveedor tp ON t.idTratamiento = tp.idTratamiento
JOIN Proveedores prov ON prov.idProveedor = tp.idProveedor;

-- Subconsulta  Tratamientos con precio mayor al promedio
SELECT nombre, precio
FROM Tratamientos
WHERE precio > (SELECT AVG(precio) FROM Tratamientos);

--  Pacientes que tienen citas
SELECT nombre FROM Pacientes
WHERE idPaciente IN (SELECT idPaciente FROM Citas);

--  Médicos que no son especialistas en Pediatría
SELECT nombre FROM Medicos
WHERE idMedico NOT IN (
    SELECT idMedico FROM Medicos WHERE especialidad = 'Pediatría'
);


ALTER TABLE Pacientes ADD telefono VARCHAR(20);
ALTER TABLE Tratamientos ALTER COLUMN stock INT NOT NULL;


CREATE PROCEDURE reporte_tratamientos
AS
BEGIN
    SELECT t.IdTratamiento, t.Nombre, t.Stock, t.Precio,
           ISNULL(SUM(ct.Cantidad), 0) AS TotalUsos
    FROM Tratamientos t
    LEFT JOIN Cita_Tratamiento ct ON t.IdTratamiento = ct.IdTratamiento
    GROUP BY t.IdTratamiento, t.Nombre, t.Stock, t.Precio;
END;
GO

-- Después de insertar
CREATE TRIGGER trg_after_insert_cita_tratamiento
ON Cita_Tratamiento
AFTER INSERT
AS
BEGIN
    EXEC reporte_tratamientos;
END;
GO

-- Después de actualizar
CREATE TRIGGER trg_after_update_cita_tratamiento
ON Cita_Tratamiento
AFTER UPDATE
AS
BEGIN
    EXEC reporte_tratamientos;
END;
GO

-- Después de eliminar
CREATE TRIGGER trg_after_delete_cita_tratamiento
ON Cita_Tratamiento
AFTER DELETE
AS
BEGIN
    EXEC reporte_tratamientos;
END;
GO
    -- Reporte 1: Pacientes con sus citas
    SELECT p.nombre, c.idCita 
    FROM Pacientes p 
    JOIN Citas c ON p.idPaciente = c.idPaciente;

    -- Reporte 2: Tratamientos más vendidos
    SELECT t.nombre, SUM(ct.cantidad) AS Total
    FROM Tratamientos t
    JOIN Cita_Tratamiento ct ON t.idTratamiento = ct.idTratamiento
    GROUP BY t.nombre;

    -- Reporte 3: Médicos con más citas
    SELECT m.nombre, COUNT(c.idCita) AS TotalCitas
    FROM Medicos m
    JOIN Citas c ON m.idMedico = c.idMedico
    GROUP BY m.nombre;

    -- Reporte 4: Relación tratamiento-proveedor
    SELECT t.nombre AS Tratamiento, prov.nombre AS Proveedor
    FROM Tratamientos t 
    JOIN Tratamiento_Proveedor tp ON t.idTratamiento = tp.idTratamiento
    JOIN Proveedores prov ON prov.idProveedor = tp.idProveedor;

    -- Reporte 5: Total de pacientes por ciudad
    SELECT p.ciudad, COUNT(*) AS TotalPacientes
    FROM Pacientes p
    GROUP BY p.ciudad;
END;
GO

IF OBJECT_ID('V_Pacientes','V') IS NOT NULL DROP VIEW V_Pacientes;
GO
CREATE VIEW V_Pacientes AS
SELECT idPaciente, nombre FROM Pacientes;
GO

IF OBJECT_ID('V_Tratamientos','V') IS NOT NULL DROP VIEW V_Tratamientos;
GO
CREATE VIEW V_Tratamientos AS
SELECT idTratamiento, nombre, precio FROM Tratamientos;
GO

IF OBJECT_ID('V_Citas','V') IS NOT NULL DROP VIEW V_Citas;
GO
CREATE VIEW V_Citas AS
SELECT idCita, idPaciente, fecha FROM Citas;
GO

IF OBJECT_ID('V_Proveedores','V') IS NOT NULL DROP VIEW V_Proveedores;
GO
CREATE VIEW V_Proveedores AS
SELECT idProveedor, nombre FROM Proveedores;
GO

IF OBJECT_ID('V_Medicos','V') IS NOT NULL DROP VIEW V_Medicos;
GO
CREATE VIEW V_Medicos AS
SELECT idMedico, nombre FROM Medicos;
GO

-- 2. Crear índice NO agrupado en la tabla Citas sobre la columna idMedico
--    Este índice ayuda a que las búsquedas y agrupaciones por médico sean más rápidas
CREATE NONCLUSTERED INDEX idx_citas_medico
ON Citas(idMedico);
GO

--Este índice organiza los registros de pacientes por ciudad.
-- Sirve para que las búsquedas por ciudad sean más rápidas.

CREATE NONCLUSTERED INDEX idx_pacientes_ciudad
ON Pacientes(ciudad);
GO

-- ver todos los pacientes que viven en Bogotá
SELECT * FROM Pacientes WHERE ciudad = 'Bogotá';
GO


