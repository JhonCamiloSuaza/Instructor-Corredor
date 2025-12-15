CREATE DATABASE ZooDB;
USE ZooDB;

CREATE TABLE Visitantes (
    idVisitante INT PRIMARY KEY,
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
CREATE TABLE Animales (
    idAnimal INT PRIMARY KEY,
    nombre VARCHAR(20),
    especie VARCHAR(20),
    edad INT
);
CREATE TABLE Visitas (
    idVisita INT PRIMARY KEY,
    fecha DATE,
    idVisitante INT,
    idEmpleado INT,
    FOREIGN KEY (idVisitante) REFERENCES Visitantes(idVisitante),
    FOREIGN KEY (idEmpleado) REFERENCES Empleados(idEmpleado)
);
CREATE TABLE Snacks (
    idSnack INT PRIMARY KEY,
    nombre VARCHAR(20),
    cantidad INT
);
CREATE TABLE Visita_Animal (
    idVisita INT,
    idAnimal INT,
    PRIMARY KEY(idVisita, idAnimal),
    FOREIGN KEY (idVisita) REFERENCES Visitas(idVisita),
    FOREIGN KEY (idAnimal) REFERENCES Animales(idAnimal)
);
CREATE TABLE Animal_Snack (
    idAnimal INT,
    idSnack INT,
    PRIMARY KEY(idAnimal, idSnack),
    FOREIGN KEY (idAnimal) REFERENCES Animales(idAnimal),
    FOREIGN KEY (idSnack) REFERENCES Snacks(idSnack)
);
INSERT INTO Visitantes VALUES
(1,'Ana','A@zoo.com','Bog','3101'),(2,'Luis','l@zoo.com','Med','3102'),(3,'Mia','m@zoo.com','Cali','3103'),
(4,'Leo','l@zoo.com','Nei','3104'),(5,'Sofi','s@zoo.com','Cart','3105'),(6,'Max','m@zoo.com','Bog','3106'),(7,'Eva','e@zoo.com','Perei','3107'),
(8,'Ian','i@zoo.com','Maniz','3108'),(9,'Luz','lz@zoo.com','Buca','3109'),(10,'Tom','t@zoo.com','SMta','3110');

INSERT INTO Empleados VALUES
(1,'Carlos','Guía'),(2,'Marí','Vet'),(3,'Pedro','Cuida'),(4,'Lau','Guía'),(5,'Andrés','Cuida'),
(6,'Vale','Guía'),(7,'Daniel','Seg'),(8,'Pau','Vet'),(9,'Santi','Cuida'),(10,'Cami','Guía');

INSERT INTO Animales VALUES
(1,'Simba','León',5),(2,'Lola','Mono',3),(3,'Paco','Loro',2),(4,'Rex','Tigre',4),
(5,'Dory','Pez',1),(6,'Nemo','Pez',1),(7,'Boby','Oso',6),(8,'Milo','Jirafa',7),(9,'Coco','Cebra',4),(10,'Pingu','Ping',2);

INSERT INTO Snacks VALUES
(1,'Agua',100),(2,'Jugo',80),(3,'Gaseosa',60),(4,'Helado',40),(5,'Pizza',30),
(6,'Sandw',25),(7,'Choco',20),(8,'Nacho',15),(9,'Perro',10),(10,'Fruta',50);

INSERT INTO Visitas VALUES
(1,'2025-01-10',1,1),(2,'2025-02-12',2,2),(3,'2025-03-15',3,3),(4,'2025-04-20',4,4),(5,'2025-05-05',5,5),
(6,'2025-06-25',6,6),(7,'2025-07-30',7,7),(8,'2025-08-18',8,8),(9,'2025-09-22',9,9),(10,'2025-10-01',10,10);

INSERT INTO Visita_Animal VALUES
(1,1),(1,2),(2,3),(3,4),(4,5),(5,6),(6,7),(7,8),(8,9),(9,10);

INSERT INTO Animal_Snack VALUES
(1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10);

CREATE VIEW V_VisitantesVisitas AS
SELECT v.idVisitante, v.nombre, vis.idVisita, vis.fecha
FROM Visitantes v
JOIN Visitas vis ON v.idVisitante = vis.idVisitante;
GO
CREATE VIEW V_AnimalesSnacks AS
SELECT a.idAnimal, a.nombre AS Animal, s.nombre AS Snack
FROM Animales a
JOIN Animal_Snack an ON a.idAnimal = an.idAnimal
JOIN Snacks s ON s.idSnack = an.idSnack;
GO
CREATE VIEW V_EmpleadosVisitas AS
SELECT e.idEmpleado, e.nombre AS Empleado, vis.idVisita, vis.fecha
FROM Empleados e
JOIN Visitas vis ON e.idEmpleado = vis.idEmpleado;
GO
CREATE VIEW V_AnimalesJovenes AS
SELECT nombre, especie, edad
FROM Animales
WHERE edad < (SELECT AVG(edad) FROM Animales);
GO
CREATE VIEW V_VisitantesCiudad AS
SELECT ciudad, COUNT(*) AS TotalVisitantes
FROM Visitantes
GROUP BY ciudad;
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

CREATE TRIGGER trg_auditoria_visitantes
ON Visitantes
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO AuditoriaGeneral(tabla,operacion,id_registro,datos_nuevos,usuarioSistema)
    SELECT 'Visitantes','INSERT',i.idVisitante,(SELECT * FROM inserted i FOR JSON AUTO),SUSER_SNAME() FROM inserted i;
    INSERT INTO AuditoriaGeneral(tabla,operacion,id_registro,datos_previos,usuarioSistema)
    SELECT 'Visitantes','DELETE',d.idVisitante,(SELECT * FROM deleted d FOR JSON AUTO),SUSER_SNAME() FROM deleted d;
    INSERT INTO AuditoriaGeneral(tabla,operacion,id_registro,datos_previos,datos_nuevos,usuarioSistema)
    SELECT 'Visitantes','UPDATE',d.idVisitante,(SELECT * FROM deleted d FOR JSON AUTO),(SELECT * FROM inserted i FOR JSON AUTO),SUSER_SNAME()
    FROM deleted d JOIN inserted i ON d.idVisitante=i.idVisitante;
END;
GO

CREATE TRIGGER trg_auditoria_empleados
ON Empleados
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO AuditoriaGeneral(tabla,operacion,id_registro,datos_nuevos,usuarioSistema)
    SELECT 'Empleados','INSERT',i.idEmpleado,(SELECT * FROM inserted i FOR JSON AUTO),SUSER_SNAME() FROM inserted i;
    INSERT INTO AuditoriaGeneral(tabla,operacion,id_registro,datos_previos,usuarioSistema)
    SELECT 'Empleados','DELETE',d.idEmpleado,(SELECT * FROM deleted d FOR JSON AUTO),SUSER_SNAME() FROM deleted d;
    INSERT INTO AuditoriaGeneral(tabla,operacion,id_registro,datos_previos,datos_nuevos,usuarioSistema)
    SELECT 'Empleados','UPDATE',d.idEmpleado,(SELECT * FROM deleted d FOR JSON AUTO),(SELECT * FROM inserted i FOR JSON AUTO),SUSER_SNAME()
    FROM deleted d JOIN inserted i ON d.idEmpleado=i.idEmpleado;
END;
GO

CREATE TRIGGER trg_auditoria_animales
ON Animales
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO AuditoriaGeneral(tabla,operacion,id_registro,datos_nuevos,usuarioSistema)
    SELECT 'Animales','INSERT',i.idAnimal,(SELECT * FROM inserted i FOR JSON AUTO),SUSER_SNAME() FROM inserted i;
    INSERT INTO AuditoriaGeneral(tabla,operacion,id_registro,datos_previos,usuarioSistema)
    SELECT 'Animales','DELETE',d.idAnimal,(SELECT * FROM deleted d FOR JSON AUTO),SUSER_SNAME() FROM deleted d;
    INSERT INTO AuditoriaGeneral(tabla,operacion,id_registro,datos_previos,datos_nuevos,usuarioSistema)
    SELECT 'Animales','UPDATE',d.idAnimal,(SELECT * FROM deleted d FOR JSON AUTO),(SELECT * FROM inserted i FOR JSON AUTO),SUSER_SNAME()
    FROM deleted d JOIN inserted i ON d.idAnimal=i.idAnimal;
END;
GO

CREATE TRIGGER trg_auditoria_visitas
ON Visitas
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO AuditoriaGeneral(tabla,operacion,id_registro,datos_nuevos,usuarioSistema)
    SELECT 'Visitas','INSERT',i.idVisita,(SELECT * FROM inserted i FOR JSON AUTO),SUSER_SNAME() FROM inserted i;
    INSERT INTO AuditoriaGeneral(tabla,operacion,id_registro,datos_previos,usuarioSistema)
    SELECT 'Visitas','DELETE',d.idVisita,(SELECT * FROM deleted d FOR JSON AUTO),SUSER_SNAME() FROM deleted d;
    INSERT INTO AuditoriaGeneral(tabla,operacion,id_registro,datos_previos,datos_nuevos,usuarioSistema)
    SELECT 'Visitas','UPDATE',d.idVisita,(SELECT * FROM deleted d FOR JSON AUTO),(SELECT * FROM inserted i FOR JSON AUTO),SUSER_SNAME()
    FROM deleted d JOIN inserted i ON d.idVisita=i.idVisita;
END;
GO

CREATE TRIGGER trg_auditoria_snacks
ON Snacks
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO AuditoriaGeneral(tabla,operacion,id_registro,datos_nuevos,usuarioSistema)
    SELECT 'Snacks','INSERT',i.idSnack,(SELECT * FROM inserted i FOR JSON AUTO),SUSER_SNAME() FROM inserted i;
    INSERT INTO AuditoriaGeneral(tabla,operacion,id_registro,datos_previos,usuarioSistema)
    SELECT 'Snacks','DELETE',d.idSnack,(SELECT * FROM deleted d FOR JSON AUTO),SUSER_SNAME() FROM deleted d;
    INSERT INTO AuditoriaGeneral(tabla,operacion,id_registro,datos_previos,datos_nuevos,usuarioSistema)
    SELECT 'Snacks','UPDATE',d.idSnack,(SELECT * FROM deleted d FOR JSON AUTO),(SELECT * FROM inserted i FOR JSON AUTO),SUSER_SNAME()
    FROM deleted d JOIN inserted i ON d.idSnack=i.idSnack;
END;
GO

CREATE TRIGGER trg_auditoria_visita_animal
ON Visita_Animal
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO AuditoriaGeneral(tabla,operacion,id_registro,datos_nuevos,usuarioSistema)
    SELECT 'Visita_Animal','INSERT',i.idVisita,(SELECT * FROM inserted i FOR JSON AUTO),SUSER_SNAME() FROM inserted i;
    INSERT INTO AuditoriaGeneral(tabla,operacion,id_registro,datos_previos,usuarioSistema)
    SELECT 'Visita_Animal','DELETE',d.idVisita,(SELECT * FROM deleted d FOR JSON AUTO),SUSER_SNAME() FROM deleted d;
    INSERT INTO AuditoriaGeneral(tabla,operacion,id_registro,datos_previos,datos_nuevos,usuarioSistema)
    SELECT 'Visita_Animal','UPDATE',d.idVisita,(SELECT * FROM deleted d FOR JSON AUTO),(SELECT * FROM inserted i FOR JSON AUTO),SUSER_SNAME()
    FROM deleted d JOIN inserted i ON d.idVisita=i.idVisita;
END;
GO

CREATE TRIGGER trg_auditoria_animal_snack
ON Animal_Snack
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO AuditoriaGeneral(tabla,operacion,id_registro,datos_nuevos,usuarioSistema)
    SELECT 'Animal_Snack','INSERT',i.idAnimal,(SELECT * FROM inserted i FOR JSON AUTO),SUSER_SNAME() FROM inserted i;
    INSERT INTO AuditoriaGeneral(tabla,operacion,id_registro,datos_previos,usuarioSistema)
    SELECT 'Animal_Snack','DELETE',d.idAnimal,(SELECT * FROM deleted d FOR JSON AUTO),SUSER_SNAME() FROM deleted d;
    INSERT INTO AuditoriaGeneral(tabla,operacion,id_registro,datos_previos,datos_nuevos,usuarioSistema)
    SELECT 'Animal_Snack','UPDATE',d.idAnimal,(SELECT * FROM deleted d FOR JSON AUTO),(SELECT * FROM inserted i FOR JSON AUTO),SUSER_SNAME()
    FROM deleted d JOIN inserted i ON d.idAnimal=i.idAnimal;
END;
GO


CREATE INDEX idx_Visitantes_Ciudad
ON Visitantes(ciudad);
-- Todos los visitantes de Bogotá
SELECT * 
FROM Visitantes
WHERE ciudad = 'Bog';

CREATE INDEX idx_Visitas_Fecha
ON Visitas(fecha);
-- Todas las visitas de una fecha específica
SELECT * 
FROM Visitas
WHERE fecha = '2025-01-10';


CREATE INDEX idx_Snacks_Nombre
ON Snacks(nombre);
-- Buscar un snack por nombre
SELECT * 
FROM Snacks
WHERE nombre = 'Agua';
