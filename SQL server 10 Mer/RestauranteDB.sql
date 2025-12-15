CREATE DATABASE RestauranteDB;
USE RestauranteDB;

CREATE TABLE Clientes (
    idCliente INT PRIMARY KEY,
    nombre VARCHAR(10),
    correo VARCHAR(15),
    ciudad VARCHAR(10),
    tel VARCHAR(10)
);

CREATE TABLE Empleados (
    idEmpleado INT PRIMARY KEY,
    nombre VARCHAR(10),
    cargo VARCHAR(10)
);

CREATE TABLE Platos (
    idPlato INT PRIMARY KEY,
    nombre VARCHAR(15),
    cat VARCHAR(10),
    precio INT
);

CREATE TABLE Pedidos (
    idPedido INT PRIMARY KEY,
    fecha DATE,
    idCliente INT,
    idEmpleado INT,
    FOREIGN KEY (idCliente) REFERENCES Clientes(idCliente),
    FOREIGN KEY (idEmpleado) REFERENCES Empleados(idEmpleado)
);

CREATE TABLE Bebidas (
    idBebida INT PRIMARY KEY,
    nombre VARCHAR(15),
    cant INT
);

CREATE TABLE Pedido_Plato (
    idPedido INT,
    idPlato INT,
    PRIMARY KEY(idPedido,idPlato),
    FOREIGN KEY (idPedido) REFERENCES Pedidos(idPedido),
    FOREIGN KEY (idPlato) REFERENCES Platos(idPlato)
);

CREATE TABLE Plato_Bebida (
    idPlato INT,
    idBebida INT,
    PRIMARY KEY(idPlato,idBebida),
    FOREIGN KEY (idPlato) REFERENCES Platos(idPlato),
    FOREIGN KEY (idBebida) REFERENCES Bebidas(idBebida)
);


INSERT INTO Clientes VALUES
(1,'Ana','a@r.com','Bog','301'),(2,'Luis','l@r.com','Med','302'),
(3,'Mia','m@r.com','Cal','303'),(4,'Leo','leo@r.com','Nei','304'),(5,'Sofi','s@r.com','Car','305'),(6,'Max','mx@r.com','Bog','306'),
(7,'Eva','e@r.com','Per','307'),(8,'Ian','i@r.com','Man','308'),(,'Luz','lz@r.com','Buc','309'),(10,'Tom','t@r.com','SMt','310');

INSERT INTO Empleados VALUES
(1,'Car','Mes'),(2,'Mar','Coc'),(3,'Ped','Chef'),
(4,'Lau','Mes'),(5,'And','Bar'),(6,'Val','Mes'),
(7,'Dan','Adm'),(8,'Pau','Coc'),(9,'San','Chef'),(10,'Cam','Mes');

INSERT INTO Platos VALUES
(1,'Pizza','Ital',25),(2,'Burg','Rap',20),(3,'Sushi','Jap',30),
(4,'Arep','Tip',8),(5,'Pasta','Ital',22),(6,'Taco','Mex',15),
(7,'Ensa','Sal',12),(8,'Pollo','Cas',18),(9,'Sopa','Cas',10),(10,'Carne','Cas',28);

INSERT INTO Bebidas VALUES
(1,'Agua',100),(2,'Jugo',80),(3,'Gase',60),(4,'Cerv',40),(5,'Vino',30),
(6,'Cafe',25),(7,'Te',20),(8,'Limo',15),(9,'Cock',10),(10,'Choc',50);

INSERT INTO Pedidos VALUES
(1,'2025-01-01',1,1),(2,'2025-01-02',2,2),(3,'2025-01-03',3,3),
(4,'2025-01-04',4,4),(5,'2025-01-05',5,5),(6,'2025-01-06',6,6),
(7,'2025-01-07',7,7),(8,'2025-01-08',8,8),(9,'2025-01-09',9,9),(10,'2025-01-10',10,10);

INSERT INTO Pedido_Plato VALUES
(1,1),(1,2),(2,3),(3,4),(4,5),(5,6),(6,7),(7,8),(8,9),(9,10);

INSERT INTO Plato_Bebida VALUES
(1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10);

CREATE VIEW V_ClientesPedidos AS
SELECT c.idCliente, c.nombre, p.idPedido, p.fecha
FROM Clientes c
JOIN Pedidos p ON c.idCliente = p.idCliente;
GO

CREATE VIEW V_PlatosBebidas AS
SELECT pl.idPlato, pl.nombre AS Plato, b.nombre AS Bebida
FROM Platos pl
JOIN Plato_Bebida pb ON pl.idPlato = pb.idPlato
JOIN Bebidas b ON b.idBebida = pb.idBebida;
GO

CREATE VIEW V_EmpleadosPedidos AS
SELECT e.idEmpleado, e.nombre AS Emp, p.idPedido, p.fecha
FROM Empleados e
JOIN Pedidos p ON e.idEmpleado = p.idEmpleado;
GO

CREATE VIEW V_PlatosBaratos AS
SELECT nombre, cat, precio
FROM Platos
WHERE precio < (SELECT AVG(precio) FROM Platos);
GO

CREATE VIEW V_ClientesCiudad AS
SELECT ciudad, COUNT(*) AS TotCli
FROM Clientes
GROUP BY ciudad;
GO

CREATE TABLE Historial (
    idHist INT IDENTITY(1,1) PRIMARY KEY,
    tabla VARCHAR(20),
    accion VARCHAR(10),
    fecha DATETIME DEFAULT GETDATE()
);

CREATE TRIGGER TRG_Clientes_Aud
ON Clientes
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted) AND EXISTS (SELECT 1 FROM deleted)
        INSERT INTO Historial(tabla, accion) VALUES ('Clientes','UPDATE');
    ELSE IF EXISTS (SELECT 1 FROM inserted)
        INSERT INTO Historial(tabla, accion) VALUES ('Clientes','INSERT');
    ELSE
        INSERT INTO Historial(tabla, accion) VALUES ('Clientes','DELETE');
END;
GO

CREATE TRIGGER TRG_Empleados_Aud
ON Empleados
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted) AND EXISTS (SELECT 1 FROM deleted)
        INSERT INTO Historial(tabla, accion) VALUES ('Empleados','UPDATE');
    ELSE IF EXISTS (SELECT 1 FROM inserted)
        INSERT INTO Historial(tabla, accion) VALUES ('Empleados','INSERT');
    ELSE
        INSERT INTO Historial(tabla, accion) VALUES ('Empleados','DELETE');
END;
GO

CREATE TRIGGER TRG_Platos_Aud
ON Platos
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted) AND EXISTS (SELECT 1 FROM deleted)
        INSERT INTO Historial(tabla, accion) VALUES ('Platos','UPDATE');
    ELSE IF EXISTS (SELECT 1 FROM inserted)
        INSERT INTO Historial(tabla, accion) VALUES ('Platos','INSERT');
    ELSE
        INSERT INTO Historial(tabla, accion) VALUES ('Platos','DELETE');
END;
GO

CREATE TRIGGER TRG_Pedidos_Aud
ON Pedidos
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted) AND EXISTS (SELECT 1 FROM deleted)
        INSERT INTO Historial(tabla, accion) VALUES ('Pedidos','UPDATE');
    ELSE IF EXISTS (SELECT 1 FROM inserted)
        INSERT INTO Historial(tabla, accion) VALUES ('Pedidos','INSERT');
    ELSE
        INSERT INTO Historial(tabla, accion) VALUES ('Pedidos','DELETE');
END;
GO

CREATE TRIGGER TRG_Bebidas_Aud
ON Bebidas
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted) AND EXISTS (SELECT 1 FROM deleted)
        INSERT INTO Historial(tabla, accion) VALUES ('Bebidas','UPDATE');
    ELSE IF EXISTS (SELECT 1 FROM inserted)
        INSERT INTO Historial(tabla, accion) VALUES ('Bebidas','INSERT');
    ELSE
        INSERT INTO Historial(tabla, accion) VALUES ('Bebidas','DELETE');
END;
GO

CREATE INDEX idx_Clientes_Ciudad
ON Clientes(ciudad);

-- Todos los clientes de Bogotá
SELECT * FROM Clientes
WHERE ciudad = 'Bog';

CREATE INDEX idx_Pedidos_Fecha
ON Pedidos(fecha);
-- Todos los pedidos del 2025-01-01
SELECT * FROM Pedidos
WHERE fecha = '2025-01-01';

CREATE INDEX idx_Platos_Cat
ON Platos(cat);
SELECT * FROM Platos
WHERE cat = 'Ital';
