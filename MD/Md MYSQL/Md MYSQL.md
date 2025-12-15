Aprendiz: Jhon Camilo Suaza Sánchez

Ficha:3145555

Acá entramos para ejecutar la base de datos desde consola con MYSQL

conectar correctamente desde Docker:

docker exec -it mysql-db mysql -u root -p

la contraseña

camilo123!

![](Aspose.Words.42164edc-a731-4621-a6c4-80133b5dc702.001.png) 






Acá se empieza a crear la base de datos desde consola con MYSQL

Creación de la base de datos desde consola en MYSQL

![](Aspose.Words.42164edc-a731-4621-a6c4-80133b5dc702.002.png)

Creación de las tablas ![](Aspose.Words.42164edc-a731-4621-a6c4-80133b5dc702.003.png)









Creacion de las tablas

![](Aspose.Words.42164edc-a731-4621-a6c4-80133b5dc702.004.png)

Ver tablas creadas en la base de datos

![](Aspose.Words.42164edc-a731-4621-a6c4-80133b5dc702.005.png)


Ya acá se empieza a ejecutar los INSERT que era 1.000 por cada tabla creada de la base de datos 

![](Aspose.Words.42164edc-a731-4621-a6c4-80133b5dc702.006.png)

![](Aspose.Words.42164edc-a731-4621-a6c4-80133b5dc702.007.png)

Después de hacer ese mismo proceso para todas las tablas que ya quedaron con su 1.000 registro se empieza a ejecutar las consultas 







**Consulta**

Acá ya se empieza las consultas, la 1 es Mostrar stands con su empresa

![](Aspose.Words.42164edc-a731-4621-a6c4-80133b5dc702.008.png)

La 2 es Mostrar pabellones con sus stands

![](Aspose.Words.42164edc-a731-4621-a6c4-80133b5dc702.009.png)

La 3 Mostrar empresas con sus productos

![](Aspose.Words.42164edc-a731-4621-a6c4-80133b5dc702.010.png)



La 4 Muestra los visitantes y los eventos (charlas) a los que asistieron

![](Aspose.Words.42164edc-a731-4621-a6c4-80133b5dc702.011.png)












**Subconsultas**

Charlas que existen en la feria

![](Aspose.Words.42164edc-a731-4621-a6c4-80133b5dc702.012.png)

Pabellones con stands

![](Aspose.Words.42164edc-a731-4621-a6c4-80133b5dc702.013.png)

Empresas que participan en alguna charla

![](Aspose.Words.42164edc-a731-4621-a6c4-80133b5dc702.014.png)


Visitantes inscritos en alguna charla![](Aspose.Words.42164edc-a731-4621-a6c4-80133b5dc702.015.png)

**Acá se empieza ya con el tema de roles y contraseña![](Aspose.Words.42164edc-a731-4621-a6c4-80133b5dc702.016.png)**

Explicación

USAR LA BASE DE DATOS

USE FeriaGeneral;

CREAR USUARIOS (equivalente a los logins)

CREATE USER 'UsuarioLectura'@'%' IDENTIFIED BY 'Lectura123\*';

CREATE USER 'UsuarioEscritura'@'%' IDENTIFIED BY 'Escritura123\*';


` `CREAR ROLES (solo funciona desde MySQL 8.0 en adelante)

CREATE ROLE 'RolLectura';

CREATE ROLE 'RolEscritura';

ASIGNAR PRIVILEGIOS A LOS ROLES

Rol de solo lectura

GRANT SELECT ON FeriaGeneral.\* TO 'RolLectura';

Rol de lectura y escritura

GRANT SELECT, INSERT, UPDATE, DELETE ON FeriaGeneral.\* TO 'RolEscritura';

ASIGNAR LOS ROLES A LOS USUARIOS

GRANT 'RolLectura' TO 'UsuarioLectura';

GRANT 'RolEscritura' TO 'UsuarioEscritura'; 

![](Aspose.Words.42164edc-a731-4621-a6c4-80133b5dc702.017.png)

` `ACTIVAR LOS ROLES POR DEFECTO (para que se activen al iniciar sesión)

SET DEFAULT ROLE ALL TO 'UsuarioLectura', 'UsuarioEscritura';


APLICAR CAMBIOS

FLUSH PRIVILEGES;



![](Aspose.Words.42164edc-a731-4621-a6c4-80133b5dc702.018.png)

Luego verifica que se crearon correctamente:

SELECT user, host FROM mysql.user;

SHOW GRANTS FOR 'UsuarioLectura'@'%';

SHOW GRANTS FOR 'UsuarioEscritura'@'%';




Acá lo que miramos es que ejecute el comando para poder mirar las tablas y la cantidad la cual nos dice en cada tabla el nombre y al lado la cantidad de datos insertados.![](Aspose.Words.42164edc-a731-4621-a6c4-80133b5dc702.019.png)
