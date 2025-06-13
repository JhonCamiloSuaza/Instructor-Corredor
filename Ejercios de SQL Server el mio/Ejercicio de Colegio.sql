-- Crear la base de datos
CREATE DATABASE Colegio;
USE Colegio;

-- Tabla Estudiante (sin el campo edad inicialmente)
CREATE TABLE Estudiante (
    id_estudiante INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(50) UNIQUE NOT NULL,
    grado VARCHAR(20)
);

-- Tabla Profesor
CREATE TABLE Profesor (
    id_profesor INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    especialidad VARCHAR(50)
);

-- Tabla Curso
CREATE TABLE Curso (
    id_curso INT PRIMARY KEY,
    nombre_curso VARCHAR(50),
    id_profesor INT,
    FOREIGN KEY (id_profesor) REFERENCES Profesor(id_profesor)
);

-- Tabla Asignatura
CREATE TABLE Asignatura (
    id_asignatura INT PRIMARY KEY,
    nombre_asignatura VARCHAR(50)
);

-- Relación muchos a muchos: Curso_Asignatura
CREATE TABLE Curso_Asignatura (
    id_curso INT,
    id_asignatura INT,
    PRIMARY KEY (id_curso, id_asignatura),
    FOREIGN KEY (id_curso) REFERENCES Curso(id_curso),
    FOREIGN KEY (id_asignatura) REFERENCES Asignatura(id_asignatura)
);

-- Tabla Matricula
CREATE TABLE Matricula (
    id_matricula INT PRIMARY KEY,
    id_estudiante INT,
    id_curso INT,
    fecha DATE NOT NULL,
    FOREIGN KEY (id_estudiante) REFERENCES Estudiante(id_estudiante),
    FOREIGN KEY (id_curso) REFERENCES Curso(id_curso)
);

-- Tabla Nota
CREATE TABLE Nota (
    id_nota INT PRIMARY KEY,
    id_matricula INT,
    nota DECIMAL(3,1) CHECK (nota BETWEEN 0 AND 5),
    FOREIGN KEY (id_matricula) REFERENCES Matricula(id_matricula)
);

-- Insertar datos
INSERT INTO Estudiante VALUES 
(1, 'Ana Torres', 'ana@colegio.com', '10A'),
(2, 'Luis Ríos', 'luis@colegio.com', '11B');

INSERT INTO Profesor VALUES 
(1, 'Carlos Mendoza', 'Matemáticas'),
(2, 'Laura Gómez', 'Ciencias');

INSERT INTO Curso VALUES 
(1, 'Álgebra', 1),
(2, 'Biología', 2);

INSERT INTO Asignatura VALUES 
(1, 'Ecuaciones'),
(2, 'Células');

INSERT INTO Curso_Asignatura VALUES (1, 1), (2, 2);

INSERT INTO Matricula VALUES 
(1, 1, 1, '2025-02-01'),
(2, 2, 2, '2025-02-01');

INSERT INTO Nota VALUES 
(1, 1, 4.5),
(2, 2, 3.8);

-- Actualizar nota
UPDATE Nota SET nota = 4.8 WHERE id_nota = 1;

-- Eliminar una matrícula (eliminamos la nota primero para evitar error de integridad referencial)
DELETE FROM Nota WHERE id_matricula = 2;
DELETE FROM Matricula WHERE id_matricula = 2;

-- Consulta con JOIN: muestra nombre, curso y nota
SELECT 
    e.nombre AS estudiante, 
    c.nombre_curso, 
    n.nota
FROM Nota n
JOIN Matricula m ON n.id_matricula = m.id_matricula
JOIN Estudiante e ON m.id_estudiante = e.id_estudiante
JOIN Curso c ON m.id_curso = c.id_curso;

-- AVG (average / promedio): obtener estudiantes con nota superior al promedio general
SELECT nombre FROM Estudiante
WHERE id_estudiante IN (
    SELECT m.id_estudiante  
    FROM Nota n
    JOIN Matricula m ON n.id_matricula = m.id_matricula
    WHERE nota > (SELECT AVG(nota) FROM Nota)
);

-- AVG (average / promedio): calcular el promedio de notas agrupadas por curso
SELECT 
    c.nombre_curso, 
    AVG(n.nota) AS promedio
FROM Nota n
JOIN Matricula m ON n.id_matricula = m.id_matricula
JOIN Curso c ON m.id_curso = c.id_curso
GROUP BY c.nombre_curso;

-- Crear vista de estudiantes con cursos y notas
CREATE VIEW Vista_Estudiantes_Notas AS
SELECT 
    e.nombre AS estudiante, 
    c.nombre_curso, 
    n.nota
FROM Estudiante e
JOIN Matricula m ON e.id_estudiante = m.id_estudiante
JOIN Curso c ON m.id_curso = c.id_curso
JOIN Nota n ON n.id_matricula = m.id_matricula;

-- ALTER: agregar campo edad a la tabla Estudiante
ALTER TABLE Estudiante ADD edad INT;

-- TRUNCATE: elimina todos los datos de la tabla Nota pero mantiene su estructura
TRUNCATE TABLE Nota;

-- DROP: eliminar tablas en el orden correcto para evitar errores por llaves foráneas
DROP TABLE Curso_Asignatura;
DROP TABLE Nota;
DROP TABLE Matricula;
DROP TABLE Curso;
DROP TABLE Profesor;
DROP TABLE Asignatura;
DROP TABLE Estudiante;

-- AVG (average / promedio): Se utilizó 2 veces en el código