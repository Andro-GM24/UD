from flask import Blueprint, redirect, render_template, request, session
from model.ShoppingCar import ShoppingCar
from sql.carrito_repository import carrito_repository

carrito_repo = carrito_repository()
carrito_bp = Blueprint('carrito_bp', __name__)  

@carrito_bp.route("/carrito", methods=["GET", "POST"])
def carrito_view():
    if request.method == "GET":
        # Obtener el carrito de compras (aquí se asume que hay un solo carrito)
        sess = session.get("id_customer")
        if not sess:
            return redirect("/login")
        carrito = carrito_repo.obtener_carrito_por_usuario(sess )# poner el id del usuario actual

        if carrito is None:
            return render_template("carrito/view.html", items_carrito=[])

        return render_template( "carrito/view.html",items_carrito=carrito.items,total=carrito.calcular_total())
    
#hacer función para agregar al carrito    