USE CafeteriaDigital;

DELIMITER $$

DROP PROCEDURE IF EXISTS InsertarDatosMasivos_Rapido $$

CREATE PROCEDURE InsertarDatosMasivos_Rapido(IN p_Cantidad INT)
BEGIN
    SET SQL_SAFE_UPDATES = 0;

    -- 1. MÉTODOS DE PAGO
    DELETE FROM metodo_pago;
    INSERT INTO metodo_pago (tipo)
    SELECT CONCAT('Metodo_', t.n)
    FROM (
        SELECT @row := @row + 1 AS n FROM
        (SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL
         SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) a,
        (SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL
         SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) b,
        (SELECT @row := 0) r
        LIMIT p_Cantidad
    ) AS t;

    -- 2. EMPLEADOS
    DELETE FROM empleados;
    INSERT INTO empleados (nombre_empleado, cargo, salario)
    SELECT CONCAT('Empleado_', t.n),
           CASE (t.n % 5)
                WHEN 0 THEN 'Barista'
                WHEN 1 THEN 'Cajero'
                WHEN 2 THEN 'Gerente'
                WHEN 3 THEN 'Mesero'
                ELSE 'Supervisor'
           END,
           1000000 + FLOOR(RAND() * 2000000)
    FROM (
        SELECT @row2 := @row2 + 1 AS n FROM
        (SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL
         SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) a,
        (SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL
         SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) b,
        (SELECT @row2 := 0) r
        LIMIT p_Cantidad
    ) AS t;

    -- 3. PRODUCTOS
    DELETE FROM productos;
    INSERT INTO productos (nombre_pro, categoria, precio)
    SELECT CONCAT('Producto_', t.n),
           CASE (t.n % 3)
                WHEN 0 THEN 'Bebida'
                WHEN 1 THEN 'Comida'
                ELSE 'Postre'
           END,
           ROUND(1000 + RAND() * 9000, 2)
    FROM (
        SELECT @row3 := @row3 + 1 AS n FROM
        (SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL
         SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) a,
        (SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL
         SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) b,
        (SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL
         SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) c,
        (SELECT @row3 := 0) r
        LIMIT p_Cantidad
    ) AS t;

    -- 4. CLIENTES
    DELETE FROM clientes;
    INSERT INTO clientes (nombre_cliente, email, telefono, puntos)
    SELECT CONCAT('Cliente_', t.n),
           CONCAT('cliente', t.n, '@mail.com'),
           LPAD(t.n, 10, '0'),
           FLOOR(RAND() * 500)
    FROM (
        SELECT @row4 := @row4 + 1 AS n FROM
        (SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL
         SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) a,
        (SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL
         SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) b,
        (SELECT @row4 := 0) r
        LIMIT p_Cantidad
    ) AS t;

    -- INVENTARIO, PEDIDOS, DETALLES, PAGOS y AUDITORÍA
    -- Poblamos usando joins para generar aleatoriedad
    DELETE FROM inventario;
    INSERT INTO inventario (id_producto, stock)
    SELECT id_producto, FLOOR(RAND() * 500) + 50
    FROM productos
    ORDER BY RAND()
    LIMIT p_Cantidad;

    DELETE FROM pedidos;
    INSERT INTO pedidos (id_cliente, id_empleado, fecha_pedido, estado)
    SELECT c.id_cliente, e.id_empleado,
           DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 30) DAY),
           ELT(FLOOR(1 + (RAND() * 3)), 'Pendiente', 'Preparando', 'Entregado')
    FROM clientes c
    JOIN empleados e ON e.id_empleado = c.id_cliente
    ORDER BY RAND()
    LIMIT p_Cantidad;

    DELETE FROM detalle_pedido;
    INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad, subtotal)
    SELECT p.id_pedido, pr.id_producto,
           FLOOR(1 + RAND() * 5),
           pr.precio * FLOOR(1 + RAND() * 5)
    FROM pedidos p
    JOIN productos pr ON pr.id_producto = p.id_cliente
    ORDER BY RAND()
    LIMIT p_Cantidad;

    DELETE FROM pago;
    INSERT INTO pago (id_pedido, id_metodo, monto, fecha_pago)
    SELECT pe.id_pedido, m.id_metodo, ROUND(1000 + RAND() * 9000, 2), NOW()
    FROM pedidos pe
    JOIN metodo_pago m ON m.id_metodo = pe.id_pedido
    ORDER BY RAND()
    LIMIT p_Cantidad;

    DELETE FROM auditoria;
    INSERT INTO auditoria (descripcion, fecha)
    SELECT CONCAT('Registro número ', t.n, ' insertado correctamente.'), NOW()
    FROM (
        SELECT @row5 := @row5 + 1 AS n FROM
        (SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL
         SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) a,
        (SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL
         SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) b,
        (SELECT @row5 := 0) r
        LIMIT p_Cantidad
    ) AS t;

    SET SQL_SAFE_UPDATES = 1;

    SELECT 'Inserción masiva rápida completada correctamente con 1000 registros por tabla.' AS Resultado;
END $$

DELIMITER ;

-- Ejecutar
CALL InsertarDatosMasivos_Rapido(1000);



