-- ===========================================
-- PROCEDIMIENTO: InsertarDatosMasivos_Rapido (PostgreSQL)
-- ===========================================

DROP PROCEDURE IF EXISTS InsertarDatosMasivos_Rapido(INTEGER);

CREATE OR REPLACE PROCEDURE InsertarDatosMasivos_Rapido(p_cantidad INT)
LANGUAGE plpgsql
AS $$
BEGIN
    -- ============================================================
    -- 1. MÉTODOS DE PAGO
    -- ============================================================
    DELETE FROM metodo_pago;
    INSERT INTO metodo_pago (tipo)
    SELECT 'Metodo_' || g
    FROM generate_series(1, p_cantidad) AS g;

    -- ============================================================
    -- 2. EMPLEADOS
    -- ============================================================
    DELETE FROM empleados;
    INSERT INTO empleados (nombre_empleado, cargo, salario)
    SELECT 
        'Empleado_' || g,
        CASE (g % 5)
            WHEN 0 THEN 'Barista'
            WHEN 1 THEN 'Cajero'
            WHEN 2 THEN 'Gerente'
            WHEN 3 THEN 'Mesero'
            ELSE 'Supervisor'
        END,
        1000000 + FLOOR(RANDOM() * 2000000)
    FROM generate_series(1, p_cantidad) AS g;

    -- ============================================================
    -- 3. PRODUCTOS
    -- ============================================================
    DELETE FROM productos;
    INSERT INTO productos (nombre_pro, categoria, precio)
    SELECT 
        'Producto_' || g,
        CASE (g % 3)
            WHEN 0 THEN 'Bebida'
            WHEN 1 THEN 'Comida'
            ELSE 'Postre'
        END,
        ROUND((1000 + RANDOM() * 9000)::numeric, 2)  -- ✅ CAST a numeric
    FROM generate_series(1, p_cantidad) AS g;

    -- ============================================================
    -- 4. CLIENTES
    -- ============================================================
    DELETE FROM clientes;
    INSERT INTO clientes (nombre_cliente, email, telefono, puntos)
    SELECT 
        'Cliente_' || g,
        'cliente' || g || '@mail.com',
        LPAD(g::TEXT, 10, '0'),
        FLOOR(RANDOM() * 500)
    FROM generate_series(1, p_cantidad) AS g;

    -- ============================================================
    -- 5. INVENTARIO
    -- ============================================================
    DELETE FROM inventario;
    INSERT INTO inventario (id_producto, stock)
    SELECT p.id_producto, FLOOR(RANDOM() * 500) + 50
    FROM productos p
    ORDER BY RANDOM()
    LIMIT p_cantidad;

    -- ============================================================
    -- 6. PEDIDOS
    -- ============================================================
    DELETE FROM pedidos;
    INSERT INTO pedidos (id_cliente, id_empleado, fecha_pedido, estado)
    SELECT 
        c.id_cliente, 
        e.id_empleado,
        NOW() - (INTERVAL '1 day' * FLOOR(RANDOM() * 30)),
        CASE FLOOR(RANDOM() * 3)
            WHEN 0 THEN 'Pendiente'
            WHEN 1 THEN 'Preparando'
            ELSE 'Entregado'
        END
    FROM clientes c
    JOIN empleados e ON TRUE
    ORDER BY RANDOM()
    LIMIT p_cantidad;

    -- ============================================================
    -- 7. DETALLE DE PEDIDO
    -- ============================================================
    DELETE FROM detalle_pedido;
    INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad, subtotal)
    SELECT 
        p.id_pedido,
        pr.id_producto,
        q.cantidad,
        (pr.precio * q.cantidad)::numeric(10,2)
    FROM pedidos p
    JOIN productos pr ON TRUE
    JOIN (
        SELECT FLOOR(1 + RANDOM() * 5) AS cantidad FROM generate_series(1, p_cantidad)
    ) q ON TRUE
    ORDER BY RANDOM()
    LIMIT p_cantidad;

    -- ============================================================
    -- 8. PAGOS
    -- ============================================================
    DELETE FROM pago;
    INSERT INTO pago (id_pedido, id_metodo, monto, fecha_pago)
    SELECT 
        pe.id_pedido,
        m.id_metodo,
        ROUND((1000 + RANDOM() * 9000)::numeric, 2),
        NOW()
    FROM pedidos pe
    JOIN metodo_pago m ON TRUE
    ORDER BY RANDOM()
    LIMIT p_cantidad;

    -- ============================================================
    -- 9. AUDITORÍA
    -- ============================================================
    DELETE FROM auditoria;
    INSERT INTO auditoria (descripcion, fecha)
    SELECT 
        'Registro número ' || g || ' insertado correctamente.',
        NOW()
    FROM generate_series(1, p_cantidad) AS g;

    RAISE NOTICE '✅ Inserción masiva rápida completada correctamente con % registros por tabla.', p_cantidad;
END;
$$;

-- ===========================================
-- EJECUTAR EL PROCEDIMIENTO
-- ===========================================
CALL InsertarDatosMasivos_Rapido(1000);


SELECT * FROM clientes;
