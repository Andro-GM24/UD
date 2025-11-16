"""
el cliente tiene un carrito, un carrito no puede
existir sin un cliente, entonces el cliente lo debe tener
como atributo

la cosa es que se busca es restar los datos de lo que 
sale de stock por pedido, cuando pasa eso se afecta esa parte,
 se hacen cambios


"""

class ShoppingCar:

    id_shoppingcar=""
   
    cantidad=0

    def __init__(self,id_shoppingcar,cantidad):
        """Método constructor para inicializar atributos de instancia."""
        self.id_shoppingcar = id_shoppingcar

        self.productos=[]
        self.producto_cantidad = (self.productos,cantidad)
        