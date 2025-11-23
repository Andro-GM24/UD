from model.ShoppingCar import ShoppingCar
from model.Producto import Producto
from sql.database import get_connection

class carrito_repository:

    def obtener_carrito_por_usuario(self, id_customer):
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM fn_ver_carrito_usuario(%s)", (id_customer,))
        results = cursor.fetchall()
        carrito = None
        #se debe crear el objeto carrito, crear productos y agregarlos al carrito
        if results:

            carrito = ShoppingCar(
                id_shoppingcar=results[0][0],#asigna id del carrito
             )
            
            for row in results:# recorremos cada fila y vamos agregando productos y su cantidad a la tupla
                #se crea el objeto producto
                producto = Producto(
                    id_producto=row[1],
                    nombre=row[2],
                    descripcion=row[3],
                    precio=row[5],
                    estado=row[6],
                    nombre_categoria=row[7]) 
                cantidad = row[4]
                carrito.agregar_item(producto, cantidad)
            
            cursor.close()
            return carrito
            



    def agregar_al_carrito(self, id_usuario, id_producto, cantidad):
        conn = get_connection()
        cursor = conn.cursor()
    
        id_carrito = None

        try:
            # 1. Buscar el carrito existente del usuario
            cursor.execute("SELECT id_carrito FROM CARRITO WHERE id_cliente = %s", (id_usuario,))
            row = cursor.fetchone()

            if row:
                # Carrito encontrado
                id_carrito = row[0]
            else:
                # 2. Si el carrito no existe, crearlo (usando una secuencia si es posible, o MAX+1 si no)
                # Nota: Si id_carrito es una clave serial/identity, podrías intentar INSERT y obtener el ID
                # Para mantener la estructura MAX+1:
                cursor.execute("SELECT COALESCE(MAX(id_carrito), 0) + 1 FROM CARRITO")
                id_carrito = cursor.fetchone()[0]
                cursor.execute("INSERT INTO CARRITO (id_carrito, id_cliente) VALUES (%s, %s)", (id_carrito, id_usuario))

            # 3. Llamar al procedimiento almacenado para agregar/actualizar el producto
            # sp_agregar_producto_carrito  (p_id_carrito, p_id_producto, p_cantidad)
            cursor.execute("CALL sp_agregar_producto_carrito(%s, %s, %s)", (id_carrito, id_producto, cantidad))
        
            # 4. Confirmar TODAS las operaciones (creación de carrito si fue necesario + adición de detalle)
            conn.commit()
        
        except Exception as e:
            conn.rollback()
            # Puedes imprimir el error para depuración si lo deseas: print(e)
            raise # Re-lanzar la excepción para que el código superior sepa que falló

        finally:
            cursor.close()
            conn.close()
    
        # Retornar el ID del carrito para confirmación
        return id_carrito