
--CREACION VISTAS 

--VISTA PRODUCTOS DISPONIBLES

CREATE VIEW PRODUCTOS_DISPONIBLES 
AS SELECT producto.id_producto, producto.nombre 
AS nombre_producto, producto.precio, categoria.nombre 
AS nombre_categoria 
FROM producto 
INNER JOIN categoria on producto.id_categoria=categoria.id_categoria 
WHERE producto.estado='En Stock';

SELECT * FROM PRODUCTOS_DISPONIBLES;

--VISTA PRODUCTOS SIN STOCK


CREATE VIEW PRODUCTOS_NO_DISPONIBLES
AS SELECT
producto.id_producto,
producto.nombre AS nombre_producto,
producto.precio,
categoria.nombre AS nombre_categoria
FROM producto 
INNER JOIN categoria on
producto.id_categoria=categoria.id_categoria
WHERE producto.estado='Sin Stock';

SELECT * FROM PRODUCTOS_NO_DISPONIBLES;


--VISTAS DE PEDIDOS 


--VISTA PEDIDO PAGADO

CREATE VIEW PEDIDOS_PAGADOS
AS SELECT 
pedido.id_pedido,
pedido.fecha_pedido,
cliente.id_cliente,
cliente.nombre AS nombre_cliente,
cliente.apellido, 
cliente.email,
cliente.telefono,
direccion.id_direccion,
direccion.ciudad,
direccion.d_especificada,
metodo_pago.id_metodo,
metodo_pago.tipo
FROM pedido
INNER JOIN cliente on pedido.id_cliente=cliente.id_cliente
INNER JOIN direccion on pedido.id_direccion=direccion.id_direccion
INNER JOIN metodo_pago on pedido.id_metodo=metodo_pago.id_metodo
WHERE pedido.estado='Pagado'

SELECT * FROM PEDIDOS_PAGADOS

--VISTA PEDIDO CANCELADO

CREATE VIEW PEDIDOS_CANCELADOS
AS SELECT 
pedido.id_pedido,
pedido.fecha_pedido,
cliente.id_cliente,
cliente.nombre AS nombre_cliente,
cliente.apellido, 
cliente.email,
cliente.telefono,
direccion.id_direccion,
direccion.ciudad,
direccion.d_especificada,
metodo_pago.id_metodo,
metodo_pago.tipo
FROM pedido
INNER JOIN cliente on pedido.id_cliente=cliente.id_cliente
INNER JOIN direccion on pedido.id_direccion=direccion.id_direccion
INNER JOIN metodo_pago on pedido.id_metodo=metodo_pago.id_metodo
WHERE pedido.estado='Cancelado'

SELECT * FROM PEDIDOS_CANCELADOS


--VISTA PEDIDO FINALIZADO

CREATE VIEW PEDIDOS_FINALIZADOS
AS SELECT 
pedido.id_pedido,
pedido.fecha_pedido,
cliente.id_cliente,
cliente.nombre AS nombre_cliente,
cliente.apellido, 
cliente.email,
cliente.telefono,
direccion.id_direccion,
direccion.ciudad,
direccion.d_especificada,
metodo_pago.id_metodo,
metodo_pago.tipo
FROM pedido
INNER JOIN cliente on pedido.id_cliente=cliente.id_cliente
INNER JOIN direccion on pedido.id_direccion=direccion.id_direccion
INNER JOIN metodo_pago on pedido.id_metodo=metodo_pago.id_metodo
WHERE pedido.estado='Finalizado'

SELECT * FROM PEDIDOS_FINALIZADOS

--VISTA PEDIDO POR PAGAR

CREATE VIEW PEDIDOS_POR_PAGAR
AS SELECT 
pedido.id_pedido,
pedido.fecha_pedido,
cliente.id_cliente,
cliente.nombre AS nombre_cliente,
cliente.apellido, 
cliente.email,
cliente.telefono,
direccion.id_direccion,
direccion.ciudad,
direccion.d_especificada,
metodo_pago.id_metodo,
metodo_pago.tipo
FROM pedido
INNER JOIN cliente on pedido.id_cliente=cliente.id_cliente
INNER JOIN direccion on pedido.id_direccion=direccion.id_direccion
INNER JOIN metodo_pago on pedido.id_metodo=metodo_pago.id_metodo
WHERE pedido.estado='Por pagar'

SELECT * FROM PEDIDOS_POR_PAGAR






SELECT * FROM DETALLE_PEDIDO
