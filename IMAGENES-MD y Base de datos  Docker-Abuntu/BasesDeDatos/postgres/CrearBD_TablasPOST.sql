-- ================================================
-- CREACIÓN DE BASE DE DATOS Y TABLAS (PostgreSQL)
-- ================================================
CREATE DATABASE CafeteriaDigital;

CREATE TABLE clientes (
    id_cliente SERIAL PRIMARY KEY,
    nombre_cliente VARCHAR(100),
    email VARCHAR(100),
    telefono VARCHAR(20),
    puntos INT DEFAULT 0
);

CREATE TABLE empleados (
    id_empleado SERIAL PRIMARY KEY,
    nombre_empleado VARCHAR(100),
    cargo VARCHAR(50),
    salario NUMERIC(10,2)
);

CREATE TABLE productos (
    id_producto SERIAL PRIMARY KEY,
    nombre_pro VARCHAR(100),
    categoria VARCHAR(50),
    precio NUMERIC(10,2)
);

CREATE TABLE inventario (
    id_inventario SERIAL PRIMARY KEY,
    id_producto INT REFERENCES productos(id_producto),
    stock INT
);

CREATE TABLE pedidos (
    id_pedido SERIAL PRIMARY KEY,
    id_cliente INT REFERENCES clientes(id_cliente),
    id_empleado INT REFERENCES empleados(id_empleado),
    fecha_pedido TIMESTAMP DEFAULT NOW(),
    estado VARCHAR(20) DEFAULT 'Pendiente'
        CHECK (estado IN ('Pendiente','Preparando','Entregado'))
);

CREATE TABLE detalle_pedido (
    id_detalle SERIAL PRIMARY KEY,
    id_pedido INT REFERENCES pedidos(id_pedido),
    id_producto INT REFERENCES productos(id_producto),
    cantidad INT,
    subtotal NUMERIC(10,2)
);

CREATE TABLE metodo_pago (
    id_metodo SERIAL PRIMARY KEY,
    tipo VARCHAR(50)
);

CREATE TABLE pago (
    id_pago SERIAL PRIMARY KEY,
    id_pedido INT REFERENCES pedidos(id_pedido),
    id_metodo INT REFERENCES metodo_pago(id_metodo),
    monto NUMERIC(10,2),
    fecha_pago TIMESTAMP DEFAULT NOW()
);

CREATE TABLE auditoria (
    id_auditoria SERIAL PRIMARY KEY,
    descripcion TEXT,
    fecha TIMESTAMP DEFAULT NOW()
);
