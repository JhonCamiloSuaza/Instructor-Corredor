CREATE DATABASE CafeteriaDigital;
GO

USE CafeteriaDigital;
GO


CREATE TABLE clientes (
    id_cliente INT IDENTITY(1,1) PRIMARY KEY,
    nombre_cliente VARCHAR(100),
    email VARCHAR(100),
    telefono VARCHAR(20),
    puntos INT DEFAULT 0
);
GO

CREATE TABLE empleados (
    id_empleado INT IDENTITY(1,1) PRIMARY KEY,
    nombre_empleado VARCHAR(100),
    cargo VARCHAR(50),
    salario DECIMAL(10,2)
);
GO

CREATE TABLE productos (
    id_producto INT IDENTITY(1,1) PRIMARY KEY,
    nombre_pro VARCHAR(100),
    categoria VARCHAR(50),
    precio DECIMAL(10,2)
);
GO

CREATE TABLE inventario (
    id_inventario INT IDENTITY(1,1) PRIMARY KEY,
    id_producto INT,
    stock INT,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);
GO

CREATE TABLE pedidos (
    id_pedido INT IDENTITY(1,1) PRIMARY KEY,
    id_cliente INT,
    id_empleado INT,
    fecha_pedido DATETIME DEFAULT GETDATE(),
    estado VARCHAR(20) DEFAULT 'Pendiente' CHECK (estado IN ('Pendiente','Preparando','Entregado')),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado)
);
GO

CREATE TABLE detalle_pedido (
    id_detalle INT IDENTITY(1,1) PRIMARY KEY,
    id_pedido INT,
    id_producto INT,
    cantidad INT,
    subtotal DECIMAL(10,2),
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);
GO

CREATE TABLE metodo_pago (
    id_metodo INT IDENTITY(1,1) PRIMARY KEY,
    tipo VARCHAR(50)
);
GO

CREATE TABLE pago (
    id_pago INT IDENTITY(1,1) PRIMARY KEY,
    id_pedido INT,
    id_metodo INT,
    monto DECIMAL(10,2),
    fecha_pago DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_metodo) REFERENCES metodo_pago(id_metodo)
);
GO

CREATE TABLE auditoria (
    id_auditoria INT IDENTITY(1,1) PRIMARY KEY,
    descripcion TEXT,
    fecha DATETIME DEFAULT GETDATE()
);
GO
