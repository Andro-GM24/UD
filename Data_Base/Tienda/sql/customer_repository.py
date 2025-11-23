from model.Customer import Customer
from sql.database import get_connection

class customer_repository:
    

    def registrar(self,customer:Customer):

        conn = get_connection()
        cursor = conn.cursor()
        
        # se va a cambiar para crear un serial en la bd,solo para prueba registor login
        cursor.execute(
            "CALL sp_crear_cliente(%s, %s, %s, %s, %s, %s)",
            (customer.id_customer, customer.name, customer.lastname, customer.email, customer.phone, customer.password)
        )
        conn.commit()
        cursor.close()
        

    def validate_input(self, email, password):

        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute(
            "SELECT * FROM  fn_validar_usuario(%s)",
            (email,)
        )
        result = cursor.fetchone()
        cursor.close()
        if result:
            if(result[1]==password):#el uno sería la contraseña
                return True
        return False# si no encuentra el usuario o la contraseña es incorrecta
        
    def get_id_by_email(self, email):

        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute(
            "SELECT fn_obtener_id_cliente_por_email(%s)",
            (email,)
        )
        result = cursor.fetchone()
        cursor.close()
        if result:
            return result[0]
        return None

    