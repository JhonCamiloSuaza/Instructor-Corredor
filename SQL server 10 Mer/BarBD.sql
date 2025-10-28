CREATE DATABASE BarDB;
USE BarDB;


CREATE TABLE Clientes (
    idCliente INT PRIMARY KEY,
    nombre VARCHAR(10),
    correo VARCHAR(20),
    ciudad VARCHAR(10),
    telefono VARCHAR(10)
);

CREATE TABLE Empleados (
    idEmpleado INT PRIMARY KEY,
    nombre VARCHAR(10),
    cargo VARCHAR(10)
);

CREATE TABLE Bebidas (
    idBebida INT PRIMARY KEY,
    nombre VARCHAR(10),
    tipo VARCHAR(10),
    precio DECIMAL(5,2)
);

CREATE TABLE Pedidos (
    idPedido INT PRIMARY KEY,
    fecha DATE,
    idCliente INT,
    idEmpleado INT,
    FOREIGN KEY (idCliente) REFERENCES Clientes(idCliente),
    FOREIGN KEY (idEmpleado) REFERENCES Empleados(idEmpleado)
);

CREATE TABLE Snacks (
    idSnack INT PRIMARY KEY,
    nombre VARCHAR(10),
    cantidad INT
);

CREATE TABLE Pedido_Bebida (
    idPedido INT,
    idBebida INT,
    PRIMARY KEY(idPedido, idBebida),
    FOREIGN KEY (idPedido) REFERENCES Pedidos(idPedido),
    FOREIGN KEY (idBebida) REFERENCES Bebidas(idBebida)
);

CREATE TABLE Bebida_Snack (
    idBebida INT,
    idSnack INT,
    PRIMARY KEY(idBebida, idSnack),
    FOREIGN KEY (idBebida) REFERENCES Bebidas(idBebida),
    FOREIGN KEY (idSnack) REFERENCES Snacks(idSnack)
);

INSERT INTO Clientes VALUES
(1,'Ana','a@bar.com','Bog','3101'),(2,'Luis','l@bar.com','Med','3102'),
(3,'Mia','m@bar.com','Cali','3103'),(4,'Leo','l@bar.com','Nei','3104'),(5,'Sofi','s@bar.com','Cart','3105'),(6,'Max','m@bar.com','Bog','3106'),
(7,'Eva','e@bar.com','Per','3107'),(8,'Ian','i@bar.com','Man','3108'),(9,'Luz','lz@bar.com','Buc','3109'),(10,'Tom','t@bar.com','Smt','3110');

INSERT INTO Empleados VALUES
(1,'Car','Mesero'),(2,'Mar','Bart'),(3,'Ped','Coci'),(4,'Lau','Mesero'),(5,'And','Coci'),
(6,'Val','Mesero'),(7,'Dan','Seg'),(8,'Pau','Bart'),(9,'San','Coci'),(10,'Cam','Mesero');

INSERT INTO Bebidas VALUES
(1,'Cerveza','Alc',5.5),(2,'Vino','Alc',7),(3,'Jugo','NoAl',3.5),(4,'Agua','NoAl',2),(5,'Gaseosa','NoAl',2.5),(6,'Whisky','Alc',8),
(7,'Tequila','Alc',7.5),(8,'Cafe','NoAl',3),(9,'Refres','NoAl',2.5),(10,'Coctel','Alc',6);

INSERT INTO Snacks VALUES
(1,'Papas',100),(2,'Nachos',80),(3,'Alitas',60),(4,'Pizza',40),(5,'Hamb',30),
(6,'Sand',25),(7,'Queso',20),(8,'Churros',15),(9,'Ensal',10),(10,'Fruta',50);

INSERT INTO Pedidos VALUES
(1,'2025-01-10',1,1),(2,'2025-02-12',2,2),(3,'2025-03-15',3,3),(4,'2025-04-20',4,4),(5,'2025-05-05',5,5),
(6,'2025-06-25',6,6),(7,'2025-07-30',7,7),(8,'2025-08-18',8,8),(9,'2025-09-22',9,9),(10,'2025-10-01',10,10);

INSERT INTO Pedido_Bebida VALUES
(1,1),(1,2),(2,3),(3,4),(4,5),(5,6),(6,7),(7,8),(8,9),(9,10);

INSERT INTO Bebida_Snack VALUES
(1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10);

CREATE VIEW V_ClientesPedidos AS
SELECT c.idCliente,c.nombre,p.idPedido
FROM Clientes c JOIN Pedidos p ON c.idCliente=p.idCliente;
GO

CREATE VIEW V_EmpleadosPedidos AS
SELECT e.idEmpleado,e.nombre,p.idPedido
FROM Empleados e JOIN Pedidos p ON e.idEmpleado=p.idEmpleado;
GO

CREATE VIEW V_BebidasSnacks AS
SELECT b.idBebida,b.nombre AS Bebida,s.nombre AS Snack
FROM Bebidas b JOIN Bebida_Snack bs ON b.idBebida=bs.idBebida
JOIN Snacks s ON s.idSnack=bs.idSnack;
GO

CREATE VIEW V_BebidasBaratas AS
SELECT nombre,precio FROM Bebidas WHERE precio<5;
GO

CREATE VIEW V_ClientesCiudad AS
SELECT ciudad, COUNT(*) AS TotalClientes
FROM Clientes GROUP BY ciudad;
GO


CREATE TRIGGER trg_auditoria_clientes
ON Clientes
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    INSERT INTO AuditoriaBar(tabla, operacion, id_registro, datos_previos, datos_nuevos)
    SELECT 'Clientes',
           CASE WHEN EXISTS(SELECT * FROM inserted) AND EXISTS(SELECT * FROM deleted) THEN 'UPDATE'
                WHEN EXISTS(SELECT * FROM inserted) THEN 'INSERT'
                ELSE 'DELETE' END,
           COALESCE(i.idCliente,d.idCliente),
           (SELECT * FROM deleted FOR JSON AUTO),
           (SELECT * FROM inserted FOR JSON AUTO)
    FROM inserted i FULL OUTER JOIN deleted d ON i.idCliente=d.idCliente;
END;
GO

CREATE TRIGGER trg_auditoria_empleados
ON Empleados
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    INSERT INTO AuditoriaBar(tabla, operacion, id_registro, datos_previos, datos_nuevos)
    SELECT 'Empleados',
           CASE WHEN EXISTS(SELECT * FROM inserted) AND EXISTS(SELECT * FROM deleted) THEN 'UPDATE'
                WHEN EXISTS(SELECT * FROM inserted) THEN 'INSERT'
                ELSE 'DELETE' END,
           COALESCE(i.idEmpleado,d.idEmpleado),
           (SELECT * FROM deleted FOR JSON AUTO),
           (SELECT * FROM inserted FOR JSON AUTO)
    FROM inserted i FULL OUTER JOIN deleted d ON i.idEmpleado=d.idEmpleado;
END;
GO

CREATE TRIGGER trg_auditoria_bebidas
ON Bebidas
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    INSERT INTO AuditoriaBar(tabla, operacion, id_registro, datos_previos, datos_nuevos)
    SELECT 'Bebidas',
           CASE WHEN EXISTS(SELECT * FROM inserted) AND EXISTS(SELECT * FROM deleted) THEN 'UPDATE'
                WHEN EXISTS(SELECT * FROM inserted) THEN 'INSERT'
                ELSE 'DELETE' END,
           COALESCE(i.idBebida,d.idBebida),
           (SELECT * FROM deleted FOR JSON AUTO),
           (SELECT * FROM inserted FOR JSON AUTO)
    FROM inserted i FULL OUTER JOIN deleted d ON i.idBebida=d.idBebida;
END;
GO

CREATE TRIGGER trg_auditoria_pedidos
ON Pedidos
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    INSERT INTO AuditoriaBar(tabla, operacion, id_registro, datos_previos, datos_nuevos)
    SELECT 'Pedidos',
           CASE WHEN EXISTS(SELECT * FROM inserted) AND EXISTS(SELECT * FROM deleted) THEN 'UPDATE'
                WHEN EXISTS(SELECT * FROM inserted) THEN 'INSERT'
                ELSE 'DELETE' END,
           COALESCE(i.idPedido,d.idPedido),
           (SELECT * FROM deleted FOR JSON AUTO),
           (SELECT * FROM inserted FOR JSON AUTO)
    FROM inserted i FULL OUTER JOIN deleted d ON i.idPedido=d.idPedido;
END;
GO

CREATE TRIGGER trg_auditoria_snacks
ON Snacks
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    INSERT INTO AuditoriaBar(tabla, operacion, id_registro, datos_previos, datos_nuevos)
    SELECT 'Snacks',
           CASE WHEN EXISTS(SELECT * FROM inserted) AND EXISTS(SELECT * FROM deleted) THEN 'UPDATE'
                WHEN EXISTS(SELECT * FROM inserted) THEN 'INSERT'
                ELSE 'DELETE' END,
           COALESCE(i.idSnack,d.idSnack),
           (SELECT * FROM deleted FOR JSON AUTO),
           (SELECT * FROM inserted FOR JSON AUTO)
    FROM inserted i FULL OUTER JOIN deleted d ON i.idSnack=d.idSnack;
END;
GO

CREATE TRIGGER trg_auditoria_pedido_bebida
ON Pedido_Bebida
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    INSERT INTO AuditoriaBar(tabla, operacion, id_registro, datos_previos, datos_nuevos)
    SELECT 'Pedido_Bebida',
           CASE WHEN EXISTS(SELECT * FROM inserted) AND EXISTS(SELECT * FROM deleted) THEN 'UPDATE'
                WHEN EXISTS(SELECT * FROM inserted) THEN 'INSERT'
                ELSE 'DELETE' END,
           COALESCE(i.idPedido,d.idPedido),
           (SELECT * FROM deleted FOR JSON AUTO),
           (SELECT * FROM inserted FOR JSON AUTO)
    FROM inserted i FULL OUTER JOIN deleted d ON i.idPedido=d.idPedido;
END;
GO

CREATE TRIGGER trg_auditoria_bebida_snack
ON Bebida_Snack
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    INSERT INTO AuditoriaBar(tabla, operacion, id_registro, datos_previos, datos_nuevos)
    SELECT 'Bebida_Snack',
           CASE WHEN EXISTS(SELECT * FROM inserted) AND EXISTS(SELECT * FROM deleted) THEN 'UPDATE'
                WHEN EXISTS(SELECT * FROM inserted) THEN 'INSERT'
                ELSE 'DELETE' END,
           COALESCE(i.idBebida,d.idBebida),
           (SELECT * FROM deleted FOR JSON AUTO),
           (SELECT * FROM inserted FOR JSON AUTO)
    FROM inserted i FULL OUTER JOIN deleted d ON i.idBebida=d.idBebida;
END;
GO
SELECT * FROM AuditoriaBar;


--Índice para buscar clientes por ciudad
CREATE INDEX idx_Clientes_Ciudad
ON Clientes(ciudad);

-- Todos los clientes de Bogotá
SELECT * FROM Clientes
WHERE ciudad = 'Bog';

--Índice para buscar pedidos por fecha
CREATE INDEX idx_Pedidos_Fecha
ON Pedidos(fecha);

-- Todos los pedidos del 2025-01-10
SELECT * FROM Pedidos
WHERE fecha = '2025-01-10';

--Índice para buscar bebidas por tipo
CREATE INDEX idx_Bebidas_Tipo
ON Bebidas(tipo);

-- Todas las bebidas alcohólicas
SELECT * FROM Bebidas
WHERE tipo = 'Alc';