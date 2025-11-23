class ProductService:

    def __init__(self, product_repository):
        self.product_repository = product_repository

    def get_by_id(self, product_id):
        product = self.product_repository.obtener_producto_por_id(product_id)
        # repositorio solo hace consultas pero no tiene logica de negocio
        if not product:
            raise ValueError("Producto no encontrado")

        # Aquí podrías agregar lógica extra, por ejemplo:
        # aplicar descuentos, cálculos, validaciones, etc.

        return product    
    
