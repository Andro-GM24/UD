class order:

    id_order=""
   
    cantidad=0

    def __init__(self,id_order,cantidad,date_order,direction):
        """Método constructor para inicializar atributos de instancia."""
        self.id_order = id_order
        self.date_order=date_order
        """
        no se si está mal asociar la dirección al pedido,o seria solo el codigo ya que el cliente tien 
        direcciónes por default
        """
        self.direction=direction
        self.productos=[]
        self.producto_cantidad = (self.productos,cantidad)
            