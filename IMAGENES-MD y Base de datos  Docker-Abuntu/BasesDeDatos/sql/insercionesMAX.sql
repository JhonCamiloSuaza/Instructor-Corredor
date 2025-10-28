USE CafeteriaDigital;
GO


IF OBJECT_ID('InsertarDatosMasivos', 'P') IS NOT NULL
    DROP PROCEDURE InsertarDatosMasivos;
GO

CREATE PROCEDURE InsertarDatosMasivos
    @Cantidad INT = 1000
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE 
        @i INT = 1,
        @cliente_id INT,
        @empleado_id INT,
        @producto_id INT,
        @pedido_id INT,
        @metodo_id INT,
        @cantidad_producto INT,
        @precio DECIMAL(10,2),
        @subtotal DECIMAL(10,2),
        @monto_total DECIMAL(10,2);

    -- ============================================================
    -- MÉTODOS DE PAGO (1000 registros)
    -- ============================================================
    IF NOT EXISTS (SELECT 1 FROM metodo_pago)
    BEGIN
        PRINT 'Insertando 1000 métodos de pago...';
        SET @i = 1;
        WHILE @i <= @Cantidad
        BEGIN
            INSERT INTO metodo_pago (tipo)
            VALUES (CONCAT('Metodo_', @i));
            SET @i += 1;
        END
    END

    -- ============================================================
    -- EMPLEADOS (1000 registros)
    -- ============================================================
    IF NOT EXISTS (SELECT 1 FROM empleados)
    BEGIN
        PRINT 'Insertando 1000 empleados...';
        SET @i = 1;
        WHILE @i <= @Cantidad
        BEGIN
            INSERT INTO empleados (nombre_empleado, cargo, salario)
            VALUES (
                CONCAT('Empleado_', @i),
                CASE (@i % 5)
                    WHEN 0 THEN 'Barista'
                    WHEN 1 THEN 'Cajero'
                    WHEN 2 THEN 'Gerente'
                    WHEN 3 THEN 'Mesero'
                    ELSE 'Supervisor'
                END,
                1000000 + (ABS(CHECKSUM(NEWID())) % 2000000)
            );
            SET @i += 1;
        END
    END

    -- ============================================================
    -- PRODUCTOS (1000 registros)
    -- ============================================================
    IF NOT EXISTS (SELECT 1 FROM productos)
    BEGIN
        PRINT 'Insertando 1000 productos...';
        SET @i = 1;
        WHILE @i <= @Cantidad
        BEGIN
            INSERT INTO productos (nombre_pro, categoria, precio)
            VALUES (
                CONCAT('Producto_', @i),
                CASE (@i % 3)
                    WHEN 0 THEN 'Bebida'
                    WHEN 1 THEN 'Comida'
                    ELSE 'Postre'
                END,
                CAST(1000 + (ABS(CHECKSUM(NEWID())) % 9000) AS DECIMAL(10,2))
            );
            SET @i += 1;
        END
    END

    -- ============================================================
    -- CLIENTES (1000 registros)
    -- ============================================================
    PRINT 'Insertando 1000 clientes...';
    SET @i = 1;
    WHILE @i <= @Cantidad
    BEGIN
        INSERT INTO clientes (nombre_cliente, email, telefono, puntos)
        VALUES (
            CONCAT('Cliente_', @i),
            CONCAT('cliente', @i, '@mail.com'),
            RIGHT(REPLICATE('0', 10) + CAST(@i AS VARCHAR(10)), 10),
            ABS(CHECKSUM(NEWID()) % 500)
        );
        SET @i += 1;
    END

    -- ============================================================
    -- INVENTARIO (1000 registros)
    -- ============================================================
    PRINT 'Insertando inventario...';
    DELETE FROM inventario;
    INSERT INTO inventario (id_producto, stock)
    SELECT TOP (@Cantidad) id_producto, (ABS(CHECKSUM(NEWID())) % 500) + 50
    FROM productos;

    -- ============================================================
    -- PEDIDOS, DETALLES, PAGOS y AUDITORÍA (1000 registros)
    -- ============================================================
    PRINT 'Insertando pedidos, detalles, pagos y auditoría...';
    SET @i = 1;
    WHILE @i <= @Cantidad
    BEGIN
        -- Cliente y empleado aleatorio
        SELECT TOP 1 @cliente_id = id_cliente FROM clientes ORDER BY NEWID();
        SELECT TOP 1 @empleado_id = id_empleado FROM empleados ORDER BY NEWID();

        -- Crear pedido
        INSERT INTO pedidos (id_cliente, id_empleado, fecha_pedido, estado)
        VALUES (
            @cliente_id,
            @empleado_id,
            DATEADD(DAY, -ABS(CHECKSUM(NEWID()) % 30), GETDATE()),
            CASE WHEN @i % 3 = 0 THEN 'Pendiente'
                 WHEN @i % 3 = 1 THEN 'Preparando'
                 ELSE 'Entregado' END
        );

        SET @pedido_id = SCOPE_IDENTITY();

        -- Insertar entre 1 y 3 productos
        DECLARE @n INT = 1, @max INT = 1 + ABS(CHECKSUM(NEWID()) % 3);
        WHILE @n <= @max
        BEGIN
            SELECT TOP 1 @producto_id = id_producto, @precio = precio 
            FROM productos ORDER BY NEWID();

            SET @cantidad_producto = 1 + ABS(CHECKSUM(NEWID()) % 5);
            SET @subtotal = @precio * @cantidad_producto;

            INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad, subtotal)
            VALUES (@pedido_id, @producto_id, @cantidad_producto, @subtotal);

            SET @n += 1;
        END

        -- Calcular monto total del pedido
        SELECT @monto_total = SUM(subtotal)
        FROM detalle_pedido WHERE id_pedido = @pedido_id;

        -- Crear pago
        SELECT TOP 1 @metodo_id = id_metodo FROM metodo_pago ORDER BY NEWID();
        INSERT INTO pago (id_pedido, id_metodo, monto, fecha_pago)
        VALUES (@pedido_id, @metodo_id, @monto_total, GETDATE());

        -- Auditoría
        INSERT INTO auditoria (descripcion, fecha)
        VALUES (CONCAT('Pedido ', @pedido_id, ' generado para Cliente ', @cliente_id), GETDATE());

        SET @i += 1;
    END

    PRINT '✅ Inserción masiva completada correctamente.';
END;
GO

-- Ejecutar
EXEC InsertarDatosMasivos @Cantidad = 1000;
GO

