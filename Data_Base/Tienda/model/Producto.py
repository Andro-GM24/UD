class Producto:

    id_producto  =""
    nombre =""
    descripcion =""
    precio =0
    estado  =""
    id_categoria  =""

    def __init__(self, id_producto, nombre,descripcion,precio,estado,id_categoria):
        """Método constructor para inicializar atributos de instancia."""
        self.id_producto = id_producto
        self.nombre = nombre
        self.descripcion = descripcion
        self.precio = precio
        self.estado = estado
        self.id_categoria = id_categoria# talvez se podria hacer una lsita de nombres validos


"""
el inventario tiene varios productos, igual que el carrito y el pedido
"""

