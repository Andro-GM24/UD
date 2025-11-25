from  sql.database import get_connection

class Customer:

    """ 
    el cliente tiene un solo carrito,tiene varios pedidos 
    tmabien tiene metodos de pagos asociados

    también debe tener una lista de direcciones asociadas
    """


    id_customer  =""
    name =""
    lastname =""
    email  =""
    phone  =""   
    password=""

    def __init__(self,id_customer,name,lastname,email,phone,password,tipo, shoppingcar=None):
        # despues agregar o arreglar el carrito de compras
        self.id_customer = id_customer
        self.name=name
        self.lastname=lastname
        self.email=email
        self.phone=phone
        self.password=password
        self.tipo = tipo
        self.adresses=[]
        self.orders=[]  
        self.shoppingcar=shoppingcar

    def crear_id(self,texto: str) :
   
        # Inicializa la suma
        suma_total = 0
        
        # Itera sobre cada carácter de la cadena
        for caracter in texto:
            # La función 'ord()' devuelve el valor Unicode (ordinal) del carácter.
            valor_ordinal = ord(caracter)
            
            # Suma el valor al total
            suma_total += valor_ordinal
            
           
        self.id_customer=suma_total


    