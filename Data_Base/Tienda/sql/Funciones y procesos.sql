--CRUD BASICOS




--CREAR PRODUCTO

CREATE OR REPLACE PROCEDURE sp_crear_producto(
    p_id_producto INT,
    p_nombre VARCHAR,
    p_descripcion VARCHAR,
    p_precio FLOAT,
    p_estado VARCHAR, -- Dominio 'estado'
    p_id_categoria INT
)
LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO PRODUCTO (id_producto, nombre, descripcion, precio, estado, id_categoria)
    VALUES (p_id_producto, p_nombre, p_descripcion, p_precio, p_estado, p_id_categoria);
END;
$$;

--CREAR CATEGORIA

CREATE OR REPLACE PROCEDURE sp_crear_categoria(
    p_id_categoria INT,
    p_nombre VARCHAR,
    p_descripcion VARCHAR
)
LANGUAGE plpgsql AS $$
BEGIN
    -- Nota: Tu tabla usa 'decripcion' (con 'c')
    INSERT INTO CATEGORIA (id_categoria, nombre, decripcion)
    VALUES (p_id_categoria, p_nombre, p_descripcion);
END;
$$;

--CREAR(AÑADIR DIRECCION)

CREATE OR REPLACE PROCEDURE sp_crear_direccion(
    p_id_direccion INT,
    p_ciudad VARCHAR,
    p_codigo_postal VARCHAR,
    p_departamento VARCHAR,
    p_d_especificada VARCHAR
)
LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO DIRECCION (id_direccion, ciudad, codigo_postal, departamento, d_especificada)
    VALUES (p_id_direccion, p_ciudad, p_codigo_postal, p_departamento, p_d_especificada);
END;
$$;

--CREAR CLIENTE 

CREATE OR REPLACE PROCEDURE sp_crear_cliente(
    p_id_cliente INT,
    p_nombre VARCHAR,
    p_apellido VARCHAR,
    p_email VARCHAR,
    p_telefono VARCHAR -- Dominio 'telefono'
)
LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO CLIENTE (id_cliente, nombre, apellido, email, telefono)
    VALUES (p_id_cliente, p_nombre, p_apellido, p_email, p_telefono);
END;
$$;

--CREAR METODO DE PAGO

CREATE OR REPLACE PROCEDURE sp_crear_metodo_pago(
    p_id_metodo INT,
    p_tipo VARCHAR, -- Dominio 'tipo_pago'
    p_detalles_pago VARCHAR
)
LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO METODO_PAGO (id_metodo, tipo, detalles_pago)
    VALUES (p_id_metodo, p_tipo, p_detalles_pago);
END;
$$;


--CREAR UN CARRITO CON UN PRODUCTO MINIMO 

CREATE OR REPLACE PROCEDURE sp_crear_carrito_con_producto(
    p_id_carrito INT,
    p_id_cliente INT,
    p_id_detalle_carrito INT,
    p_id_producto INT,
    p_cantidad INT
)
LANGUAGE plpgsql AS $$
BEGIN
    -- 1. Crear el carrito
    INSERT INTO CARRITO (id_carrito, id_cliente)
    VALUES (p_id_carrito, p_id_cliente);
    
    -- 2. Añadir el primer producto
    INSERT INTO DETALLE_CARRITO (id_detalle_carrito, id_carrito, id_producto, cantidad)
    VALUES (p_id_detalle_carrito, p_id_carrito, p_id_producto, p_cantidad);
END;
$$;

--AGREGAR PRODUCTOS AL CARRITO

CREATE OR REPLACE PROCEDURE sp_agregar_producto_carrito(
    p_id_detalle_carrito INT,
    p_id_carrito INT,
    p_id_producto INT,
    p_cantidad INT
)
LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO DETALLE_CARRITO (id_detalle_carrito, id_carrito, id_producto, cantidad)
    VALUES (p_id_detalle_carrito, p_id_carrito, p_id_producto, p_cantidad);
END;
$$;

--CREAR PEDIDO (COPIANDO CARRITO)




--AÑADIR INVENTARIO (CON DIRECCION CANTIDAD Y PRODUCTO)

CREATE OR REPLACE PROCEDURE sp_crear_stock_en_direccion(
    p_id_detalle_inventario INT,
    p_id_inventario INT, -- (El que corresponde al producto desde INVENTARIO_PRODUCTO)
    p_stock INT,         -- Dominio 'cantidad_stock'
    p_id_direccion INT
)
LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO DETALLE_INVENTARIO (id_detalle_inventario, id_inventario, stock, id_direccion)
    VALUES (p_id_detalle_inventario, p_id_inventario, p_stock, p_id_direccion);
END;
$$;


--ELIMINACION

--ELIMINAR USUARIO

CREATE OR REPLACE PROCEDURE sp_eliminar_cliente_con_dependencias(
    p_id_cliente INT
)
LANGUAGE plpgsql AS $$
DECLARE
    v_filas_afectadas INT;
BEGIN
    -- 1. Eliminar detalles de carritos
    -- Busca los carritos del cliente (id_carrito) y borra sus detalles.
    DELETE FROM DETALLE_CARRITO
    WHERE id_carrito IN (SELECT id_carrito FROM CARRITO WHERE id_cliente = p_id_cliente);
    
    GET DIAGNOSTICS v_filas_afectadas = ROW_COUNT;
    RAISE NOTICE 'Se eliminaron % filas de DETALLE_CARRITO.', v_filas_afectadas;

    -- 2. Eliminar carritos
    -- Ahora que los detalles están limpios, borra los carritos del cliente.
    DELETE FROM CARRITO
    WHERE id_cliente = p_id_cliente;
    
    GET DIAGNOSTICS v_filas_afectadas = ROW_COUNT;
    RAISE NOTICE 'Se eliminaron % filas de CARRITO.', v_filas_afectadas;

    -- 3. Eliminar detalles de pedidos
    -- Busca los pedidos del cliente (id_pedido) y borra sus detalles.
    DELETE FROM DETALLE_PEDIDO
    WHERE id_pedido IN (SELECT id_pedido FROM PEDIDO WHERE id_cliente = p_id_cliente);
    
    GET DIAGNOSTICS v_filas_afectadas = ROW_COUNT;
    RAISE NOTICE 'Se eliminaron % filas de DETALLE_PEDIDO.', v_filas_afectadas;

    -- 4. Eliminar pedidos
    -- Ahora que los detalles están limpios, borra los pedidos del cliente.
    DELETE FROM PEDIDO
    WHERE id_cliente = p_id_cliente;
    
    GET DIAGNOSTICS v_filas_afectadas = ROW_COUNT;
    RAISE NOTICE 'Se eliminaron % filas de PEDIDO.', v_filas_afectadas;

    -- 5. Eliminar cliente
    -- Finalmente, borra al cliente, ya que no tiene dependencias.
    DELETE FROM CLIENTE
    WHERE id_cliente = p_id_cliente;
    
    GET DIAGNOSTICS v_filas_afectadas = ROW_COUNT;
    IF v_filas_afectadas > 0 THEN
        RAISE NOTICE 'ÉXITO: Cliente % y todas sus dependencias han sido eliminados.', p_id_cliente;
    ELSE
        RAISE NOTICE 'AVISO: No se encontró ningún cliente con el ID %.', p_id_cliente;
    END IF;
    
END;
$$;

--USO 

--CALL sp_eliminar_cliente_con_dependencias(1);

--ELIMINAR DIRECCIONES

CREATE OR REPLACE PROCEDURE sp_eliminar_direccion(
    p_id_direccion INT
)
LANGUAGE plpgsql AS $$
BEGIN
    -- Fallará si la dirección es usada por PEDIDO o DETALLE_INVENTARIO.
    DELETE FROM DIRECCION
    WHERE id_direccion = p_id_direccion;
END;
$$;

--ELIMINAR CATEGORIA

CREATE OR REPLACE PROCEDURE sp_eliminar_categoria(
    p_id_categoria INT
)
LANGUAGE plpgsql AS $$
BEGIN
    -- Fallará si la categoría es usada por PRODUCTO.
    DELETE FROM CATEGORIA
    WHERE id_categoria = p_id_categoria;
END;
$$;

--ELIMINAR METODO DE PAGO

CREATE OR REPLACE PROCEDURE sp_eliminar_metodo_pago(
    p_id_metodo INT
)
LANGUAGE plpgsql AS $$
BEGIN
    -- Fallará si el método es usado por PEDIDO.
    DELETE FROM METODO_PAGO
    WHERE id_metodo = p_id_metodo;
END;
$$;

--ELIMINAR PRODUCTO DE CARRITO

CREATE OR REPLACE PROCEDURE sp_eliminar_producto_carrito(
    p_id_carrito INT,
    p_id_producto INT
)
LANGUAGE plpgsql AS $$
BEGIN
    DELETE FROM DETALLE_CARRITO
    WHERE id_carrito = p_id_carrito AND id_producto = p_id_producto;
END;
$$;


--ACTUALIZACION 

--ACTUALIZAR CATEGORIA

CREATE OR REPLACE PROCEDURE sp_actualizar_categoria(
    p_id_categoria INT,
    p_nombre VARCHAR,
    p_descripcion VARCHAR
)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE CATEGORIA
    SET 
        nombre = p_nombre,
        decripcion = p_descripcion -- Typo de tu schema
    WHERE id_categoria = p_id_categoria;
END;
$$;

--ACTUALIZAR PRODUCTO

CREATE OR REPLACE PROCEDURE sp_actualizar_producto(
    p_id_producto INT,
    p_nombre VARCHAR,
    p_descripcion VARCHAR,
    p_precio FLOAT,
    p_estado VARCHAR, -- 'estado' domain
    p_id_categoria INT
)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE PRODUCTO
    SET 
        nombre = p_nombre,
        descripcion = p_descripcion,
        precio = p_precio,
        estado = p_estado,
        id_categoria = p_id_categoria
    WHERE id_producto = p_id_producto;
END;
$$;

--ACTUALIZAR CLIENTE 

CREATE OR REPLACE PROCEDURE sp_actualizar_cliente(
    p_id_cliente INT,
    p_nombre VARCHAR,
    p_apellido VARCHAR,
    p_email VARCHAR,
    p_telefono VARCHAR -- 'telefono' domain
)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE CLIENTE
    SET 
        nombre = p_nombre,
        apellido = p_apellido,
        email = p_email,
        telefono = p_telefono
    WHERE id_cliente = p_id_cliente;
END;
$$;

--ACTUALIZAR CANTIDAD DE INVENTARIO PRODUCTO 

CREATE OR REPLACE PROCEDURE sp_actualizar_stock_producto(
    p_id_producto INT,
    p_id_direccion INT,
    p_nueva_cantidad INT -- Dominio 'cantidad_stock'
)
LANGUAGE plpgsql AS $$
DECLARE
    v_inventario_id INT;
BEGIN
    -- 1. Buscar el id_inventario para el producto
    SELECT id_inventario INTO v_inventario_id
    FROM INVENTARIO_PRODUCTO
    WHERE id_producto = p_id_producto;
    
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Producto % no tiene registro de inventario', p_id_producto;
    END IF;

    -- 2. Actualizar el stock en la dirección específica
    UPDATE DETALLE_INVENTARIO
    SET stock = p_nueva_cantidad
    WHERE id_inventario = v_inventario_id AND id_direccion = p_id_direccion;
    
    IF NOT FOUND THEN
         RAISE EXCEPTION 'No se encontró stock para el producto % en la dirección %', p_id_producto, p_id_direccion;
    END IF;
END;
$$;




--CREAR CONSULTA DE PEDIDO CON CADA PRODUCTO Y SU CANTIDAD Y ATRIBUTOS DEL CLIENTE 

CREATE OR REPLACE FUNCTION fn_consultar_detalle_pedido(p_id_pedido INT)
RETURNS TABLE (
    id_pedido INT,
    fecha_pedido TIMESTAMP,
    estado_pedido estado_pedido, -- <-- ¡AQUÍ ESTÁ EL CAMBIO!
    id_cliente INT,
    nombre_cliente VARCHAR,
    email_cliente VARCHAR,
    id_producto INT,
    nombre_producto VARCHAR,
    cantidad_comprada INT,
    precio_unitario FLOAT
)
LANGUAGE plpgsql AS $$
BEGIN
    RETURN QUERY
    SELECT 
        ped.id_pedido,
        ped.fecha_pedido,
        ped.estado, -- Esta columna es de tipo 'estado_pedido'
        cli.id_cliente,
        cli.nombre,
        cli.email,
        prod.id_producto,
        prod.nombre,
        det.cantidad,
        prod.precio
    FROM PEDIDO AS ped
    JOIN CLIENTE AS cli ON ped.id_cliente = cli.id_cliente
    JOIN DETALLE_PEDIDO AS det ON ped.id_pedido = det.id_pedido
    JOIN PRODUCTO AS prod ON det.id_producto = prod.id_producto
    WHERE ped.id_pedido = p_id_pedido;
END;
$$;

DROP FUNCTION fn_consultar_detalle_pedido(integer)

-- Para usarla:
 SELECT fn_consultar_detalle_pedido(1);

--CREAR CONSULTA DE TOTAL DE PRODUCTO AL BUSCAR EN CADA PLANTA DISPONIBLE 

CREATE OR REPLACE FUNCTION fn_consultar_stock_total_producto(p_id_producto INT)
RETURNS INT
LANGUAGE plpgsql AS $$
DECLARE
    v_total_stock INT;
BEGIN
    SELECT SUM(di.stock)
    INTO v_total_stock
    FROM DETALLE_INVENTARIO AS di
    JOIN INVENTARIO_PRODUCTO AS ip ON di.id_inventario = ip.id_inventario
    WHERE ip.id_producto = p_id_producto;

    -- Si no se encuentra (SUM de NULL es NULL), devolver 0.
    RETURN COALESCE(v_total_stock, 0);
END;
$$;

-- Para usarla:



