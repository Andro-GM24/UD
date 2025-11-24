
from flask import Blueprint, Flask, app, render_template, request
from model.Customer import  Customer 
from sql.customer_repository import customer_repository
from sql.producto_repository import producto_repository     
from flask import session

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

        return render_template("login.html")

    return render_template("signup.html")


@customer_bp.route("/login", methods=["GET", "POST"])
def login():
    if request.method == "POST":
        data = request.form

        if(customer_repository().validate_input(data["email"], data["password"])):
            session["id_customer"]= customer_repository().get_id_by_email(data["email"])
            #toca ver  si es vendedor o cliente con un llamado
            
            

            return render_template("Home.html", products=producto_repository().listar_productos())
        else:
            return "usuario o contraseña incorrecta"

    return render_template("login.html")