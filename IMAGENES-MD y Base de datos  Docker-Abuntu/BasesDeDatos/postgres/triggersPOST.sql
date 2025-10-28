-- ================================================
-- TRIGGERS (PostgreSQL)
-- ================================================

-- Trigger 1: Actualizar inventario después de insertar detalle_pedido
CREATE OR REPLACE FUNCTION tr_actualizar_inventario_func()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE inventario
    SET stock = stock - NEW.cantidad
    WHERE id_producto = NEW.id_producto;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_actualizar_inventario
AFTER INSERT ON detalle_pedido
FOR EACH ROW EXECUTE FUNCTION tr_actualizar_inventario_func();


-- Trigger 2: Registrar auditoría al eliminar producto
CREATE OR REPLACE FUNCTION tr_registro_auditoria_eliminar_producto_func()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO auditoria (descripcion, fecha)
    VALUES (CONCAT('Producto eliminado: ', OLD.nombre_pro), NOW());
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_registro_auditoria_eliminar_producto
AFTER DELETE ON productos
FOR EACH ROW EXECUTE FUNCTION tr_registro_auditoria_eliminar_producto_func();


-- Trigger 3: Calcular puntos del cliente al registrar pago
CREATE OR REPLACE FUNCTION tr_calcular_puntos_cliente_func()
RETURNS TRIGGER AS $$
DECLARE
    id_cli INT;
BEGIN
    SELECT id_cliente INTO id_cli FROM pedidos WHERE id_pedido = NEW.id_pedido;
    UPDATE clientes SET puntos = puntos + (NEW.monto / 1000) WHERE id_cliente = id_cli;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_calcular_puntos_cliente
AFTER INSERT ON pago
FOR EACH ROW EXECUTE FUNCTION tr_calcular_puntos_cliente_func();


-- Trigger 4: Registrar auditoría al cambiar estado a "Entregado"
CREATE OR REPLACE FUNCTION tr_auditoria_entrega_func()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.estado = 'Entregado' AND OLD.estado IS DISTINCT FROM 'Entregado' THEN
        INSERT INTO auditoria (descripcion, fecha)
        VALUES (CONCAT('Pedido entregado: ', NEW.id_pedido), NOW());
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_auditoria_entrega
AFTER UPDATE ON pedidos
FOR EACH ROW EXECUTE FUNCTION tr_auditoria_entrega_func();
