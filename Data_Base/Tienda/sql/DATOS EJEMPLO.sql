-- EJEMPLOS DE DATOS

INSERT INTO CATEGORIA (id_categoria, nombre, decripcion) VALUES
(1, 'Electrónica', 'Dispositivos y accesorios electrónicos.'),
(2, 'Ropa', 'Artículos de vestimenta y moda.'),
(3, 'Hogar y Cocina', 'Utensilios, decoración y electrodomésticos para el hogar.'),
(4, 'Libros', 'Literatura, novelas y material de estudio.'),
(5, 'Deportes', 'Equipamiento y ropa deportiva.');

INSERT INTO CLIENTE (id_cliente, nombre, apellido, email, telefono) VALUES
(1, 'Ana', 'Gómez', 'ana.gomez@mail.com', '3001234567'),
(2, 'Luis', 'Martínez', 'luis.martinez@mail.com', '3109876543'),
(3, 'Sofía', 'Rodríguez', 'sofia.r@mail.com', '3205551122'),
(4, 'Carlos', 'Pérez', 'carlos.p@mail.com', '3014443322'),
(5, 'Marta', 'López', 'marta.lopez@mail.com', '3157778899'),
(6, 'Javier', 'Díaz', 'javier.d@mail.com', '3041110000'),
(7, 'Elena', 'Sánchez', 'elena.s@mail.com', '3212223344'),
(8, 'Diego', 'Torres', 'diego.t@mail.com', '3139998877'),
(9, 'Laura', 'Ramírez', 'laura.r@mail.com', '3006665544'),
(10, 'Pablo', 'Vargas', 'pablo.v@mail.com', '3183332211');

INSERT INTO DIRECCION (id_direccion, ciudad, codigo_postal, departamento, d_especificada) VALUES
-- Direcciones para Clientes (id_direccion 1 al 10)
(1, 'Bogotá', '110111', 'Cundinamarca', 'Calle 10 # 5-20, Apartamento 301'),
(2, 'Medellín', '050010', 'Antioquia', 'Carrera 80 # 45-30, Casa 2'),
(3, 'Cali', '760042', 'Valle del Cauca', 'Avenida 6N # 25-15, Oficina 405'),
(4, 'Barranquilla', '080001', 'Atlántico', 'Calle 72 # 50-80, Local 10'),
(5, 'Cartagena', '130001', 'Bolívar', 'Barrio Bocagrande, Carrera 3 # 8-50'),
(6, 'Bucaramanga', '680001', 'Santander', 'Calle 36 # 15-40, Apto 5B'),
(7, 'Pereira', '660001', 'Risaralda', 'Avenida Circunvalar # 3-10'),
(8, 'Santa Marta', '470001', 'Magdalena', 'Carrera 1 # 22-05'),
(9, 'Manizales', '170001', 'Caldas', 'Calle 65 # 23-45'),
(10, 'Cúcuta', '540001', 'Norte de Santander', 'Avenida 0 # 11-90'),

-- Direcciones para Inventario/Almacenes (id_direccion 11 al 20)
(11, 'Bogotá', '110111', 'Cundinamarca', 'Bodega Central, Zona Franca'),
(12, 'Medellín', '050010', 'Antioquia', 'Almacén Principal, Itagüí'),
(13, 'Cali', '760042', 'Valle del Cauca', 'Punto de Distribución Sur'),
(14, 'Barranquilla', '080001', 'Atlántico', 'Centro Logístico 3'),
(15, 'Cartagena', '130001', 'Bolívar', 'Bodega Turística'),
(16, 'Bucaramanga', '680001', 'Santander', 'Depósito Industrial'),
(17, 'Pereira', '660001', 'Risaralda', 'Mini Almacén Eje Cafetero'),
(18, 'Santa Marta', '470001', 'Magdalena', 'Bodega Zona Portuaria'),
(19, 'Manizales', '170001', 'Caldas', 'Almacén de Altura'),
(20, 'Cúcuta', '540001', 'Norte de Santander', 'Punto Fronterizo');

INSERT INTO METODO_PAGO (id_metodo, tipo, detalles_pago) VALUES
(1, 'Tarjeta', 'Pago con tarjeta de crédito/débito'),
(2, 'Efectivo', 'Pago contra entrega en efectivo'),
(3, 'Otro', 'Transferencia bancaria');

INSERT INTO PRODUCTO (id_producto, nombre, descripcion, precio, estado, id_categoria) VALUES
-- Electrónica (id_categoria 1)
(1, 'Smartphone X10', 'Teléfono móvil de última generación', 850.00, 'En Stock', 1),
(2, 'Audífonos Bluetooth', 'Auriculares inalámbricos con cancelación de ruido', 120.50, 'En Stock', 1),
(3, 'Smartwatch Pro', 'Reloj inteligente con monitor de salud', 250.99, 'En Stock', 1),
(4, 'Power Bank 20000mAh', 'Cargador portátil de alta capacidad', 45.00, 'En Stock', 1),

-- Ropa (id_categoria 2)
(5, 'Camiseta Algodón Azul', 'Camiseta básica de algodón orgánico', 35.00, 'En Stock', 2),
(6, 'Pantalón Jeans Clásico', 'Pantalón vaquero corte recto', 79.99, 'En Stock', 2),
(7, 'Chaqueta Impermeable', 'Chaqueta ligera para lluvia', 110.00, 'En Stock', 2),
(8, 'Zapatillas Deportivas', 'Calzado ligero para running', 95.00, 'Sin Stock', 2),

-- Hogar y Cocina (id_categoria 3)
(9, 'Cafetera Programable', 'Máquina para hacer café con temporizador', 65.50, 'En Stock', 3),
(10, 'Set de Ollas x5', 'Juego de ollas de acero inoxidable', 150.00, 'En Stock', 3),
(11, 'Aspiradora Robótica', 'Robot aspirador con mapeo láser', 320.00, 'En Stock', 3),
(12, 'Mesa Auxiliar Madera', 'Mesa pequeña para sala o estudio', 90.00, 'En Stock', 3),

-- Libros (id_categoria 4)
(13, 'El Señor de los Anillos', 'Novela de fantasía épica', 25.00, 'En Stock', 4),
(14, 'Cien Años de Soledad', 'Obra maestra de Gabriel García Márquez', 20.00, 'En Stock', 4),
(15, 'Programación en SQL', 'Libro técnico sobre bases de datos', 40.00, 'En Stock', 4),
(16, 'Historia Universal', 'Libro de texto para estudiantes', 30.00, 'En Stock', 4),

-- Deportes (id_categoria 5)
(17, 'Balón de Fútbol Profesional', 'Balón para juego profesional en cancha', 55.00, 'En Stock', 5),
(18, 'Esterilla de Yoga', 'Colchoneta antideslizante para ejercicios', 22.00, 'En Stock', 5),
(19, 'Bicicleta de Montaña', 'Bicicleta con suspensión y 21 velocidades', 450.00, 'En Stock', 5),
(20, 'Pesas Ajustables (Par)', 'Pesas de mancuernas con peso ajustable', 130.00, 'En Stock', 5);

INSERT INTO CARRITO (id_carrito, id_cliente) VALUES
(1, 1), -- Ana
(2, 3), -- Sofía
(3, 5), -- Marta
(4, 7), -- Elena
(5, 9); -- Laura

INSERT INTO INVENTARIO_PRODUCTO (id_inventario, id_producto) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 6), (7, 7), (8, 8), (9, 9), (10, 10),
(11, 11), (12, 12), (13, 13), (14, 14), (15, 15), (16, 16), (17, 17), (18, 18), (19, 19), (20, 20);

INSERT INTO DETALLE_INVENTARIO (id_detalle_inventario, id_inventario, stock, id_direccion) VALUES
(1, 1, 50, 11),  -- Smartphone X10 en Bodega Bogotá
(2, 2, 100, 11), -- Audífonos en Bodega Bogotá
(3, 3, 30, 12),  -- Smartwatch en Almacén Medellín
(4, 4, 200, 13), -- Power Bank en Punto Cali
(5, 5, 150, 14), -- Camiseta en Centro Logístico Barranquilla
(6, 6, 80, 14),  -- Jeans en Centro Logístico Barranquilla
(7, 7, 40, 15),  -- Chaqueta en Bodega Cartagena
(8, 8, 0, 15),   -- Zapatillas (Sin Stock) en Bodega Cartagena
(9, 9, 75, 16),  -- Cafetera en Depósito Bucaramanga
(10, 10, 60, 17), -- Ollas en Mini Almacén Pereira
(11, 11, 20, 18), -- Aspiradora en Bodega Santa Marta
(12, 12, 90, 19), -- Mesa en Almacén Manizales
(13, 13, 300, 20), -- El Señor de los Anillos en Punto Cúcuta
(14, 14, 250, 20), -- Cien Años de Soledad en Punto Cúcuta
(15, 15, 120, 11), -- Programación en SQL en Bodega Bogotá
(16, 16, 180, 12), -- Historia Universal en Almacén Medellín
(17, 17, 10, 13), -- Balón en Punto Cali
(18, 18, 110, 14), -- Esterilla en Centro Logístico Barranquilla
(19, 19, 5, 15),  -- Bicicleta en Bodega Cartagena
(20, 20, 25, 16); -- Pesas en Depósito Bucaramanga

INSERT INTO PEDIDO (id_pedido, fecha_pedido, estado, id_cliente, id_metodo, id_direccion) VALUES
(1, '2025-10-25 10:00:00', 'Finalizado', 1, 1, 1),    -- Ana, Tarjeta, Bogotá
(2, '2025-10-25 15:30:00', 'Finalizado', 2, 2, 2),    -- Luis, Efectivo, Medellín
(3, '2025-10-26 09:00:00', 'Pagado', 3, 1, 3),        -- Sofía, Tarjeta, Cali
(4, '2025-10-26 18:45:00', 'Cancelado', 4, 3, 4),     -- Carlos, Otro, Barranquilla
(5, '2025-10-27 11:20:00', 'Finalizado', 5, 2, 5),    -- Marta, Efectivo, Cartagena
(6, '2025-10-28 14:00:00', 'Pagado', 6, 1, 6),        -- Javier, Tarjeta, Bucaramanga
(7, '2025-10-28 20:10:00', 'Por pagar', 7, 2, 7),     -- Elena, Efectivo, Pereira
(8, '2025-10-29 10:30:00', 'Finalizado', 8, 3, 8),    -- Diego, Otro, Santa Marta
(9, '2025-10-29 16:50:00', 'Pagado', 9, 1, 9),        -- Laura, Tarjeta, Manizales
(10, '2025-10-30 08:00:00', 'Finalizado', 10, 2, 10), -- Pablo, Efectivo, Cúcuta
(11, '2025-10-30 12:00:00', 'Pagado', 1, 1, 1),
(12, '2025-10-31 17:30:00', 'Por pagar', 3, 3, 3),
(13, '2025-11-01 09:45:00', 'Finalizado', 5, 1, 5),
(14, '2025-11-01 13:15:00', 'Pagado', 7, 2, 7),
(15, '2025-11-02 18:00:00', 'Cancelado', 9, 1, 9);

INSERT INTO DETALLE_CARRITO (id_detalle_carrito, id_carrito, id_producto, cantidad) VALUES
-- Carrito 1 (Ana)
(1, 1, 1, 1),    -- 1 Smartphone
(2, 1, 5, 2),    -- 2 Camisetas

-- Carrito 2 (Sofía)
(3, 2, 9, 1),    -- 1 Cafetera
(4, 2, 14, 1),   -- 1 Cien Años de Soledad

-- Carrito 3 (Marta)
(5, 3, 2, 3),    -- 3 Audífonos
(6, 3, 20, 1),   -- 1 Pesas Ajustables

-- Carrito 4 (Elena)
(7, 4, 17, 2),   -- 2 Balones
(8, 4, 6, 1),    -- 1 Pantalón Jeans
(9, 4, 19, 1),   -- 1 Bicicleta

-- Carrito 5 (Laura)
(10, 5, 11, 1);  -- 1 Aspiradora Robótica

INSERT INTO DETALLE_PEDIDO (id_detalle_pedido, id_pedido, id_producto, cantidad) VALUES
-- Pedido 1 (Ana)
(1, 1, 1, 1),
(2, 1, 13, 1),

-- Pedido 2 (Luis)
(3, 2, 9, 1),
(4, 2, 18, 2),

-- Pedido 3 (Sofía)
(5, 3, 5, 3),

-- Pedido 4 (Carlos - Cancelado)
(6, 4, 8, 1), -- Producto sin stock (8)
(7, 4, 10, 1),

-- Pedido 5 (Marta)
(8, 5, 12, 2),

-- Pedido 6 (Javier)
(9, 6, 20, 1),
(10, 6, 4, 2),

-- Pedido 7 (Elena - Por pagar)
(11, 7, 17, 1),
(12, 7, 3, 1),

-- Pedido 8 (Diego)
(13, 8, 14, 1),
(14, 8, 16, 1),

-- Pedido 9 (Laura)
(15, 9, 7, 1),
(16, 9, 19, 1),

-- Pedido 10 (Pablo)
(17, 10, 15, 2),

-- Pedido 11 (Ana)
(18, 11, 2, 1),
(19, 11, 6, 1),

-- Pedido 12 (Sofía - Por pagar)
(20, 12, 11, 1),

-- Pedido 13 (Marta)
(21, 13, 5, 1),
(22, 13, 13, 1),

-- Pedido 14 (Elena)
(23, 14, 4, 3),

-- Pedido 15 (Laura - Cancelado)
(24, 15, 10, 1);


--AGREGAR CONTRASEÑAS 

UPDATE CLIENTE SET contrasena = 'P@ssw0rd1A' WHERE id_cliente = 1;
UPDATE CLIENTE SET contrasena = 'S3gur4K-2B' WHERE id_cliente = 2;
UPDATE CLIENTE SET contrasena = 'M1Cl4v3#3C' WHERE id_cliente = 3;
UPDATE CLIENTE SET contrasena = 'D4t0s_R4D' WHERE id_cliente = 4;
UPDATE CLIENTE SET contrasena = 'L0g1n*E5' WHERE id_cliente = 5;
UPDATE CLIENTE SET contrasena = 'A6CcfF!t' WHERE id_cliente = 6;
UPDATE CLIENTE SET contrasena = 'Ww7PpnL?' WHERE id_cliente = 7;
UPDATE CLIENTE SET contrasena = 'Zz8TtrM@' WHERE id_cliente = 8;
UPDATE CLIENTE SET contrasena = 'B9GghV#' WHERE id_cliente = 9;
UPDATE CLIENTE SET contrasena = 'K0XxyY$' WHERE id_cliente = 10;

