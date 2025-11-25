
from flask import Blueprint, Flask, app, redirect, render_template, request, url_for
from model.Customer import  Customer 
from sql.customer_repository import customer_repository
from sql.producto_repository import producto_repository     
from flask import session

customer_bp = Blueprint('customer_bp', __name__)


@customer_bp.route("/signup", methods=["GET", "POST"])
def signup():
    if request.method == "POST":
        data = request.form
        tipo = data.get("tipo")  # obtener el tipo de usuario, por defecto "cliente"
        customer = Customer(
            name=data["name"],
            lastname=data["lastname"],
            email=data["email"],
            phone=data["phone"],
            password=data["password"],
            tipo=tipo
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
            
            # Verificar si es admin
            es_admin = customer_repository().es_admin(data["email"])
            session["es_admin"] = es_admin 
            
            return redirect(url_for('customer_bp.home'))
            
        else:
            return "usuario o contraseña incorrecta"

    return render_template("login.html")

@customer_bp.route("/home")
def home():
    return render_template("Home.html", products=producto_repository().listar_productos())