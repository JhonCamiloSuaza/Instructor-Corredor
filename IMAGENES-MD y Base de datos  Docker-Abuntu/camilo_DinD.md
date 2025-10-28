
--Guía Didáctica DinD (Docker in Docker)

Esta guía explica paso a paso cómo crear y configurar un entorno **Docker dentro de Docker (DinD)** en Ubuntu 22.04.  

--1. Crear el contenedor base

--bash
docker run -it --name ubuntu_DinD --privileged -v /var/run/docker.sock:/var/run/docker.sock ubuntu:22.04

Explicación

  --\`docker run\`: crea y ejecuta un contenedor nuevo.  
-- \`-it\`: combina \`-i\` (modo interactivo) + \`-t\` (asigna una terminal).  
  --\`--name ubuntu_DinD\`: le da un nombre al contenedor.  
-- \`--privileged\`: otorga permisos extendidos para ejecutar Docker dentro del contenedor.  
 --\`-v /var/run/docker.sock:/var/run/docker.sock\`: usa el Docker del host dentro del contenedor.  
-- \`ubuntu:22.04\`: imagen base.



-- 2. Instalar herramientas de red

--bash
apt-get install -y iproute2 iputils-ping net-tools

Explicación
 Herramientas de red como \`ip\`, \`ping\` y \`ifconfig\`.


-- 3. Actualizar e instalar herramientas básicas

--bash
--apt-get update
apt-get install -y ca-certificates curl gnupg lsb-release

Toca asegura que el sistema pueda descargar software seguro.



-- 4. Instalar Netcat y crear rutas necesarias

--bash
apt-get install -y netcat
mkdir -p /etc/apt/keyrings
mkdir -p /etc/apt/sources.list.d
chmod a+r /etc/apt/keyrings/docker.gpg

Netcat sirve para probar puertos.


-- 5. Descargar clave GPG de Docker

bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

Permite verificar los paquetes del repositorio.

-- 6. Añadir el repositorio oficial de Docker

bash
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null


Con esto Ubuntu sabrá dónde instalar Docker correctamente.

--7. Instalar Docker dentro del contenedor

bash
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io

Instala el motor de Docker y sus herramientas CLI.


-- 8. Permisos de acceso al socket Docker

bash
chmod 666 /var/run/docker.sock


Permite ejecutar comandos Docker sin ser root.


--9. Crear contenedores de bases de datos

-- MySQL

bash
docker run -d --name mysql-db -e MYSQL_ROOT_PASSWORD=camilo123! -p 3390:3306 mysql:latest
apt-get install -y mysql-client
mysql -h 172.17.0.1 -P 3390 -u root -p


Acceso al contenedor desde dentro de Ubuntu.



 -- PostgreSQL
bash
docker run -d --name postgres-db -e POSTGRES_PASSWORD=camilo123! -p 5491:5432 postgres:latest
apt-get install -y postgresql-client
psql -h 172.17.0.1 -p 5491 -U postgres


Conexión usando \`psql\`.



-- SQL Server

bash
docker run -d --name sqlServer -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=camilo123!' -p 1490:1433 mcr.microsoft.com/mssql/server:2019-latest


Instalación de herramientas para conectarse: bash
apt-get install -y mssql-tools unixodbc-dev

Conexión mediante \`sqlcmd\`.



-- MongoDB

bash
docker run -d --name mongo-db -p 27090:27017 mongo:latest
apt install -y mongodb-mongosh
mongosh --host 172.17.0.1 --port 27090


Cliente instalado para conexión.



-- 10. Probar conexión a los puertos

bash
nc -zv 172.17.0.1 3390
nc -zv 172.17.0.1 5490
nc -zv 172.17.0.1 1490
nc -zv 172.17.0.1 27090


Asegura que las bases de datos están accesibles.



Puedes volver a entrar en el contenedor con:

\`\`\`bash
docker start -ai ubuntu_DinD
\`\`\`