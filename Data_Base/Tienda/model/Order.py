class order:

    

    def __init__(self,id_order,date_order,direction,estado,id_cliente,id_metodo):
        """Método constructor para inicializar atributos de instancia."""
        self.id_order = id_order
        self.date_order=date_order
        self.estado=estado
        self.id_cliente=id_cliente
        self.id_metodo=id_metodo
        
        self.direction=direction
        self._items=[]

    @property
    def items(self):
        return self._items
    
    def agregar_item(self, producto, cantidad):
        self._items.append((producto, cantidad))

    def calcular_total(self):
        return sum(prod.precio * cant for prod, cant in self._items)    

