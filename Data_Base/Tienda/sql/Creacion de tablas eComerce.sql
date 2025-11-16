CREATE TABLE PRODUCTO(
    id_producto INT PRIMARY KEY,
    nombre VARCHAR(100),
    descripcion VARCHAR(255),
    precio FLOAT,
    estado VARCHAR(50),
    id_categoria INT
);

CREATE TABLE CLIENTE(
    id_cliente INT PRIMARY KEY,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    email VARCHAR(150),
    telefono VARCHAR(20),
    contrasena VARCHAR(100)
);

CREATE TABLE DIRECCION (
    id_direccion INT PRIMARY KEY,
    ciudad VARCHAR(100),
    codigo_postal VARCHAR(20),
    departamento VARCHAR(100),
    d_especificada VARCHAR(255)
);

CREATE TABLE CATEGORIA(
    id_categoria INT PRIMARY KEY,
    nombre VARCHAR(100),
    decripcion VARCHAR(255)
);

CREATE TABLE PEDIDO(
    id_pedido INT PRIMARY KEY,
    fecha_pedido TIMESTAMP,
    estado VARCHAR(50),
    id_cliente INT,
    id_metodo INT,
    id_direccion INT
);

CREATE TABLE DETALLE_PEDIDO(
    id_detalle_pedido INT PRIMARY KEY,
    id_pedido INT,
    id_producto INT,
    cantidad INT
);

CREATE TABLE METODO_PAGO(
    id_metodo INT PRIMARY KEY,
    tipo VARCHAR(50),
    detalles_pago VARCHAR(255)
);

CREATE TABLE CARRITO(
    id_carrito INT PRIMARY KEY,
    id_cliente INT
);

CREATE TABLE DETALLE_CARRITO(
    id_detalle_carrito INT PRIMARY KEY,
    id_carrito INT,
    id_producto INT,
    cantidad INT
);

CREATE TABLE INVENTARIO_PRODUCTO(
    id_inventario INT PRIMARY KEY,
    id_producto INT
);

CREATE TABLE DETALLE_INVENTARIO(
    id_detalle_inventario INT PRIMARY KEY,
    id_inventario INT,
    stock INT,
    id_direccion INT
);