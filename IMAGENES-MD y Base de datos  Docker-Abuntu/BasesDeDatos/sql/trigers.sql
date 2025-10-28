USE CafeteriaDigital;
GO
    
-------------------------------------------------------------
-- Trigger: Actualizar inventario después de insertar detalle
-------------------------------------------------------------
IF OBJECT_ID('tr_actualizar_inventario', 'TR') IS NOT NULL
    DROP TRIGGER tr_actualizar_inventario;
GO

CREATE TRIGGER tr_actualizar_inventario
ON detalle_pedido
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE i
    SET i.stock = i.stock - d.cantidad
    FROM inventario i
    INNER JOIN inserted d ON i.id_producto = d.id_producto;
END;
GO

-------------------------------------------------------------
-- Trigger: Registrar auditoría al eliminar producto
-------------------------------------------------------------
IF OBJECT_ID('tr_registro_auditoria_eliminar_producto', 'TR') IS NOT NULL
    DROP TRIGGER tr_registro_auditoria_eliminar_producto;
GO

CREATE TRIGGER tr_registro_auditoria_eliminar_producto
ON productos
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO auditoria (descripcion, fecha)
    SELECT CONCAT('Producto eliminado: ', d.nombre_pro), GETDATE()
    FROM deleted d;
END;
GO

-------------------------------------------------------------
-- Trigger: Calcular puntos del cliente al registrar pago
-------------------------------------------------------------
IF OBJECT_ID('tr_calcular_puntos_cliente', 'TR') IS NOT NULL
    DROP TRIGGER tr_calcular_puntos_cliente;
GO

CREATE TRIGGER tr_calcular_puntos_cliente
ON pago
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE c
    SET c.puntos = c.puntos + (i.monto / 1000)
    FROM clientes c
    INNER JOIN pedidos p ON c.id_cliente = p.id_cliente
    INNER JOIN inserted i ON p.id_pedido = i.id_pedido;
END;
GO

-------------------------------------------------------------
-- Trigger: Registrar auditoría al cambiar estado a "Entregado"
-------------------------------------------------------------
IF OBJECT_ID('tr_auditoria_entrega', 'TR') IS NOT NULL
    DROP TRIGGER tr_auditoria_entrega;
GO

CREATE TRIGGER tr_auditoria_entrega
ON pedidos
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO auditoria (descripcion, fecha)
    SELECT CONCAT('Pedido entregado: ', i.id_pedido), GETDATE()
    FROM inserted i
    INNER JOIN deleted d ON i.id_pedido = d.id_pedido
    WHERE i.estado = 'Entregado' AND d.estado <> 'Entregado';
END;
GO
