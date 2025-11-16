#!revisarrrrrr
from flask import Blueprint, Flask, app, render_template, request
from model.Customer import  Customer 
from sql.customer_repository import customer_repository     


customer_bp = Blueprint('customer_bp', __name__)


@customer_bp.route("/signup", methods=["GET", "POST"])
def signup():
    if request.method == "POST":
        data = request.form

        customer = Customer(
            name=data["name"],
            lastname=data["lastname"],
            email=data["email"],
            phone=data["phone"],
            password=data["password"]
        )
        customer.crear_id(customer.email)

        repo = customer_repository()
        repo.registrar(customer)

        return "Registrado correctamente"

    return render_template("signup.html")