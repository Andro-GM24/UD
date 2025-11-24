from model.Adress import Adress
from sql.database import get_connection     

class direccion_repository:

    def crear_direccion(self,direccion: Adress):
        conexion = get_connection()
        with conexion.cursor() as cursor:
            cursor.execute(" SELECT fn_insertar_direccion(%s,%s,%s,%s)",(direccion.city,direccion.postal_code,direccion.department,direccion.d_especific)) 
            id_generado = cursor.fetchone()[0]
            direccion.id_address = id_generado
        conexion.commit()
        conexion.close()
        return id_generado



                