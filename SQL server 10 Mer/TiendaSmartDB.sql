CREATE DATABASE TiendaSmartDB;
GO
USE TiendaSmartDB;
GO

--  CLIENTES
CREATE TABLE Clientes (
    idCliente INT PRIMARY KEY,
    nombre VARCHAR(50),
    correo VARCHAR(50),
    ciudad VARCHAR(30)
);

--  PRODUCTOS
CREATE TABLE Productos (
    idProducto INT PRIMARY KEY,
    nombre VARCHAR(50),
    precio DECIMAL(10,2),
    stock INT
);

--  EMPLEADOS
CREATE TABLE Empleados (
    idEmpleado INT PRIMARY KEY,
    nombre VARCHAR(50),
    cargo VARCHAR(30)
);

--  PEDIDOS
CREATE TABLE Pedidos (
    idPedido INT PRIMARY KEY,
    fecha DATE,
    idCliente INT,
    idEmpleado INT,
    FOREIGN KEY (idCliente) REFERENCES Clientes(idCliente),
    FOREIGN KEY (idEmpleado) REFERENCES Empleados(idEmpleado)
);

--  PROVEEDORES
CREATE TABLE Proveedores (
    idProveedor INT PRIMARY KEY,
    nombre VARCHAR(50),
    telefono VARCHAR(20)
);

-- PEDIDO_PRODUCTO
CREATE TABLE Pedido_Producto (
    idPedido INT,
    idProducto INT,
    cantidad INT,
    PRIMARY KEY(idPedido, idProducto),
    FOREIGN KEY (idPedido) REFERENCES Pedidos(idPedido),
    FOREIGN KEY (idProducto) REFERENCES Productos(idProducto)
);

-- PRODUCTO_PROVEEDOR
CREATE TABLE Producto_Proveedor (
    idProducto INT,
    idProveedor INT,
    PRIMARY KEY(idProducto, idProveedor),
    FOREIGN KEY (idProducto) REFERENCES Productos(idProducto),
    FOREIGN KEY (idProveedor) REFERENCES Proveedores(idProveedor)
);


-- CLIENTES
INSERT INTO Clientes VALUES
(1,'Andrea','Agmail.com','Bogotá'),
(2,'Felipe','F@hotmail.com','Medellín'),
(3,'Daniela','D@gmail.com','Cali'),
(4,'Samuel','S@outlook.com','Tolima'),
(5,'Valentina','V@gmail.com','Cartagena'),
(6,'Nicolás','N@yahoo.com','Pereira'),
(7,'Laura','L@gmail.com','Cauca'),
(8,'Santiago','S@gmail.com','Cúcuta'),
(9,'Camila','C@hotmail.com','Armenia'),
(10,'Julián','J@gmail.com','Neiva');

-- EMPLEADOS
INSERT INTO Empleados VALUES
(1,'Martina','Vendedor'),(2,'Juan','Vendedor'),(3,'Sebastián','Gerente'),
(4,'Catalina','Vendedor'),(5,'Sofía','Admin'),(6,'David','Vendedor'),
(7,'Lucía','Vendedor'),(8,'Tomás','Admin'),(9,'Maria','Gerente'),(10,'Emilio','Vendedor');

-- PRODUCTOS
INSERT INTO Productos VALUES
(1,'Celular Galaxy',28,12),
(2,'Tablet Lenovo',15,90),
(3,'Smartwatch Huawei',95,80),
(4,'Audífonos Sony',30,20),
(5,'Mouse Logitech',12,15),
(6,'Teclado Mecánico',25,75),
(7,'Monitor LG "',12,65),
(8,'Disco Duro ',40,60),
(9,'Laptop HP',35,50),
(10,'Cámara Nikon',28,30);

-- PROVEEDORES
INSERT INTO Proveedores VALUES
(1,'TechPro','31'),(2,'SmartWorld','32'),(3,'DigitalZone','33'),
(4,'GadgetStore','34'),(5,'ElectroMax','35'),
(6,'CompuHouse','36'),(7,'HighTech','37'),
(8,'MegaElectro','38'),(9,'PCExpress','39'),(10,'Electronix','40');

-- PEDIDOS
INSERT INTO Pedidos VALUES
(1,'2025-01-15',1,1),(2,'2025-02-20',2,2),(3,'2025-03-25',3,3),(4,'2025-04-18',4,4),
(5,'2025-05-22',5,5),(6,'2025-06-05',6,6),(7,'2025-07-09',7,7),(8,'2025-08-12',8,8),
(9,'2025-09-03',9,9),(10,'2025-10-10',10,10);

-- PEDIDO_PRODUCTO
INSERT INTO Pedido_Producto VALUES
(1,1,3),(1,2,2),(2,3,1),(3,4,2),(4,5,5),
(5,6,3),(6,7,2),(7,8,1),(8,9,4),(9,10,2);

-- PRODUCTO_PROVEEDOR
INSERT INTO Producto_Proveedor VALUES
(1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10);

-- Aumentamos en 5 el stock de los productos con precio menor a 300,000
UPDATE Productos
SET stock = stock + 5
WHERE precio < 300000;
GO

-- Eliminar un cliente que no tiene pedidos
DELETE FROM Clientes
WHERE idCliente NOT IN (SELECT DISTINCT idCliente FROM Pedidos);
GO

--  Eliminar un producto que no ha sido vendido
DELETE FROM Productos
WHERE idProducto NOT IN (SELECT DISTINCT idProducto FROM Pedido_Producto);
GO


-- Listar todos los clientes
SELECT * FROM Clientes;
GO

--   todos los productos ordenados por precio descendente
SELECT * FROM Productos ORDER BY precio DESC;
GO

--  Mostrar empleados que son vendedores
SELECT * FROM Empleados WHERE cargo = 'Vendedor';
GO


--  Clientes que han realizado pedidos
SELECT nombre, correo
FROM Clientes
WHERE idCliente IN (SELECT DISTINCT idCliente FROM Pedidos);
GO

-- Productos con precio mayor al promedio
SELECT nombre, precio
FROM Productos
WHERE precio > (SELECT AVG(precio) FROM Productos);
GO

-- Empleados que gestionaron más de 1 pedido
SELECT nombre
FROM Empleados
WHERE idEmpleado IN (
    SELECT idEmpleado
    FROM Pedidos
    GROUP BY idEmpleado
    HAVING COUNT(idPedido) > 1
);
GO


--  Agregar una columna de teléfono a clientes
ALTER TABLE Clientes ADD telefono VARCHAR(20);
GO

--  Ampliar la longitud de los correos electrónicos
ALTER TABLE Clientes ALTER COLUMN correo VARCHAR(100);
GO


CREATE PROCEDURE ReporteGeneral
AS
BEGIN
    SELECT 'Clientes' AS Tipo, COUNT(*) AS Total FROM Clientes
    UNION ALL
    SELECT 'Productos', COUNT(*) FROM Productos
    UNION ALL
    SELECT 'Pedidos', COUNT(*) FROM Pedidos
    UNION ALL
    SELECT 'Empleados', COUNT(*) FROM Empleados
    UNION ALL
    SELECT 'Proveedores', COUNT(*) FROM Proveedores;
END;
GO
EXEC ReporteGeneral;
GO

-- 1. Reporte con vistas clientes y pedidos
CREATE VIEW Reporte_Compras_Clientes AS
SELECT c.idCliente, c.nombre, c.correo, c.ciudad,
       COUNT(p.idPedido) AS total_pedidos
FROM Clientes c
INNER JOIN Pedidos p ON c.idCliente = p.idCliente
GROUP BY c.idCliente, c.nombre, c.correo, c.ciudad;
GO

SELECT * FROM Reporte_Compras_Clientes ORDER BY total_pedidos DESC;
GO

-- 2. Reporte con vistas productos más vendidos
CREATE VIEW Reporte_Productos_Mas_Vendidos AS
SELECT pr.idProducto, pr.nombre,
       SUM(pp.cantidad) AS total_vendido
FROM Pedido_Producto pp
INNER JOIN Productos pr ON pp.idProducto = pr.idProducto
GROUP BY pr.idProducto, pr.nombre;
GO

SELECT * FROM Reporte_Productos_Mas_Vendidos ORDER BY total_vendido DESC;
GO

-- 3. Reporte con vistas pedidos mensuales
CREATE VIEW Reporte_Pedidos_Mensuales AS
SELECT YEAR(p.fecha) AS anio,
       MONTH(p.fecha) AS mes,
       COUNT(p.idPedido) AS total_pedidos
FROM Pedidos p
GROUP BY YEAR(p.fecha), MONTH(p.fecha);
GO

SELECT * FROM Reporte_Pedidos_Mensuales ORDER BY anio, mes;
GO

-- 4. Reporte con vistas clientes sin pedidos
CREATE VIEW Reporte_Clientes_Sin_Pedidos AS
SELECT c.idCliente, c.nombre, c.correo
FROM Clientes c
LEFT JOIN Pedidos p ON c.idCliente = p.idCliente
WHERE p.idPedido IS NULL;
GO

SELECT * FROM Reporte_Clientes_Sin_Pedidos;
GO

-- 5. Reporte con vistas pedidos detallados por cliente
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


/* Sirve para acelerar reportes como "productos más vendidos"
-- porque facilita la suma y agrupación por producto.
CREATE NONCLUSTERED INDEX idx_pedido_producto_ventas
ON Pedido_Producto(idProducto, cantidad);
-- Consulta que lo aprovecha
SELECT pr.nombre, SUM(pp.cantidad) AS total_vendido
FROM Pedido_Producto pp
JOIN Productos pr ON pr.idProducto = pp.idProducto
GROUP BY pr.nombre
uede buscar más rápido todos los registros de un producto
Como el índice ya está ordenado por idProducto, el cálculo de SUM(cantidad) es mucho más eficiente.
;


-- Índice compuesto en Pedidos (idCliente, fecha)
-- Incluye idEmpleado para que las consultas no tengan que volver a la tabla.
CREATE NONCLUSTERED INDEX idx_pedidos_cliente_fecha_cover
ON Pedidos(idCliente, fecha)
INCLUDE (idEmpleado);

-- Consulta que lo aprovecha
SELECT idCliente, fecha, idEmpleado
FROM Pedidos
WHERE idCliente = 2
  AND fecha BETWEEN '2025-01-01' AND '2025-06-30';

  Ordena los pedidos por cliente y fecha.
  idx_pedido_producto_ventas ? acelera reportes de productos más vendidos.

idx_pedidos_cliente_fecha_cover ? acelera consultas de pedidos por cliente y fecha sin necesidad de leer toda la tabla.