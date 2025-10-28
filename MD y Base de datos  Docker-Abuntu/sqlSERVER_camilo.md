
--Script Markdown - Configuración de Repositorio Microsoft SQL Server

Este documento explica los comandos necesarios para agregar la llave GPG y el repositorio oficial de **Microsoft SQL Server 2022** en Ubuntu 22.04.



  Crear el directorio para las claves GPG

bash
mkdir -p /etc/apt/keyrings


 Crea la carpeta donde almacenaremos claves GPG usadas para verificar repositorios externos.  
El parámetro `-p` evita errores si la carpeta ya existe.



--Descargar la clave GPG de Microsoft y almacenarla en formato seguro

bash
curl -sSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /etc/apt/keyrings/microsoft.gpg


 Parte  Función 

 `curl -sSL`  Descarga silenciosa desde la web 
 URL  Dirección oficial de la clave de Microsoft 
 `|`  Pasa la salida al siguiente comando 
 `gpg --dearmor`  Convierte la clave de formato ASCII a binario (.gpg) 
 `-o /etc/apt/keyrings/microsoft.gpg`  Guarda la clave en la ubicación correcta 

 Esto asegura que los paquetes de Microsoft sean --confiables y validados.



-- Registrar el repositorio oficial de SQL Server 2022

bash
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022 jammy main"   > /etc/apt/sources.list.d/mssql-server-2022.list


-- Explicación de componentes:

 Componente  Propósito 

 `echo "deb ..."`  Agrega la línea del nuevo repositorio 
 `arch=amd64`  Define arquitectura compatible 
 `signed-by=/etc/apt/keyrings/microsoft.gpg`  Verificación obligatoria con la clave descargada 
 `https://packages.microsoft.com/...`  Dirección del repositorio oficial 
ammy main`  Versión de Ubuntu: 22.04 
 `> /etc/apt/sources.list.d/...`  Guarda el repo en archivo nuevo del sistema 


 Siguiente paso recomendado:

```bash
apt-get update
apt-get install -y mssql-server
```




