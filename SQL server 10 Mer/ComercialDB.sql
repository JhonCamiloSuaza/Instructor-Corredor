CREATE DATABASE ComercialDB;
USE ComercialDB;

--  clientes
CREATE TABLE Clientes (
    idCliente INT PRIMARY KEY,
    nombre VARCHAR(50),
    correo VARCHAR(50),
    ciudad VARCHAR(30)
);

-- productos
CREATE TABLE Productos (
    idProducto INT PRIMARY KEY,
    nombre VARCHAR(50),
    precio DECIMAL(10,2),
    stock INT
);

-- empleados
CREATE TABLE Empleados (
    idEmpleado INT PRIMARY KEY,
    nombre VARCHAR(50),
    cargo VARCHAR(30)
);

--  pedidos
CREATE TABLE Pedidos (
    idPedido INT PRIMARY KEY,
    fecha DATE,
    idCliente INT,
    idEmpleado INT,
    FOREIGN KEY (idCliente) REFERENCES Clientes(idCliente),
    FOREIGN KEY (idEmpleado) REFERENCES Empleados(idEmpleado)
);

--  proveedores
CREATE TABLE Proveedores (
    idProveedor INT PRIMARY KEY,
    nombre VARCHAR(50),
    telefono VARCHAR(20)
);

--  Pedido_Producto
CREATE TABLE Pedido_Producto (
    idPedido INT,
    idProducto INT,
    cantidad INT,
    PRIMARY KEY(idPedido, idProducto),
    FOREIGN KEY (idPedido) REFERENCES Pedidos(idPedido),
    FOREIGN KEY (idProducto) REFERENCES Productos(idProducto)
);

-- Producto_Proveedor
CREATE TABLE Producto_Proveedor (
    idProducto INT,
    idProveedor INT,
    PRIMARY KEY(idProducto, idProveedor),
    FOREIGN KEY (idProducto) REFERENCES Productos(idProducto),
    FOREIGN KEY (idProveedor) REFERENCES Proveedores(idProveedor)
);

-- CLIENTES 
INSERT INTO Clientes VALUES 
(1,'Karol','K@mail.com','Bogotá'),
(2,'Esteban','E@gmail.com','Medellín'),
(3,'Luciano','L@hotmail.com','Cali'),
(4,'Sofía','S@gmail.com','Cartagena'),
(5,'Pedro','P@gmail.com','Neiva'),
(6,'Juliana','J@gmail.com','Pereira'),
(7,'Diana','D@gmail.com','Tolima'),
(8,'Mateo','M@gmail.com','Manizales'),
(9,'Valeria','V@gmail.com','Bogotá'),
(10,'Simón','S@gmail.com','Cali');

-- EMPLEADOS 
INSERT INTO Empleados VALUES
(1,'Gabriela','Vendedor'),(2,'Hernán','Vendedor'),(3,'Mónica','Gerente'),(4,'Cristian','Vendedor'),
(5,'Tatiana','Admin'),(6,'Pablo','Vendedor'),(7,'Ricardo','Vendedor'),(8,'Fernanda','Admin'),
(9,'Camilo','Gerente'),(10,'Nicole','Vendedor');

-- PRODUCTOS 
INSERT INTO Productos VALUES
(1,'Smartphone',9800,150),(2,'Tablet',6500,100),(3,'Smartwatch',400,70),(4,'Teclado Gamer',200,80),
(5,'Mouse Gamer',1300,120),(6,'Parlante Bluetooth',2500,60),(7,'Cámara Web HD',300,40),
(8,'Disco SSD',5500,35),(9,'Laptop',2800,20),(10,'Proyector',1200,15);

-- PROVEEDORES 
INSERT INTO Proveedores VALUES
(1,'TecnoMarket','300'),(2,'ElectroPlus','310'),(3,'GadgetExpress','312'),
(4,'SmartSolutions','311'),(5,'DigitalWorld','301'),(6,'MegaElectro','316'),
(7,'HighTech','320'),(8,'ElectroShop','313'),(9,'Center','319'),
(10,'CompuLine','322');

-- PEDIDOS 
INSERT INTO Pedidos VALUES
(1,'2025-01-10',1,1),(2,'2025-02-14',2,2),(3,'2025-03-18',3,3),(4,'2025-04-20',4,4),
(5,'2025-05-25',5,5),(6,'2025-06-05',6,6),(7,'2025-07-15',7,7),(8,'2025-08-12',8,8),
(9,'2025-09-02',9,9),(10,'2025-10-08',10,10);

-- PEDIDO_PRODUCTO 
INSERT INTO Pedido_Producto VALUES
(1,1,2),(1,2,3),(2,3,1),(3,4,2),(4,5,4),
(5,6,3),(6,7,2),(7,8,1),(8,9,3),(9,10,2);

-- PRODUCTO_PROVEEDOR 
INSERT INTO Producto_Proveedor VALUES
(1,1),(2,2),(3,3),(4,4),(5,5),
(6,6),(7,7),(8,8),(9,9),(10,10);

-- UPDATE 
UPDATE Productos SET precio = 700000 WHERE idProducto = 2;

-- DELETE 
DELETE FROM Pedidos WHERE idCliente = 10;
DELETE FROM Clientes WHERE idCliente = 10;

--  Cliente con su pedido
SELECT c.nombre, p.idPedido, p.fecha
FROM Clientes c
JOIN Pedidos p ON c.idCliente = p.idCliente;

--  Pedido con productos
SELECT p.idPedido, pr.nombre, pp.cantidad
FROM Pedidos p
JOIN Pedido_Producto pp ON p.idPedido = pp.idPedido
JOIN Productos pr ON pr.idProducto = pp.idProducto;

--  Producto con su proveedor
SELECT pr.nombre AS Producto, prov.nombre AS Proveedor
FROM Productos pr
JOIN Producto_Proveedor pp ON pr.idProducto = pp.idProducto
JOIN Proveedores prov ON prov.idProveedor = pp.idProveedor;

--  Productos con precio mayor al promedio
SELECT nombre, precio
FROM Productos
WHERE precio > (SELECT AVG(precio) FROM Productos);

--  Clientes que hicieron pedidos
SELECT nombre FROM Clientes
WHERE idCliente IN (SELECT idCliente FROM Pedidos);

-- Empleados que no son gerentes
SELECT nombre FROM Empleados
WHERE idEmpleado NOT IN (
    SELECT idEmpleado FROM Empleados WHERE cargo = 'Gerente'
);

-- agregar columna teléfono en clientes
ALTER TABLE Clientes ADD telefono VARCHAR(20);

-- modificar el stock de productos a NOT NULL
ALTER TABLE Productos ALTER COLUMN stock INT NOT NULL;

-- PROCEDIMIENTO ALMACENADO
CREATE OR ALTER PROCEDURE TallerTodo
AS
BEGIN
    UPDATE Productos 
    SET precio = 600000 
    WHERE idProducto = 2;

    DELETE FROM Pedido_Producto 
    WHERE idPedido IN (SELECT idPedido FROM Pedidos WHERE idCliente = 10);
    DELETE FROM Pedidos WHERE idCliente = 10;
    DELETE FROM Clientes WHERE idCliente = 10;

    SELECT c.nombre, p.idPedido 
    FROM Clientes c 
    JOIN Pedidos p ON c.idCliente = p.idCliente;

    SELECT nombre 
    FROM Productos 
    WHERE precio > (SELECT AVG(precio) FROM Productos);

    IF COL_LENGTH('Clientes','tel2') IS NULL
        ALTER TABLE Clientes ADD tel2 VARCHAR(15);
    ALTER TABLE Productos ALTER COLUMN stock INT NOT NULL;

    SELECT c.nombre, p.idPedido 
    FROM Clientes c JOIN Pedidos p ON c.idCliente=p.idCliente;

    SELECT pr.nombre, SUM(pp.cantidad) AS Vendidos
    FROM Productos pr 
    JOIN Pedido_Producto pp ON pr.idProducto=pp.idProducto
    GROUP BY pr.nombre;

    SELECT e.nombre, COUNT(p.idPedido) AS TotalPedidos
    FROM Empleados e 
    JOIN Pedidos p ON e.idEmpleado=p.idEmpleado
    GROUP BY e.nombre;

    SELECT pr.nombre AS Producto, prov.nombre AS Proveedor
    FROM Productos pr 
    JOIN Producto_Proveedor pp ON pr.idProducto=pp.idProducto
    JOIN Proveedores prov ON prov.idProveedor=pp.idProveedor;

    SELECT c.ciudad, COUNT(*) AS TotalClientes
    FROM Clientes c
    GROUP BY c.ciudad;
END;
GO


-- 1. Reporte de clientes y total de pedidos
CREATE VIEW Reporte_Compras_Clientes AS
SELECT c.idCliente, c.nombre, c.correo, c.ciudad,
       COUNT(p.idPedido) AS total_pedidos
FROM Clientes c
INNER JOIN Pedidos p ON c.idCliente = p.idCliente
GROUP BY c.idCliente, c.nombre, c.correo, c.ciudad;
GO

SELECT * FROM Reporte_Compras_Clientes ORDER BY total_pedidos DESC;
GO


-- 2. Reporte de productos más vendidos
CREATE VIEW Reporte_Productos_Mas_Vendidos AS
SELECT pr.idProducto, pr.nombre,
       SUM(pp.cantidad) AS total_vendido
FROM Pedido_Producto pp
INNER JOIN Productos pr ON pp.idProducto = pr.idProducto
GROUP BY pr.idProducto, pr.nombre;
GO

SELECT * FROM Reporte_Productos_Mas_Vendidos ORDER BY total_vendido DESC;
GO


-- 3. Reporte de pedidos mensuales
CREATE VIEW Reporte_Pedidos_Mensuales AS
SELECT YEAR(p.fecha) AS anio,
       MONTH(p.fecha) AS mes,
       COUNT(p.idPedido) AS total_pedidos
FROM Pedidos p
GROUP BY YEAR(p.fecha), MONTH(p.fecha);
GO

SELECT * FROM Reporte_Pedidos_Mensuales ORDER BY anio, mes;
GO


-- 4. Reporte de clientes sin pedidos
CREATE VIEW Reporte_Clientes_Sin_Pedidos AS
SELECT c.idCliente, c.nombre, c.correo
FROM Clientes c
LEFT JOIN Pedidos p ON c.idCliente = p.idCliente
WHERE p.idPedido IS NULL;
GO

SELECT * FROM Reporte_Clientes_Sin_Pedidos;
GO


-- 5. Reporte de pedidos detallados por cliente
CREATE VIEW Reporte_Pedidos_Detallados AS
SELECT p.idPedido, p.fecha,
       c.idCliente, c.nombre, c.correo,
       e.nombre AS empleado
FROM Pedidos p
INNER JOIN Clientes c ON p.idCliente = c.idCliente
INNER JOIN Empleados e ON p.idEmpleado = e.idEmpleado;
GO

SELECT * FROM Reporte_Pedidos_Detallados ORDER BY fecha DESC;
GO


/* Índice no agrupado (simple) en Clientes(nombre)
-- Este índice acelera las consultas que buscan clientes por su nombre.

CREATE NONCLUSTERED INDEX idx_clientes_nombre
ON Clientes(nombre);


CREATE NONCLUSTERED INDEX idx_pedido_producto_ventas
ON Pedido_Producto(idProducto, cantidad);

Ordena y mantén accesibles los registros por idProducto, y dentro de cada producto guarda también su cantidad

Reportes de productos más vendidos
Cuando haces un JOIN con Productos y luego haces un SUM(cantidad) agrupado por idProducto, SQL ya no tendrá que recorrer toda la tabla desordenada

SELECT pr.nombre, SUM(pp.cantidad) AS total_vendido
FROM Pedido_Producto pp
JOIN Productos pr ON pr.idProducto = pp.idProducto
GROUP BY pr.nombre;
 Este índice ayuda a localizar rápido todos los registros de cada producto y suma las cantidades de forma más eficiente.

/*