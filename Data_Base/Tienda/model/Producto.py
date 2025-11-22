class Producto:

    id_producto  =""
    nombre =""
    descripcion =""
    precio =0
    estado  =""
    nombre_categoria  =""

    def __init__(self, id_producto, nombre,descripcion,precio,estado,nombre_categoria):
        """Método constructor para inicializar atributos de instancia."""
        self.id_producto = id_producto
        self.nombre = nombre
        self.descripcion = descripcion
        self.precio = precio
        self.estado = estado
        self.nombre_categoria = nombre_categoria# talvez se podria hacer una lsita de nombres validos


"""
el inventario tiene varios productos, igual que el carrito y el pedido
"""

