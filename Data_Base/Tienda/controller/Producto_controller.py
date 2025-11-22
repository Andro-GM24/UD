from flask import Blueprint, Flask, app, render_template, request
from model.Producto import  Producto
from sql.producto_repository import producto_repository
from service.ProductService import ProductService

product_repo = producto_repository()
producto_bp = Blueprint('producto_bp', __name__)
product_service = ProductService(product_repo)
@producto_bp.route("/home", methods=["GET", "POST"])
def home():


    # pasar los producto usando el producto reporsitory
    return render_template("Home.html", products=producto_repository().listar_productos())


@producto_bp.route("/product/<id_producto>", methods=["GET", "POST"])# el get recibe el id del producto
def product_detail(id_producto):
    if(request.method=="GET"):    
        product = product_service.get_by_id(id_producto)
        # home tiene una lista de prodcutos que va mostrando en el html home

        return render_template("product/view.html", product=product)