-- Trabajo de Johan Acero Salazar 

-- Mer 1 Clinica 

-- CREAR BASE DE DATOS
CREATE DATABASE Clinica;
USE Clinica;

-- CREACIÓN DE TABLAS


-- Tabla Paciente: almacena información personal de los pacientes de la clínica
CREATE TABLE Paciente (
    id_paciente INT PRIMARY KEY,
    nombre VARCHAR(100),
    fecha_nacimiento DATE
);


-- Tabla Doctor: guarda datos de los doctores que trabajan en la clínica, incluyendo su especialidad
CREATE TABLE Doctor (
    id_doctor INT PRIMARY KEY,
    nombre VARCHAR(100),
    especialidad VARCHAR(100)
);

--Le falto agregar id_paciente INT y id_doctor INT
CREATE TABLE Cita (
   id_Cita  INT PRIMARY KEY,
   id_paciente INT,
   id_doctor INT,
   Fecha DATE ,
   motivo VARCHAR (100),
   FOREIGN KEY  (id_Paciente) REFERENCES Paciente (id_Paciente),
   FOREIGN KEY (id_doctor) REFERENCES Doctor (id_Doctor)                                          
);
-- le falto id_cita INT,
-- Tabla Tratamiento: contiene los tratamientos asignados a cada cita médica
CREATE TABLE Tratamiento (
    id_tratamiento INT PRIMARY KEY,
    id_cita INT,
    medicamento VARCHAR(100),
    descripcion TEXT,
    FOREIGN KEY (id_cita) REFERENCES Cita(id_cita)
);

-- INSERCIÓN DE DATOS


-- Insertar pacientes
INSERT INTO Paciente VALUES
(1, 'Juan Perez', '1990-05-15'),
(2, 'Carlos Ruiz', '2005-02-10'),
(3, 'Valentina Gutierrez', '1996-01-01');


-- Insertar doctores
INSERT INTO Doctor VALUES
(101, 'Dra. Laura', 'Pediatria'),
(102, 'Dr. Mario', 'Cardiologia'),
(103, 'Dra. Silvia', 'Dermatologia');


-- Insertar citas médicas
INSERT INTO Cita VALUES
(201, 1, 102, '2025-04-10', 'Dolor en el pecho'),
(202, 2, 101, '2025-05-25', 'Chequeo pediatrico del hijo'),
(203, 3, 103, '2025-05-27', 'Irritacion en piel');


-- Insertar tratamientos
INSERT INTO Tratamiento VALUES
(301, 201, 'Aspirina 100mg', 'Aspirina por 5 dias'),
(302, 202, 'Vitamina infantil', 'Control de crecimiento'),
(303, 203, 'Hidrocortisona 1%', 'Aplicar crema 2 veces al dia');



-- ACTUALIZACIONES Y ELIMINACIONES


-- Actualizar nombre de un paciente
UPDATE Paciente SET nombre = 'Luis Alberto' WHERE id_paciente = 1;


-- Actualizar fecha de una cita
UPDATE Cita SET fecha = '2025-06-18' WHERE id_cita = 203;


-- Consultar nombres de doctores restantes
SELECT nombre FROM Doctor;


-- Consultar nombres y fechas de nacimiento de los pacientes
SELECT nombre, fecha_nacimiento FROM Paciente;


 


SELECT P. nombre, D. nombre, C. Fecha 
FROM Cita C 
 JOIN Paciente P ON C. id_paciente = P.id_paciente
JOIN Doctor  D ON C. id_doctor = D. id_doctor;

-- Primero eliminar tratamientos relacionados con citas del doctor 101
DELETE FROM Tratamiento
WHERE id_cita IN (SELECT id_cita FROM Cita WHERE id_doctor = 101);


-- Luego eliminar citas del doctor 101
DELETE FROM Cita WHERE id_doctor = 101;
-- Eliminar un tratamiento específico (ejemplo)
DELETE FROM Tratamiento WHERE medicamento = 'Aspirina 100mg';

-- CONSULTAS

    ALTER TABLE Paciente ADD edad INT;
    ALTER TABLE Doctor DROP COLUMN especialidad;

/*se deben de eliminar las tablas en orden

    TRUNCATE TABLE Cita;
    TRUNCATE TABLE Doctor;
    */
   
TRUNCATE TABLE Tratamiento;  

   
   
   DROP TABLE Tratamiento ;
  /* no se puede usar 
  Hay procesos en ejecución que la están utilizando
   DROP DATABASE Clinica;
   */ 













