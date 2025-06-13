-- Crear la base de datos
CREATE DATABASE Empresa;
USE Empresa;

-- Tabla Empleado 
CREATE TABLE Empleado (
    id_empleado INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(50) UNIQUE NOT NULL,
    salario DECIMAL(10,2) NOT NULL
);

-- Tabla Departamento 
CREATE TABLE Departamento (
    id_departamento INT PRIMARY KEY,
    nombre_departamento VARCHAR(50) NOT NULL
);

-- Tabla Proyecto 
CREATE TABLE Proyecto (
    id_proyecto INT PRIMARY KEY,
    nombre_proyecto VARCHAR(50) NOT NULL,
    presupuesto DECIMAL(12,2) NOT NULL
);

-- Tabla Empleado_Proyecto (relación muchos a muchos, )
CREATE TABLE Empleado_Proyecto (
    id_empleado INT,
    id_proyecto INT,
    PRIMARY KEY (id_empleado, id_proyecto),
    FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado),
    FOREIGN KEY (id_proyecto) REFERENCES Proyecto(id_proyecto)
);

-- Tabla Pago 
CREATE TABLE Pago (
    id_pago INT PRIMARY KEY,
    monto DECIMAL(10,2) NOT NULL,
    fecha DATE NOT NULL
);

-- Tabla Beneficio 
CREATE TABLE Beneficio (
    id_beneficio INT PRIMARY KEY,
    nombre_beneficio VARCHAR(50) NOT NULL,
    monto DECIMAL(8,2) NOT NULL
);

-- Tabla Empleado_Beneficio (relación muchos a muchos, )
CREATE TABLE Empleado_Beneficio (
    id_empleado INT,
    id_beneficio INT,
    PRIMARY KEY (id_empleado, id_beneficio),
    FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado),
    FOREIGN KEY (id_beneficio) REFERENCES Beneficio(id_beneficio)
);

-- Insertar datos en Empleado
INSERT INTO Empleado VALUES 
(1, 'Carlos Pérez', 'carlos@empresa.com', 4500.00),
(2, 'Ana Gómez', 'ana@empresa.com', 5200.00);

-- Insertar datos en Departamento
INSERT INTO Departamento VALUES 
(1, 'Recursos Humanos'),
(2, 'Desarrollo');

-- Insertar datos en Proyecto
INSERT INTO Proyecto VALUES 
(1, 'Nueva App', 150000.00),
(2, 'Expansión Web', 200000.00);

-- Relacionar empleados con proyectos
INSERT INTO Empleado_Proyecto VALUES (1, 1);
INSERT INTO Empleado_Proyecto VALUES (2, 2);

-- Insertar pagos
INSERT INTO Pago VALUES 
(1, 2500.00, '2025-05-01'),
(2, 2800.00, '2025-05-01');

-- Insertar beneficios
INSERT INTO Beneficio VALUES 
(1, 'Bono anual', 1000.00),
(2, 'Seguro médico', 500.00);

-- Relacionar empleados con beneficios
INSERT INTO Empleado_Beneficio VALUES (1, 1);
INSERT INTO Empleado_Beneficio VALUES (2, 2);

-- Actualizar salario de un empleado
UPDATE Empleado SET salario = 4800.00 WHERE id_empleado = 1;

-- Eliminar un empleado correctamente evitando errores de referencia
DELETE FROM Empleado_Proyecto WHERE id_empleado = 2;
DELETE FROM Empleado_Beneficio WHERE id_empleado = 2;
DELETE FROM Pago WHERE id_pago = 2;
DELETE FROM Empleado WHERE id_empleado = 2;

-- Consulta con JOIN: muestra empleado y su proyecto asignado
SELECT 
    e.nombre AS empleado, 
    p.nombre_proyecto AS proyecto
FROM Empleado e
JOIN Empleado_Proyecto ep ON e.id_empleado = ep.id_empleado
JOIN Proyecto p ON ep.id_proyecto = p.id_proyecto;

-- Subconsulta: empleados con salario superior al promedio
SELECT nombre FROM Empleado 
WHERE salario > (SELECT AVG(salario) FROM Empleado);

-- Funciones agregadas
-- AVG (average / promedio): calcular el salario promedio de los empleados
SELECT AVG(salario) AS salario_promedio FROM Empleado;

-- MAX (máximo): obtener el salario más alto entre los empleados
SELECT MAX(salario) AS salario_maximo FROM Empleado;

-- MIN (mínimo): encontrar el salario más bajo
SELECT MIN(salario) AS salario_minimo FROM Empleado;

-- SUM (suma): calcular el total de pagos realizados
SELECT SUM(monto) AS total_pagos FROM Pago;

-- Crear vista de empleados con sus proyectos asignados
CREATE VIEW Vista_Empleados_Proyectos AS
SELECT 
    e.nombre AS empleado, 
    p.nombre_proyecto AS proyecto
FROM Empleado e
JOIN Empleado_Proyecto ep ON e.id_empleado = ep.id_empleado
JOIN Proyecto p ON ep.id_proyecto = p.id_proyecto;

-- ALTER: agregar columna edad a Empleado
ALTER TABLE Empleado ADD edad INT;

-- TRUNCATE: borrar datos de Pago 
TRUNCATE TABLE Pago;

-- DROP: eliminar tablas en el orden correcto para evitar errores de dependencia
DROP TABLE Empleado_Proyecto;
DROP TABLE Empleado_Beneficio;
DROP TABLE Pago;
DROP TABLE Beneficio;
DROP TABLE Proyecto;
DROP TABLE Empleado;
DROP TABLE Departamento;

-- Borrar la base de datos
DROP DATABASE Empresa;

-- AVG (average / promedio): Se utilizó 2 veces en el código
-- MAX (máximo): Se utilizó 1 vez en el código
-- MIN (mínimo): Se utilizó 1 vez en el código
-- SUM (suma): Se utilizó 1 vez en el código