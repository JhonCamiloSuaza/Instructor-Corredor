
--Conexión a Bases de Datos en Docker — Guía Explicada

--Este documento explica cómo crear contenedores de MySQL, SQL Server, PostgreSQL y MongoDB** con Docker, y cómo conectarse a cada gestor desde dentro del contenedor.

--  MySQL

-- Crear el contenedor MySQL

--bash
--docker run -d --name mysql -e MYSQL_ROOT_PASSWORD="camilo123!" -p3309:3306 mysql:latest

-- Explicación del comando

Parte  Significado 

 `docker run`  Crea un contenedor nuevo 
 `-d`  Ejecuta en segundo plano 
 `--name mysql`  Nombre del contenedor 
 `-e MYSQL_ROOT_PASSWORD="camilo123!"`  Variable de entorno: password para usuario root 
 `-p3309:3306`  Mapea puerto: Host 3309 → Contenedor 3306 
 `mysql:latest`  Imagen oficial de MySQL 

 Conexión a MySQL desde dentro del contenedor:

bash
docker exec -it mysql mysql -u root -p

Ingresas la contraseña:
camilo123!


-- SQL Server

--Crear el contenedor SQL Server 

--bash
--docker run -d --name sqlserver -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=camilo123!" -p 1464:1433 mcr.microsoft.com/mssql/server:2022-latest

 Explicación del comando

 Parte  Significado 

 `-e "ACCEPT_EULA=Y"`  Aceptar la licencia de uso 
 `-e "SA_PASSWORD=camilo123!"`  Contraseña del usuario administrador `SA` 
 `-p 1464:1433`  Puerto Host 1464 → Puerto SQL Server 
 Imagen oficial de SQL Server 2022 Docker 

 Conexión desde dentro del contenedor:

--bash
docker exec -it sqlserver /opt/mssql-tools18/bin/sqlcmd -S localhost -U SA -P "camilo123!" -C


 Opción  Explicación 

 `-S localhost`  Servidor dentro del contenedor 
 `-U SA`  Usuario admin 
 `-P "camilo123!"`  Contraseña 
 `-C`  Confiar certificado SSL 



-- PostgreSQL

-- Crear el contenedor PostgreSQL

--bash
docker run -d --name postgres -e POSTGRES_USER=admin -e POSTGRES_PASSWORD=camilo123! -e POSTGRES_DB=mi_base -p 5480:5432 postgres:latest

 Explicación del comando

 Parte  Función 

 `POSTGRES_USER=admin`  Usuario principal 
 `POSTGRES_PASSWORD=...`  Contraseña 
 `POSTGRES_DB=mi_base`  Base de datos inicial 
 `-p 5480:5432`  Puerto Host 5480  PostgreSQL 

 Conexión:

--bash
docker exec -it postgres psql -U admin

Ingresarás directamente a PostgreSQL CLI.



-- MongoDB

-- Crear contenedor MongoDB

--bash
--docker run -d --name mongo -e MONGO_INITDB_ROOT_USERNAME=camilo -e MONGO_INITDB_ROOT_PASSWORD=camilo123! -p 27017:27017 mongo:latest


 Explicación del comando

 Parte  Función 

 `MONGO_INITDB_ROOT_USERNAME`  Crea usuario administrador 
 `MONGO_INITDB_ROOT_PASSWORD`  Password administrador 
 `-p 27017:27017`  Puerto Host ↔ Contenedor (27017) 
 `mongo:latest`  Imagen oficial MongoDB 

--Conexión:

--bash
--docker exec -it mongo mongosh -u camilo -p camilo123!


-- Nota: El usuario `root` en MongoDB es el mismo usuario creado con `MONGO_INITDB_ROOT_USERNAME`



--  Resumen de Conexiones desde el Host

 Base de datos  Usuario  Puerto Host  Cliente recomend. 

 MySQL  root 3309  DBeaver  MySQL Workbench 
 SQL Server  SA  1464  SSMS  Azure Data Studio 
 PostgreSQL  admin  5480  pgAdmin  DBeaver 
 MongoDB  camilo  27017  MongoDB Compass 
