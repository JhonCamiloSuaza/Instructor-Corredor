CREATE DATABASE VentaClientes;
USE VentaClientes;

-- Tabla de clientes
CREATE TABLE Clientes (
    idCliente INT PRIMARY KEY,
    nombre VARCHAR(50),
    correo VARCHAR(50),
    ciudad VARCHAR(30)
);

-- Tabla de productos
CREATE TABLE Productos (
    idProducto INT PRIMARY KEY,
    nombre VARCHAR(50),
    precio DECIMAL(10,2),
    stock INT
);

-- Tabla de empleados
CREATE TABLE Empleados (
    idEmpleado INT PRIMARY KEY,
    nombre VARCHAR(50),
    cargo VARCHAR(30)
);

-- Tabla de pedidos
CREATE TABLE Pedidos (
    idPedido INT PRIMARY KEY,
    fecha DATE,
    idCliente INT,
    idEmpleado INT,
    FOREIGN KEY (idCliente) REFERENCES Clientes(idCliente),
    FOREIGN KEY (idEmpleado) REFERENCES Empleados(idEmpleado)
);

-- Tabla de proveedores
CREATE TABLE Proveedores (
    idProveedor INT PRIMARY KEY,
    nombre VARCHAR(50),
    telefono VARCHAR(20)
);

-- TABLA PIVOTE 1: Pedido_Producto
CREATE TABLE Pedido_Producto (
    idPedido INT,
    idProducto INT,
    cantidad INT,
    PRIMARY KEY(idPedido, idProducto),
    FOREIGN KEY (idPedido) REFERENCES Pedidos(idPedido),
    FOREIGN KEY (idProducto) REFERENCES Productos(idProducto)
);

-- TABLA PIVOTE 2: Producto_Proveedor
CREATE TABLE Producto_Proveedor (
    idProducto INT,
    idProveedor INT,
    PRIMARY KEY(idProducto, idProveedor),
    FOREIGN KEY (idProducto) REFERENCES Productos(idProducto),
    FOREIGN KEY (idProveedor) REFERENCES Proveedores(idProveedor)
);

-- CLIENTES
INSERT INTO Clientes VALUES 
(1,'Ana','a@c.com','Bog'),
(2,'Leo','l@c.com','Med'),
(3,'Mia','m@c.com','Cal'),
(4,'Jon','j@c.com','Bog'),
(5,'Sam','s@c.com','Car'),
(6,'Pia','p@c.com','Med'),
(7,'Luz','l2@c.com','Bog'),
(8,'Tom','t@c.com','Cal'),
(9,'Eva','e@c.com','Bog'),
(10,'Dan','d@c.com','Med');
SELECT * FROM Clientes;

-- EMPLEADOS
INSERT INTO Empleados VALUES
(1,'Laura','Vendedor'),(2,'Camilo','Vendedor'),(3,'Mateo','Gerente'),(4,'Paula','Vendedor'),
(5,'Jorge','Admin'),(6,'Sofía','Vendedor'),(7,'Diego','Vendedor'),(8,'Valeria','Admin'),(9,'Felipe','Gerente'),(10,'Esteban','Vendedor');
SELECT * FROM Empleados;

-- PRODUCTOS
INSERT INTO Productos VALUES
(1,'Lapiz',50,100),(2,'Cuaderno',200,50),(3,'Borrador',800,80),(4,'Regla',1200,60),(5,'Bolígrafo',1500,40),
(6,'Marcador',2500,70),(7,'Carpeta',3000,30),(8,'Tijeras',3500,25),(9,'Pegante',100,90),(10,'Papel',200,200);
SELECT * FROM Productos;

-- PROVEEDORES
INSERT INTO Proveedores VALUES
(1,'OfficeCo','1'),(2,'PaperMax','2'),(3,'TodoUtil','3'),(4,'MegaPapelería','4'),(5,'ProveeCol','5'),
(6,'Sumimax','6'),(7,'UtilExpress','7'),(8,'SuministrosYa','8'),(9,'PapeleríaPro','9'),(10,'MultiOffice','10');
SELECT * FROM Proveedores;

-- PEDIDOS
INSERT INTO Pedidos VALUES
(1,'2025-01-01',1,1),(2,'2025-02-01',2,2),(3,'2025-03-01',3,3),(4,'2025-04-01',4,4),
(5,'2025-05-01',5,5),(6,'2025-06-01',6,6),(7,'2025-07-01',7,7),(8,'2025-08-01',8,8),(9,'2025-09-01',9,9),(10,'2025-10-01',10,10);
SELECT * FROM Pedidos;

-- PEDIDO_PRODUCTO (ahora sí, después de que existan los pedidos y productos)
INSERT INTO Pedido_Producto VALUES
(1,1,2),(1,2,1),(2,3,1),(3,4,2),(4,5,3),
(5,6,1),(6,7,2),(7,8,1),(8,9,3),(9,10,5);
SELECT * FROM Pedido_Producto;

-- PRODUCTO_PROVEEDOR
INSERT INTO Producto_Proveedor VALUES
(1,1),(2,2),(3,3),(4,4),(5,5),
(6,6),(7,7),(8,8),(9,9),(10,10);
SELECT * FROM Producto_Proveedor ;


-- UPDATE
UPDATE Productos SET precio = 1800 WHERE idProducto = 2;

-- DELETE
DELETE FROM Pedidos
WHERE idCliente = 10;

-- 3. Finalmente borrar al cliente
DELETE FROM Clientes
WHERE idCliente = 10;


-- JOIN 1: Cliente con su pedido
SELECT c.nombre, p.idPedido, p.fecha
FROM Clientes c
JOIN Pedidos p ON c.idCliente = p.idCliente;

-- JOIN 2: Pedido con productos
SELECT p.idPedido, pr.nombre, pp.cantidad
FROM Pedidos p
JOIN Pedido_Producto pp ON p.idPedido = pp.idPedido
JOIN Productos pr ON pr.idProducto = pp.idProducto;

-- JOIN 3: Producto con su proveedor
SELECT pr.nombre AS Producto, prov.nombre AS Proveedor
FROM Productos pr
JOIN Producto_Proveedor pp ON pr.idProducto = pp.idProducto
JOIN Proveedores prov ON prov.idProveedor = pp.idProveedor;

-- Subconsulta 1: Productos con precio mayor al promedio
SELECT nombre, precio
FROM Productos
WHERE precio > (SELECT AVG(precio) FROM Productos);

-- Subconsulta 2: Clientes que hicieron pedidos
SELECT nombre FROM Clientes
WHERE idCliente IN (SELECT idCliente FROM Pedidos);

-- Subconsulta 3: Empleados que no son gerentes
SELECT nombre FROM Empleados
WHERE idEmpleado NOT IN (
    SELECT idEmpleado FROM Empleados WHERE cargo = 'Gerente'
);


-- ALTER 1: agregar columna teléfono en clientes
ALTER TABLE Clientes ADD telefono VARCHAR(20);

-- ALTER 2: modificar el stock de productos a NOT NULL
ALTER TABLE Productos ALTER COLUMN stock INT NOT NULL;



CREATE OR ALTER PROCEDURE TallerTodo
AS
BEGIN
    -- UPDATE ejemplo
    UPDATE Productos 
    SET precio = 850 
    WHERE idProducto = 2;

    -- DELETE ejemplo con dependencias
    DELETE FROM Pedido_Producto 
    WHERE idPedido IN (SELECT idPedido FROM Pedidos WHERE idCliente = 10);
    DELETE FROM Pedidos WHERE idCliente = 10;
    DELETE FROM Clientes WHERE idCliente = 10;

    -- SELECT JOIN ejemplo
    SELECT c.nombre, p.idPedido 
    FROM Clientes c 
    JOIN Pedidos p ON c.idCliente = p.idCliente;

    -- Subconsulta ejemplo
    SELECT nombre 
    FROM Productos 
    WHERE precio > (SELECT AVG(precio) FROM Productos);

    -- ALTER ejemplos
    IF COL_LENGTH('Clientes','tel2') IS NULL
        ALTER TABLE Clientes ADD tel2 VARCHAR(15);
    ALTER TABLE Productos ALTER COLUMN stock INT NOT NULL;

    -- REPORTES (en lugar de vistas, devolvemos SELECTs)
   
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

    -- Rep5
    SELECT c.ciudad, COUNT(*) AS TotalClientes
    FROM Clientes c
    GROUP BY c.ciudad;
END;
GO
  

  -- Vista 1: Clientes, Muestra los clientes registrados (su ID y su nombre).Sirve para ver la lista básica de clientes.
IF OBJECT_ID('V_Clientes','V') IS NOT NULL DROP VIEW V_Clientes;
GO
CREATE VIEW V_Clientes AS
SELECT idCliente, nombre FROM Clientes;
GO

-- Vista 2: Productos, Muestra los productos disponibles (ID, nombre y precio).Sirve para consultar rápido el catálogo de productos.
IF OBJECT_ID('V_Productos','V') IS NOT NULL DROP VIEW V_Productos;
GO
CREATE VIEW V_Productos AS
SELECT idProducto, nombre, precio FROM Productos;
GO

-- Vista 3: Pedidos, Muestra los pedidos realizados, indicando qué cliente los hizo y en qué fecha. Sirve para revisar qué clientes han hecho pedidos y cuándo.
IF OBJECT_ID('V_Pedidos','V') IS NOT NULL DROP VIEW V_Pedidos;
GO
CREATE VIEW V_Pedidos AS
SELECT idPedido, idCliente, fecha FROM Pedidos;
GO

-- Vista 4: Proveedores,  Lista los proveedores registrados (ID y nombre). Sirve para identificar las empresas proveedoras.
IF OBJECT_ID('V_Proveedores','V') IS NOT NULL DROP VIEW V_Proveedores;
GO
CREATE VIEW V_Proveedores AS
SELECT idProveedor, nombre FROM Proveedores;
GO

-- Vista 5: Empleados, Muestra los empleados registrados (ID y nombre).Sirve para ver quiénes trabajan en la empresa.
IF OBJECT_ID('V_Empleados','V') IS NOT NULL DROP VIEW V_Empleados;
GO
CREATE VIEW V_Empleados AS
SELECT idEmpleado, nombre FROM Empleados;
GO






/*SELECT * FROM V_Clientes;
SELECT * FROM V_Productos;
SELECT * FROM V_Pedidos;
SELECT * FROM V_Proveedores;
SELECT * FROM V_Empleados;



DROP DATABASE IF EXISTS VentaClientes;

DELETE FROM Pedido_Producto;
DELETE FROM Producto_Proveedor;
DELETE FROM Pedidos;
DELETE FROM Clientes;
DELETE FROM Productos;
DELETE FROM Empleados;
DELETE FROM Proveedores;*/

/* Crear índice compuesto
CREATE NONCLUSTERED INDEX idx_ruta_nombre_duracion
ON Ruta(nombre, duracion_estimada);

-- Consulta que aprovecha el índice
SELECT *
FROM Ruta
WHERE duracion_estimada = 45;

-- Este índice ayuda cuando buscas por nombre y duración al mismo tiempo


CREATE NONCLUSTERED INDEX idx_clientes_nombre2
ON Clientes(nombre_cliente);

SELECT *
FROM Clientes
WHERE nombre_cliente = 'Ana';


Crea un índice no agrupado sobre la columna nombre_cliente
Permite que SQL Server encuentre más rápido a los clientes por nombre.
La consulta con WHERE nombre_cliente = 'Ana' ya no recorrerá toda la tabla (table
scan), sino que usará este índice para ir directo al registro./*