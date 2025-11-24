from flask import Blueprint, redirect, render_template, request, session, url_for
from model.Adress import Adress
from sql.pedido_repository import pedido_repository

pedido_repo = pedido_repository()

pedido_bp = Blueprint('pedido_bp', __name__)
@pedido_bp.route("/pedido/<int:id_pedido>", methods=["GET"])
def pedido_view(id_pedido):
    pedido = pedido_repo.obtener_pedido_por_id(id_pedido)
    return render_template("pedido/view.html", pedido=pedido)