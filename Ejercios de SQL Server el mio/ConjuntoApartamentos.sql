-- Crear la base de datos
CREATE DATABASE ConjuntoApartamentos;
USE ConjuntoApartamentos;

-- Tabla Apartamento
CREATE TABLE Apartamento (
    id_apartamento INT PRIMARY KEY,
    numero VARCHAR(10) NOT NULL,
    piso INT NOT NULL,
    area_m2 DECIMAL(5,2) NOT NULL,
    estado VARCHAR(20)
);

-- Tabla Propietario
CREATE TABLE Propietario (
    id_propietario INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(50) UNIQUE NOT NULL
);

-- Tabla Servicio
CREATE TABLE Servicio (
    id_servicio INT PRIMARY KEY,
    tipo_servicio VARCHAR(50) NOT NULL,
    costo DECIMAL(8,2) NOT NULL
);

-- Tabla Apartamento_Servicio (relación muchos a muchos)
CREATE TABLE Apartamento_Servicio (
    id_apartamento INT,
    id_servicio INT,
    PRIMARY KEY (id_apartamento, id_servicio),
    FOREIGN KEY (id_apartamento) REFERENCES Apartamento(id_apartamento),
    FOREIGN KEY (id_servicio) REFERENCES Servicio(id_servicio)
);

-- Tabla Pago (relación con Propietario)
CREATE TABLE Pago (
    id_pago INT PRIMARY KEY,
    monto DECIMAL(10,2) NOT NULL,
    fecha DATE NOT NULL,
    id_propietario INT NOT NULL,
    FOREIGN KEY (id_propietario) REFERENCES Propietario(id_propietario)
);

-- Tabla Beneficio
CREATE TABLE Beneficio (
    id_beneficio INT PRIMARY KEY,
    descripcion VARCHAR(50) NOT NULL,
    monto DECIMAL(8,2) NOT NULL
);

-- Tabla Propietario_Beneficio (relación muchos a muchos)
CREATE TABLE Propietario_Beneficio (
    id_propietario INT,
    id_beneficio INT,
    PRIMARY KEY (id_propietario, id_beneficio),
    FOREIGN KEY (id_propietario) REFERENCES Propietario(id_propietario),
    FOREIGN KEY (id_beneficio) REFERENCES Beneficio(id_beneficio)
);

-- Insertar datos en Apartamento
INSERT INTO Apartamento VALUES 
(1, 'A101', 1, 80.50, 'Disponible'),
(2, 'B203', 2, 95.75, 'Ocupado');

-- Insertar datos en Propietario
INSERT INTO Propietario VALUES 
(1, 'Laura Martínez', 'laura@correo.com'),
(2, 'Pedro Ruiz', 'pedro@correo.com');

-- Insertar datos en Servicio
INSERT INTO Servicio VALUES 
(1, 'Limpieza', 150.00),
(2, 'Seguridad', 200.00);

-- Relacionar apartamentos con servicios
INSERT INTO Apartamento_Servicio VALUES (1, 1);
INSERT INTO Apartamento_Servicio VALUES (2, 2);

-- Insertar pagos asociados a propietarios
INSERT INTO Pago VALUES 
(1, 500.00, '2025-05-01', 1),
(2, 750.00, '2025-05-01', 2);

-- Insertar beneficios
INSERT INTO Beneficio VALUES 
(1, 'Descuento por pronto pago', 50.00),
(2, 'Acceso al gimnasio', 30.00);

-- Relacionar propietarios con beneficios
INSERT INTO Propietario_Beneficio VALUES (1, 1);
INSERT INTO Propietario_Beneficio VALUES (2, 2);

-- Actualizar área del apartamento 1
UPDATE Apartamento SET area_m2 = 85.00 WHERE id_apartamento = 1;

-- ALTER TABLE: agregar nueva columna "valor_predial"
ALTER TABLE Apartamento ADD valor_predial DECIMAL(10,2);
ALTER TABLE Apartamento ADD id_propietario INT FOREIGN KEY REFERENCES Propietario(id_propietario);

-- Eliminar un propietario correctamente evitando errores de referencia
DELETE FROM Propietario_Beneficio WHERE id_propietario = 2;
DELETE FROM Pago WHERE id_propietario = 2;
DELETE FROM Propietario WHERE id_propietario = 2;

-- Consulta con JOIN: muestra el apartamento y su servicio asignado
SELECT 
    a.numero AS apartamento, 
    s.tipo_servicio AS servicio
FROM Apartamento a
JOIN Apartamento_Servicio aps ON a.id_apartamento = aps.id_apartamento
JOIN Servicio s ON aps.id_servicio = s.id_servicio;

-- Subconsulta: apartamentos con área mayor al promedio
SELECT numero FROM Apartamento 
WHERE area_m2 > (SELECT AVG(area_m2) FROM Apartamento);

-- Funciones agregadas

-- AVG (Promedio): calcular el área promedio de los apartamentos
SELECT AVG(area_m2) AS area_promedio FROM Apartamento;

-- MAX (Máximo): obtener el pago más alto registrado
SELECT MAX(monto) AS pago_maximo FROM Pago;

-- MIN (Mínimo): encontrar el pago más bajo registrado
SELECT MIN(monto) AS pago_minimo FROM Pago;

-- SUM (Suma): total de todos los pagos realizados
SELECT SUM(monto) AS total_pagado FROM Pago;

-- Crear vista de apartamentos con sus servicios
CREATE VIEW Vista_Apartamentos_Servicios AS
SELECT 
    a.numero AS apartamento, 
    s.tipo_servicio AS servicio
FROM Apartamento a
JOIN Apartamento_Servicio aps ON a.id_apartamento = aps.id_apartamento
JOIN Servicio s ON aps.id_servicio = s.id_servicio;

-- TRUNCATE: borrar todos los datos de la tabla Pago
TRUNCATE TABLE Pago;

-- DROP: eliminar tablas en orden correcto
DROP TABLE Apartamento_Servicio;
DROP TABLE Propietario_Beneficio;
DROP TABLE Pago;
DROP TABLE Beneficio;
DROP TABLE Servicio;
DROP TABLE Apartamento;
DROP TABLE Propietario;

-- Borrar la base de datos
DROP DATABASE ConjuntoApartamentos;

-- RESUMEN DE FUNCIONES Y COMANDOS SQL UTILIZADOS:

-- AVG (Promedio): Se utilizó 1 vez para obtener el promedio de área de apartamentos
-- MAX (Máximo): Se utilizó 1 vez para obtener el pago más alto registrado
-- MIN (Mínimo): Se utilizó 1 vez para obtener el pago más bajo registrado
-- SUM (Suma): Se utilizó 1 vez para obtener el total de pagos realizados