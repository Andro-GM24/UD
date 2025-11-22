from flask import Blueprint, render_template, request
from model.Category import Category
from sql.category_repository import category_repository

category_bp = Blueprint('category_bp', __name__)
"""

@category_bp.route("/home", methods=["GET"])
def home():
    # pasar las categorias usando el category repository
    categories = category_repository().listar_categorias()
    return render_template("home.html", categories=categories)"""