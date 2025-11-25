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
        if customer.tipo == "vendedor":
            cursor.execute(
                "CALL sp_crear_vendedor(%s)",
                (customer.id_customer,)
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

    def listar_customers(self):
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM cliente") 
        results = cursor.fetchall()
        customers = []
        for row in results:# obtiene una tupla por cada fila
            customer = Customer(
                id_customer=row[0],
                name=row[1],
                lastname=row[2],
                email=row[3],
                phone=row[4],
                password="",   
                tipo=row[6]
            )
            customers.append(customer)
        cursor.close()
        return customers # devuelve los clientes
    
    def actualizar_customer(self, id_customer, data):
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute(
            "CALL sp_actualizar_cliente(%s, %s, %s, %s, %s, %s)",
            (
                id_customer,
                data.get("name"),
                data.get("lastname"),
                data.get("email"),
                data.get("phone"),
                data.get("tipo")
            )
        )
        conn.commit()
        cursor.close()