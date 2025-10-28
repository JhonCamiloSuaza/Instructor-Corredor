
USE CafeteriaDigital;

CREATE INDEX idx_nombre_producto ON productos(nombre_pro);
CREATE INDEX idx_categoria_producto ON productos(categoria);
CREATE INDEX idx_fecha_pedido ON pedidos(fecha_pedido);
CREATE INDEX idx_cliente_pedido ON pedidos(id_cliente);
CREATE INDEX idx_producto_detalle ON detalle_pedido(id_producto);
