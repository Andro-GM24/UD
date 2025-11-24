from model.order import order
from model.OrderItem import OrderItem
from sql.database import get_connection

class pedido_repository:
    

    def obtener_pedido_por_id(self, id_pedido):
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM obtener_pedido(%s)", (id_pedido,))
        row = cursor.fetchone()
        pedido = None

        if row:
            pedido = order(
                id_order=row[0],
                date_order=row[1],
                estado=row[2],
                id_cliente=row[3],
                id_metodo=row[4],
                direction=row[5]
            )

            cursor.execute("SELECT * FROM fn_get_productos_pedido(%s)", (id_pedido,))
            productos = cursor.fetchall()

            for prod in productos:
                
                item = OrderItem(
                    id_producto=prod[0],
                    nombre=prod[1],
                    cantidad=prod[2],
                    precio_unitario=prod[3]
                )

                pedido.agregar_item(item, prod[2])  # Asumiendo que prod[0] es el producto y prod[1] es la cantidad


        

        cursor.close()
        return pedido