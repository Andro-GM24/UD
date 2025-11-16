
	-- CREAR DOMINIOS 


	--DOMINIO PARA METODO DE PAGO

	CREATE DOMAIN tipo_pago as VARCHAR(10) CHECK (VALUE IN('Efectivo', 'Tarjeta', 'Otro'));


	--DOMINIO PRODUCTO (ESTADO)

	CREATE DOMAIN estado as VARCHAR(20) CHECK ( VALUE IN ('En Stock', 'Sin Stock'));

	--DOMINIO PRODUCTO INVENTARIO (CANTIDAD_STOCK)

	CREATE DOMAIN cantidad_stock as int CHECK (VALUE >= 0);

	--DOMINIO PEDIDO (ESTADO)

	CREATE DOMAIN estado_pedido as VARCHAR(20) CHECK (VALUE IN ('Pagado','c','Finalizado','Por pagar'));


	--CREAR RESTRICCION PARA TELEFONO

	CREATE DOMAIN telefono AS VARCHAR(20)CHECK (VALUE ~ '^[0-9+]+$');






	--AÑADIR DOMINIOS
	
ALTER TABLE metodo_pago ALTER COLUMN tipo TYPE tipo_pago

ALTER TABLE producto ALTER COLUMN estado TYPE estado

ALTER TABLE detalle_inventario ALTER COLUMN stock TYPE cantidad_stock

ALTER TABLE pedido ALTER COLUMN estado TYPE estado_pedido

ALTER TABLE cliente ALTER COLUMN telefono TYPE telefono

	


	
	