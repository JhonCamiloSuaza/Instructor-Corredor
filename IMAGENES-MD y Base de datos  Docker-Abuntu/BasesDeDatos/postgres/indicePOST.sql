-- =======================================================
-- Archivo: Indices_Postgres.sql
-- Propósito: Crear índices para optimizar la BD CafeteriaDigital
-- Motor: PostgreSQL
-- =======================================================

-- Asegurarse de estar en la base de datos correcta
-- (En pgAdmin, conéctate manualmente a CafeteriaDigital)

-- =======================================
-- Índices básicos
-- =======================================

-- Índice para búsqueda rápida por nombre de cliente
CREATE INDEX idx_clientes_nombre
ON clientes (nombre_cliente);

-- Índice para búsqueda rápida por email
CREATE UNIQUE INDEX idx_clientes_email
ON clientes (email);

-- Índice para búsqueda rápida por cargo de empleado
CREATE INDEX idx_empleados_cargo
ON empleados (cargo);

-- Índice para búsqueda rápida por categoría de producto
CREATE INDEX idx_productos_categoria
ON productos (categoria);

-- Índice para búsquedas combinadas de pedidos (cliente + estado)
CREATE INDEX idx_pedidos_cliente_estado
ON pedidos (id_cliente, estado);

-- Índice para fecha de pedido (consultas por rango de fechas)
CREATE INDEX idx_pedidos_fecha
ON pedidos (fecha_pedido);

-- Índice para optimizar JOIN en detalle_pedido
CREATE INDEX idx_detalle_pedido_producto
ON detalle_pedido (id_producto);

-- Índice para optimizar JOIN en inventario
CREATE INDEX idx_inventario_producto
ON inventario (id_producto);

-- Índice para optimizar consultas en pago por método
CREATE INDEX idx_pago_metodo
ON pago (id_metodo);

-- Índice para búsqueda por descripción en auditoría (solo si se usa mucho texto)
CREATE INDEX idx_auditoria_descripcion
ON auditoria USING GIN (to_tsvector('spanish', descripcion));

-- =======================================
-- Verificación de índices creados
-- =======================================
-- Puedes ejecutar esta consulta para listar todos los índices:
-- SELECT tablename, indexname, indexdef FROM pg_indexes WHERE schemaname = 'public';
