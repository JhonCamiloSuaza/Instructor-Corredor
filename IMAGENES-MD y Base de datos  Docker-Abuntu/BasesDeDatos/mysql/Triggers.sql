
USE CafeteriaDigital;

DELIMITER //

CREATE TRIGGER tr_actualizar_inventario
AFTER INSERT ON detalle_pedido
FOR EACH ROW
BEGIN
    UPDATE inventario
    SET stock = stock - NEW.cantidad
    WHERE id_producto = NEW.id_producto;
END;
//

CREATE TRIGGER tr_registro_auditoria_eliminar_producto
AFTER DELETE ON productos
FOR EACH ROW
BEGIN
    INSERT INTO auditoria (descripcion) VALUES (CONCAT('Producto eliminado: ', OLD.nombre_pro));
END;
//

CREATE TRIGGER tr_calcular_puntos_cliente
AFTER INSERT ON pago
FOR EACH ROW
BEGIN
    DECLARE id_cli INT;
    SELECT id_cliente INTO id_cli FROM pedidos WHERE id_pedido = NEW.id_pedido;
    UPDATE clientes SET puntos = puntos + (NEW.monto / 1000) WHERE id_cliente = id_cli;
END;
//

CREATE TRIGGER tr_auditoria_entrega
AFTER UPDATE ON pedidos
FOR EACH ROW
BEGIN
    IF NEW.estado = 'Entregado' THEN
        INSERT INTO auditoria (descripcion) VALUES (CONCAT('Pedido entregado: ', NEW.id_pedido));
    END IF;
END;
//

DELIMITER ;
