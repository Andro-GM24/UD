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
        pass

    