from model.Producto import Producto
from sql.database import get_connection


class producto_repository:

    

    def listar_productos(self):
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM fn_listar_productos()") 
        results = cursor.fetchall()
        products = []
        for row in results:# obtiene una tupla por cada fila
            producto = Producto(
                id_producto=row[0],
                nombre=row[1],
                descripcion=row[2],
                precio=row[3],   
                estado=row[4],
                nombre_categoria=row[6]# reemplazar con el índice correcto
            )
            products.append(producto)
        cursor.close()
        return products # devuelve los productos    
            
    def obtener_producto_por_id(self, id_producto):
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute(
            "SELECT * FROM fn_ver_detalle_producto(%s)",
            (id_producto,)
        )
        row = cursor.fetchone()
        if row:
            producto = Producto(
                id_producto=row[0],
                nombre=row[1],
                descripcion=row[2],
                precio=row[3],
                estado=row[4],
                nombre_categoria=row[6]  # reemplazar con el índice correcto
            )
            cursor.close()
            return producto
        cursor.close()
        return None    

    def actualizar_producto(self, id_producto, data):
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute(
            "CALL sp_actualizar_producto(%s, %s, %s, %s, %s, %s)",
            (
                id_producto,
                data.get("nombre"),
                data.get("descripcion"),
                data.get("precio"),
                data.get("estado"),
                data.get("categoria_id")
                

            )
        )
        conn.commit()
        cursor.close()
        conn.close()

    def get_producto_by_id(self, id_producto):
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute(
            """SELECT p.id_producto, p.nombre, p.descripcion, p.precio, p.estado, 
                    p.id_categoria, c.nombre as nombre_categoria
            FROM producto p
            LEFT JOIN categoria c ON p.id_categoria = c.id_categoria
            WHERE p.id_producto = %s""",
            (id_producto,)
        )
        row = cursor.fetchone()
        cursor.close()
        conn.close()
        if row:
            producto = Producto(
                id_producto=row[0],
                nombre=row[1],
                descripcion=row[2],
                precio=row[3],
                estado=row[4],
                
                nombre_categoria=row[5]
            )
            return producto
        return None    