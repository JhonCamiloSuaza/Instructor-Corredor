CREATE DATABASE HeladeriaDB;
USE HeladeriaDB;

CREATE TABLE Clientes (
    idCliente INT PRIMARY KEY,
    nombre VARCHAR(5),
    correo VARCHAR(10),
    ciudad VARCHAR(5),
    telefono VARCHAR(5)
);

CREATE TABLE Empleados (
    idEmpleado INT PRIMARY KEY,
    nombre VARCHAR(5),
    cargo VARCHAR(5)
);

CREATE TABLE Helados (
    idHelado INT PRIMARY KEY,
    nombre VARCHAR(5),
    sabor VARCHAR(5),
    precio DECIMAL(4,2)
);

CREATE TABLE Pedidos (
    idPedido INT PRIMARY KEY,
    fecha DATE,
    idCliente INT,
    idEmpleado INT,
    FOREIGN KEY (idCliente) REFERENCES Clientes(idCliente),
    FOREIGN KEY (idEmpleado) REFERENCES Empleados(idEmpleado)
);

CREATE TABLE Toppings (
    idTopping INT PRIMARY KEY,
    nombre VARCHAR(5),
    cantidad INT
);

CREATE TABLE Pedido_Helado (
    idPedido INT,
    idHelado INT,
    PRIMARY KEY(idPedido, idHelado),
    FOREIGN KEY (idPedido) REFERENCES Pedidos(idPedido),
    FOREIGN KEY (idHelado) REFERENCES Helados(idHelado)
);

CREATE TABLE Helado_Topping (
    idHelado INT,
    idTopping INT,
    PRIMARY KEY(idHelado, idTopping),
    FOREIGN KEY (idHelado) REFERENCES Helados(idHelado),
    FOREIGN KEY (idTopping) REFERENCES Toppings(idTopping)
);

INSERT INTO Clientes VALUES
(1,'A','a@h.c','B','101'),(2,'B','b@h.c','M','102'),(3,'C','c@h.c','C','103'),(4,'D','d@h.c','N','104'),(5,'E','e@h.c','Ct','105'),(6,'F','f@h.c','B','106'),(7,'G','g@h.c','P','107'),(8,'H','h@h.c','M','108'),
(9,'I','i@h.c','B','109'),(10,'J','j@h.c','S','110');

INSERT INTO Empleados VALUES
(1,'Al','Vend'),(2,'Be','Coc'),(3,'Ce','Vnd'),(4,'Di','Coc'),(5,'El','Vnd'),(6,'Fo','Coc'),(7,'Gu','Seg'),(8,'Hi','Vnd'),(9,'Ia','Coc'),(10,'Jo','Vnd');

INSERT INTO Helados VALUES
(1,'Vn','Van',3),(2,'Ch','Cho',4),(3,'Fs','Fre',3),(4,'Mt','Men',3),(5,'Lm','Lim',2),(6,'Cc','Coc',3),(7,'Nz','Nue',4),(8,'Dl','Dul',3),(9,'Cf','Caf',3),(10,'Fr','Frt',2);

INSERT INTO Toppings VALUES
(1,'Ch','50'),(2,'Sp','40'),(3,'Cr','30'),(4,'Go','20'),(5,'Fr','25'),(6,'Ml','15'),(7,'Ce','35'),(8,'Al','10'),(9,'Nz','8'),(10,'Cc','12');

INSERT INTO Pedidos VALUES
(1,'2025-01-01',1,1),(2,'2025-01-02',2,2),(3,'2025-01-03',3,3),(4,'2025-01-04',4,4),(5,'2025-01-05',5,5),(6,'2025-01-06',6,6),(7,'2025-01-07',7,7),(8,'2025-01-08',8,8),
(9,'2025-01-09',9,9),(10,'2025-01-10',10,10);

INSERT INTO Pedido_Helado VALUES
(1,1),(1,2),(2,3),(3,4),(4,5),(5,6),(6,7),(7,8),(8,9),(9,10);

INSERT INTO Helado_Topping VALUES
(1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10);

CREATE VIEW V_ClientesPedidos AS
SELECT c.idCliente,c.nombre,p.idPedido FROM Clientes c JOIN Pedidos p ON c.idCliente=p.idCliente;
GO

CREATE VIEW V_EmpleadosPedidos AS
SELECT e.idEmpleado,e.nombre,p.idPedido FROM Empleados e JOIN Pedidos p ON e.idEmpleado=p.idEmpleado;
GO

CREATE VIEW V_HeladosToppings AS
SELECT h.idHelado,h.nombre AS Helado,t.nombre AS Topping
FROM Helados h JOIN Helado_Topping ht ON h.idHelado=ht.idHelado
JOIN Toppings t ON t.idTopping=ht.idTopping;
GO

CREATE VIEW V_HeladosBaratos AS
SELECT nombre,precio FROM Helados WHERE precio<3.5;
GO

CREATE VIEW V_ClientesCiudad AS
SELECT ciudad, COUNT(*) AS TotalClientes FROM Clientes GROUP BY ciudad;
GO

CREATE TABLE AuditoriaHel (
    idAuditoria INT IDENTITY(1,1) PRIMARY KEY,
    tabla VARCHAR(50),
    operacion VARCHAR(10),
    id_registro INT,
    datos_previos NVARCHAR(MAX),
    datos_nuevos NVARCHAR(MAX),
    fechaCambio DATETIME DEFAULT GETDATE()
);
GO

CREATE TRIGGER trg_auditoria_clientes
ON Clientes
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    INSERT INTO AuditoriaHel(tabla, operacion, id_registro, datos_previos, datos_nuevos)
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
    INSERT INTO AuditoriaHel(tabla, operacion, id_registro, datos_previos, datos_nuevos)
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

CREATE TRIGGER trg_auditoria_helados
ON Helados
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    INSERT INTO AuditoriaHel(tabla, operacion, id_registro, datos_previos, datos_nuevos)
    SELECT 'Helados',
           CASE WHEN EXISTS(SELECT * FROM inserted) AND EXISTS(SELECT * FROM deleted) THEN 'UPDATE'
                WHEN EXISTS(SELECT * FROM inserted) THEN 'INSERT'
                ELSE 'DELETE' END,
           COALESCE(i.idHelado,d.idHelado),
           (SELECT * FROM deleted FOR JSON AUTO),
           (SELECT * FROM inserted FOR JSON AUTO)
    FROM inserted i FULL OUTER JOIN deleted d ON i.idHelado=d.idHelado;
END;
GO

CREATE TRIGGER trg_auditoria_pedidos
ON Pedidos
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    INSERT INTO AuditoriaHel(tabla, operacion, id_registro, datos_previos, datos_nuevos)
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

CREATE TRIGGER trg_auditoria_toppings
ON Toppings
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    INSERT INTO AuditoriaHel(tabla, operacion, id_registro, datos_previos, datos_nuevos)
    SELECT 'Toppings',
           CASE WHEN EXISTS(SELECT * FROM inserted) AND EXISTS(SELECT * FROM deleted) THEN 'UPDATE'
                WHEN EXISTS(SELECT * FROM inserted) THEN 'INSERT'
                ELSE 'DELETE' END,
           COALESCE(i.idTopping,d.idTopping),
           (SELECT * FROM deleted FOR JSON AUTO),
           (SELECT * FROM inserted FOR JSON AUTO)
    FROM inserted i FULL OUTER JOIN deleted d ON i.idTopping=d.idTopping;
END;
GO

CREATE TRIGGER trg_auditoria_pedido_helado
ON Pedido_Helado
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    INSERT INTO AuditoriaHel(tabla, operacion, id_registro, datos_previos, datos_nuevos)
    SELECT 'Pedido_Helado',
           CASE WHEN EXISTS(SELECT * FROM inserted) AND EXISTS(SELECT * FROM deleted) THEN 'UPDATE'
                WHEN EXISTS(SELECT * FROM inserted) THEN 'INSERT'
                ELSE 'DELETE' END,
           COALESCE(i.idPedido,d.idPedido),
           (SELECT * FROM deleted FOR JSON AUTO),
           (SELECT * FROM inserted FOR JSON AUTO)
    FROM inserted i FULL OUTER JOIN deleted d ON i.idPedido=d.idPedido;
END;
GO

CREATE TRIGGER trg_auditoria_helado_topping
ON Helado_Topping
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    INSERT INTO AuditoriaHel(tabla, operacion, id_registro, datos_previos, datos_nuevos)
    SELECT 'Helado_Topping',
           CASE WHEN EXISTS(SELECT * FROM inserted) AND EXISTS(SELECT * FROM deleted) THEN 'UPDATE'
                WHEN EXISTS(SELECT * FROM inserted) THEN 'INSERT'
                ELSE 'DELETE' END,
           COALESCE(i.idHelado,d.idHelado),
           (SELECT * FROM deleted FOR JSON AUTO),
           (SELECT * FROM inserted FOR JSON AUTO)
    FROM inserted i FULL OUTER JOIN deleted d ON i.idHelado=d.idHelado;
END;
GO
SELECT * FROM AuditoriaHel;


CREATE INDEX idx_Clientes_Nombre
ON Clientes(nombre);

-- Buscar cliente por nombre
SELECT * FROM Clientes
WHERE nombre = 'A';

CREATE INDEX idx_Pedidos_ClienteEmpleado
ON Pedidos(idCliente, idEmpleado);

-- Buscar pedidos de un cliente específico atendidos por un empleado específico
SELECT * FROM Pedidos
WHERE idCliente = 1 AND idEmpleado = 1;

CREATE INDEX idx_Toppings_Cantidad
ON Toppings(cantidad);

-- Buscar toppings con cierta cantidad
SELECT * FROM Toppings
WHERE cantidad >= 30;