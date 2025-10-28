-- =========================================================
-- tiempo.sql (versión SQL Server)
-- Configuración de tiempo y tamaño de operaciones grandes
-- =========================================================
USE master;
GO

-- Habilitar opciones avanzadas
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
GO

-- Aumentar el tamaño máximo de paquetes de red (máximo 2 GB)
EXEC sp_configure 'network packet size', 32767;  -- en bytes (máximo permitido)
RECONFIGURE;
GO

-- Ajustar tiempo de espera de conexiones remotas
EXEC sp_configure 'remote query timeout', 28800;  -- 8 horas (en segundos)
RECONFIGURE;
GO

-- Ajustar timeout de consultas locales (solo aplica a tiempo de ejecución en cliente)
-- Nota: SQL Server no tiene wait_timeout global como MySQL; 
-- se define en el nivel de conexión del cliente (por ejemplo, en la cadena de conexión).
-- Para simularlo en entornos de prueba:
SET LOCK_TIMEOUT 28800000;  -- 8 horas (en milisegundos)
GO


DROP DATABASE CafeteriaDigital;


