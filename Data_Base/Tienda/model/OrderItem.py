class OrderItem:
    def __init__(self, id_producto, nombre, cantidad, precio_unitario):
        self.id_producto = id_producto
        self.nombre = nombre
        self.cantidad = cantidad
        self.precio_unitario = precio_unitario
        self.subtotal = cantidad * precio_unitario
