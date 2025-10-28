USE feriaGeneral;
GO

-- Crear esquema
CREATE SCHEMA seguridad;
GO

-- Crear tablas
CREATE TABLE seguridad.Empresa(
    id_empresa INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);
GO

CREATE TABLE seguridad.Persona(
    id_persona INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    dni VARCHAR(100) UNIQUE,
    correo VARCHAR(50),
    telefono VARCHAR(50)
);
GO

CREATE TABLE seguridad.Log(
    id_log INT IDENTITY(1,1) PRIMARY KEY,
    usuario VARCHAR(30),
    fecha DATETIME DEFAULT GETDATE(),
    accion VARCHAR(50)
);
GO

-- Usuario normal 1
Use Master;
CREATE LOGIN UsuarioSeguridadLogin
WITH PASSWORD = 'Camilo123.'; -- contraseña segura
GO

CREATE USER UsuarioSeguridad
FOR LOGIN UsuarioSeguridadLogin;
GO

GRANT SELECT, INSERT, UPDATE, DELETE
ON SCHEMA::seguridad
TO UsuarioSeguridad;
GO

-- Usuario normal 2 (lola)
CREATE LOGIN lolitaseguridad
WITH PASSWORD = 'lola2025*'; -- contraseña segura
GO

CREATE USER lola
FOR LOGIN lolitaseguridad;
GO

GRANT SELECT, INSERT, UPDATE, DELETE
ON SCHEMA::seguridad
TO lola;
GO

-- Comprobar logins creados
SELECT name, is_disabled 
FROM sys.sql_logins
WHERE name IN ('UsuarioSeguridadLogin','lolitaseguridad');

-- Usuario administrador
CREATE LOGIN AdminSeguridadLogin
WITH PASSWORD = 'Camilo123.';
GO

CREATE USER AdminSeguridad FOR LOGIN AdminSeguridadLogin;
GO

ALTER SERVER ROLE sysadmin ADD MEMBER AdminSeguridadLogin; GO

