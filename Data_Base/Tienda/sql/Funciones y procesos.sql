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


-- nueva función :validar usuario

CREATE OR REPLACE FUNCTION fn_validar_usuario(    p_email VARCHAR)
RETURNS  TABLE (--debe es buscar la constraseña con el email
    email VARCHAR,
    contrasena VARCHAR
)
AS $$
BEGIN
    RETURN QUERY
    SELECT 
        c.email,
        c.contrasena-- con esto ya la podemos comparar
    from cliente as c
    WHERE c.email = p_email;
END;
$$ LANGUAGE plpgsql; --se va a cambiar para que solo se guarde el hash



--cargar tabla de categorias

CREATE OR REPLACE FUNCTION fn_listar_categorias()
RETURNS TABLE (
    id_categoria INT,
    nombre VARCHAR
)   
LANGUAGE plpgsql AS $$
BEGIN
    RETURN QUERY
    SELECT 
        c.id_categoria,
        c.nombre
    FROM CATEGORIA AS c;
END;
$$;
-- Para usarla:
 SELECT * FROM fn_listar_categorias();


-- función para listar productos en vista de productos(home)

CREATE OR REPLACE FUNCTION fn_listar_productos()
RETURNS TABLE (
    id_producto INT,
    nombre VARCHAR,-- quisiera añadirle codigo de imagen
    descripcion VARCHAR,
    precio FLOAT,
    estado estado, -- Dominio 'estado'
    id_categoria INT,
    nombre_categoria VARCHAR
)
LANGUAGE plpgsql AS $$
BEGIN
    RETURN QUERY
    SELECT 
        p.id_producto,
        p.nombre,
        p.descripcion,
        p.precio,
        p.estado,
        p.id_categoria,
        c.nombre AS nombre_categoria
    FROM PRODUCTO AS p
    JOIN CATEGORIA AS c ON p.id_categoria = c.id_categoria;

END;-- hacer operación join de categoria de una vez
$$;
-- Para usarla:
 SELECT * FROM fn_listar_productos();


-- función para ver detalle de un producto

CREATE OR REPLACE FUNCTION fn_ver_detalle_producto(p_id_producto INT)
RETURNS TABLE (
    id_producto INT,
    nombre VARCHAR,-- quisiera añadirle codigo de imagen
    descripcion VARCHAR,
    precio FLOAT,
    estado estado, -- Dominio 'estado'
    id_categoria INT,
    nombre_categoria VARCHAR
)
LANGUAGE plpgsql AS $$
BEGIN
    RETURN QUERY
    SELECT 
        p.id_producto,
        p.nombre,
        p.descripcion,
        p.precio,
        p.estado,
        p.id_categoria,
        c.nombre AS nombre_categoria
    FROM PRODUCTO AS p
    JOIN CATEGORIA AS c ON p.id_categoria = c.id_categoria
    WHERE p.id_producto = p_id_producto;

END;-- hacer operación join de categoria de una vez
$$;

-- Para usarla:
 SELECT * FROM fn_listar_productos();


-- crear función para ver el carrito de un usuario
--acceder a carrito,detalle carrito y producto
CREATE OR REPLACE FUNCTION fn_ver_carrito_usuario(p_id_cliente INT)
RETURNS TABLE (
    --que necesito para mostrar?
    id_carrito INT,
    id_producto INT,
    nombre_producto VARCHAR,
    descripcion_producto VARCHAR,
    cantidad INT,
    precio_unitario FLOAT,
    estado_producto estado,
    nombre_categoria VARCHAR

)
LANGUAGE plpgsql AS $$
BEGIN   
    RETURN QUERY
    SELECT 
        c.id_carrito,
        p.id_producto,
        p.nombre AS nombre_producto,
        p.descripcion AS descripcion_producto,
        dc.cantidad,--el orden importa
        p.precio AS precio_unitario,
        p.estado AS estado_producto,
        cat.nombre AS nombre_categoria
        
        
    FROM CARRITO AS c -- obtenemos de clase carrito el id del cliente
    JOIN DETALLE_CARRITO AS dc ON c.id_carrito = dc.id_carrito-- unimos con detalle carrito con id carrito
    JOIN PRODUCTO AS p ON dc.id_producto = p.id_producto -- unimos detalle carrito con producto
    JOIN CATEGORIA AS cat ON p.id_categoria = cat.id_categoria-- unimos producto con categoria para mostrar el nombre
    WHERE c.id_cliente = p_id_cliente;-- condición para que sea del cliente  

END;
$$;

select * from fn_ver_carrito_usuario(3);

-- crear función para obtener el id de un cliente con email
CREATE OR REPLACE FUNCTION fn_obtener_id_cliente_por_email(p_email VARCHAR)
RETURNS INT
LANGUAGE plpgsql AS $$
DECLARE
    v_id_cliente INT;
BEGIN
    SELECT c.id_cliente INTO v_id_cliente
    FROM CLIENTE AS c
    WHERE c.email = p_email;
    RETURN v_id_cliente;
END;
$$;
-- Para usarla: 



select   fn_obtener_id_cliente_por_email('sofia.r@mail.com');


-- crear procedimiento para agregar producto al carrito dado el id del carrito, id del producto y cantidad

CREATE OR REPLACE PROCEDURE sp_agregar_producto_carrito(
   
    p_id_carrito INT,
    p_id_producto INT,
    p_cantidad INT
)
LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO DETALLE_CARRITO ( id_carrito, id_producto, cantidad)
    VALUES ( p_id_carrito, p_id_producto, p_cantidad);
END;
$$;

-- Para usarla:
-- CALL sp_agregar_producto_carrito(1, 2, 3); -- Agrega 3 unidades del producto con id 2 al carrito con id 1


--crear función para agregar tipo de usuario

CREATE OR REPLACE PROCEDURE sp_crear_vendedor(
    p_id_cliente INT
)   
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE cliente
    SET TIPO = 'vendedor'
    WHERE id_cliente = p_id_cliente;
END;
$$;

CALL sp_crear_vendedor(3);

-- función para pagar el pedido ( pasar a pedido desde carrito)

CREATE OR REPLACE FUNCTION fn_hacer_pedido_desde_carrito(
    p_id_carrito INT,
    p_id_cliente INT,
    p_id_direccion INT,
    p_id_metodo INT
)
RETURNS INT
LANGUAGE plpgsql AS $$
DECLARE
    v_id_pedido INT;
BEGIN
    -- Crear el pedido
    INSERT INTO pedido (fecha_pedido, estado, id_cliente, id_metodo, id_direccion)
    VALUES (NOW(), 'Por pagar', p_id_cliente, p_id_metodo, p_id_direccion)
    RETURNING id_pedido INTO v_id_pedido;

    -- Pasar productos del carrito al detalle del pedido
    INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad)
    SELECT v_id_pedido, dc.id_producto, dc.cantidad
    FROM detalle_carrito dc
    WHERE dc.id_carrito = p_id_carrito;

    -- Vaciar el carrito
    DELETE FROM detalle_carrito
    WHERE id_carrito = p_id_carrito;

    RETURN v_id_pedido;
END;
$$;



--crear  dirección y se altera la tabla


CREATE OR REPLACE FUNCTION fn_insertar_direccion(
    p_ciudad VARCHAR,
    p_codigo_postal VARCHAR,
    p_departamento VARCHAR,
    p_especificada VARCHAR
)
RETURNS INT
LANGUAGE plpgsql AS $$
DECLARE
    v_id INT;
BEGIN
    INSERT INTO direccion (ciudad, codigo_postal, departamento, d_especificada)
    VALUES (p_ciudad, p_codigo_postal, p_departamento, p_especificada)
    RETURNING id_direccion INTO v_id;

    RETURN v_id;
END;
$$;
-- Para usarla:
 SELECT fn_insertar_direccion('CiudadX', '12345', 'DepartamentoY', 'Calle Z #123'); 


--función para obtener los productos de un pedido específico

 
 CREATE OR REPLACE FUNCTION fn_get_productos_pedido(p_id_pedido INT)
RETURNS TABLE (
    id_producto INT,
    nombre_producto VARCHAR,
    cantidad INT,
    precio_unitario FLOAT
   
)
AS $$
BEGIN
    RETURN QUERY
    SELECT 
        dp.id_producto,
        p.nombre,
        dp.cantidad,
        p.precio
        
    FROM DETALLE_PEDIDO dp
    INNER JOIN PRODUCTO p ON p.id_producto = dp.id_producto
    WHERE dp.id_pedido = p_id_pedido;
END;
$$ LANGUAGE plpgsql;


-- Para usarla:
 SELECT * FROM fn_get_productos_pedido(2);


 -- función para tener el pedido por id

 CREATE OR REPLACE FUNCTION obtener_pedido(p_id INT)
RETURNS TABLE (
    id_pedido INT,
    fecha_pedido TIMESTAMP,
    estado VARCHAR,
    id_cliente INT,
    id_metodo INT,
    id_direccion INT
)
AS $$
BEGIN
    RETURN QUERY
    SELECT *
    FROM PEDIDO
    WHERE PEDIDO.id_pedido = p_id;
END;
$$ LANGUAGE plpgsql;
-- Para usarla: