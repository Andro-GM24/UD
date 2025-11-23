"""
el cliente tiene un carrito, un carrito no puede
existir sin un cliente, entonces el cliente lo debe tener
como atributo

la cosa es que se busca es restar los datos de lo que 
sale de stock por pedido, cuando pasa eso se afecta esa parte,
 se hacen cambios


"""

class ShoppingCar:

    

    def __init__(self,id_shoppingcar):
        """Método constructor para inicializar atributos de instancia."""
        self.id_shoppingcar = id_shoppingcar
        self._items=[]

    @property
    def items(self):
        return self._items 


    def agregar_item(self, producto, cantidad):
        self._items.append((producto, cantidad))

    def calcular_total(self):
        return sum(prod.precio * cant for prod, cant in self._items)
    