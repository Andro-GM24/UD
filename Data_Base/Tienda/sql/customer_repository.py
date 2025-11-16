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
        

    def validate_input(self, username, password, email):
        # Logic to validate user input
        pass

    def send_confirmation_email(self, email):
        # Logic to send a confirmation email
        pass