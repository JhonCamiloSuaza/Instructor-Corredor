-- Trabajo del tablero

-- Mer del tablero Restaurante


-- Crear la base de datos
CREATE DATABASE Restaurante;
USE Restaurante;

-- 1. Tabla Mesero
CREATE TABLE Mesero (
    id_mesero INT PRIMARY KEY,
    nombre VARCHAR(100), 
    telefono VARCHAR(15),
    gmail VARCHAR(50) ,
    direccion TEXT ,
    sueldo INT
);

-- 2. Tabla Plato
CREATE TABLE Plato (
    id_plato INT PRIMARY KEY NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    detalle TEXT NOT NULL,
    cantidad INT DEFAULT 0 NOT NULL
);

-- 3. Tabla Orden
CREATE TABLE Orden (
    id_orden INT PRIMARY KEY NOT NULL,
    fecha DATETIME NOT NULL,
    id_mesero INT NOT NULL,
    numero_orden VARCHAR(20) NOT NULL UNIQUE,
    FOREIGN KEY (id_mesero) REFERENCES Mesero(id_mesero)
);

-- 4. Tabla DetalleOrden
CREATE TABLE DetalleOrden (
    id_detalleOrden INT PRIMARY KEY NOT NULL,
    id_plato INT NOT NULL,
    valor INT NOT NULL,
    id_orden INT NOT NULL,
    cantidad INT NOT NULL DEFAULT 1,
    FOREIGN KEY (id_plato) REFERENCES Plato(id_plato),
    FOREIGN KEY (id_orden) REFERENCES Orden(id_orden)
);

-- Insertar datos en Mesero (nombres y datos modificados)
INSERT INTO Mesero (id_mesero, nombre, telefono, gmail, direccion, sueldo) VALUES
(1, 'Luis Martínez', '3112223333', 'luis.m@restaurante.com', 'Carrera 15 #25-35', 1250000),
(2, 'Ana Rodríguez', '3145556666', 'ana.r@restaurante.com', 'Avenida 30 #10-20', 1350000),
(3, 'Pedro Sánchez', '3178889999', 'pedro.s@restaurante.com', 'Calle 50 #40-30', 1300000);

-- Insertar datos en Plato (platos modificados)
INSERT INTO Plato (id_plato, nombre, precio, detalle, cantidad) VALUES
(1, 'Pasta Alfredo', 38000, 'Pasta con salsa cremosa de queso parmesano', 45),
(2, 'Pollo a la Parrilla', 42000, 'Pechuga de pollo con especias y vegetales', 35),
(3, 'Sopa de Tomate', 18000, 'Sopa cremosa de tomate con hierbas', 80);

-- Insertar datos en Orden (fechas y números modificados)
INSERT INTO Orden (id_orden, fecha, id_mesero, numero_orden) VALUES
(1, '2025-06-01 11:30:00', 1, 'PED-101'),
(2, '2025-06-01 12:45:00', 2, 'PED-102'),
(3, '2025-06-01 13:20:00', 3, 'PED-103');

-- Insertar datos en DetalleOrden (valores modificados)
INSERT INTO DetalleOrden (id_detalleOrden, id_orden, id_plato, valor, cantidad) VALUES
(1, 1, 1, 38000, 1),
(2, 1, 3, 18000, 2),
(3, 2, 2, 42000, 1),
(4, 3, 1, 38000, 2),
(5, 3, 2, 42000, 1);

-- Operaciones UPDATE (valores actualizados)
UPDATE Plato SET precio = 40000 WHERE id_plato = 1;
UPDATE Mesero SET sueldo = 1400000 WHERE id_mesero = 2;

-- Operaciones DELETE (IDs actualizados)
DELETE FROM DetalleOrden WHERE id_orden = 2;
DELETE FROM Orden WHERE id_orden = 2;
DELETE FROM Mesero WHERE id_mesero = 2;

-- Operaciones ALTER TABLE (mantenidas)

ALTER TABLE Mesero ALTER COLUMN telefono VARCHAR(20);
ALTER TABLE Plato ALTER COLUMN precio INT;

SELECT  
    O.numero_orden,  
    O.id_orden,  
    M.nombre AS mesero,  
    CONVERT(VARCHAR, O.fecha, 120) AS fecha_hora,  
    P.nombre AS plato,  
    P.precio,  
    D.cantidad,  
    D.valor,  
    (D.cantidad * D.valor) AS total  
FROM Orden O  
JOIN Mesero M ON O.id_mesero = M.id_mesero  
JOIN DetalleOrden D ON O.id_orden = D.id_Orden  
JOIN Plato P ON D.id_plato = P.id_plato;


-- Operaciones TRUNCATE (comentadas por seguridad)
TRUNCATE TABLE DetalleOrden;


-- Operaciones DROP (en orden correcto de dependencias)
DROP TABLE DetalleOrden;
DROP TABLE Plato;
DROP TABLE Orden;
DROP TABLE Mesero;

-- Eliminar base de datos
DROP DATABASE Restaurante;