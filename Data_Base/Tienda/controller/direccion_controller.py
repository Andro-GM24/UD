from flask import Blueprint, redirect, render_template, request, session, url_for
from model.Adress import Adress 
from sql.direccion_repository import direccion_repository
from sql.carrito_repository import carrito_repository
from sql.pedido_repository import pedido_repository 

direccion_repo = direccion_repository()
direccion_bp = Blueprint('direccion_bp', __name__)
carrito_repo = carrito_repository()
pedido_repository = pedido_repository()

@direccion_bp.route("/direccion", methods=["GET", "POST"])
def direccion_view():
    if request.method == "POST":
        data = request.form

        direccion = Adress(
            city=data["city"],
            postal_code=data["postal_code"],
            department=data["department"],
            
            d_especific=data["d_especific"]
        )

        id_direccion = direccion_repo.crear_direccion(direccion)

        id_pedido = carrito_repo.hacer_pedido(
            session.get("id_customer"),
            id_direccion
        )
        
        
        #se redirije a pedido view despues de hacer carrito
        return redirect(url_for("pedido_bp.pedido_view", id_pedido=id_pedido))

    return render_template("direccion/form.html")