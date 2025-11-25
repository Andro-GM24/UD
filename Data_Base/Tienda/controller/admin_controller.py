from flask import Blueprint, Flask, app, redirect, render_template, request, url_for
from model.Customer import  Customer
from model.Producto import  Producto
from sql.customer_repository import customer_repository
from sql.producto_repository import producto_repository     
from flask import session

product_repo = producto_repository()
clienter_repo = customer_repository()



admin_bp = Blueprint('admin_bp', __name__)

@admin_bp.route("/admin/productos")
def admin_productos():
    
    productos = product_repo.listar_productos()

    return render_template("admin_productos.html", productos=productos)

@admin_bp.route("/admin/producto/<int:id_producto>", methods=["GET", "POST"])
def editar_producto(id_producto):
    if request.method == "POST":
        # Actualizar producto
        data = request.form
        producto_repository().actualizar_producto(id_producto, data)
        return redirect(url_for('admin_bp.lista_productos'))
    
    # Mostrar formulario de edición
    producto = producto_repository().get_producto_by_id(id_producto)
    return render_template("admin_editar.html", producto=producto)

@admin_bp.route("/admin/customers")
def admin_customers():
    customers = clienter_repo.listar_customers()
    return render_template("admin_customers.html", customers=customers)

@admin_bp.route("/admin/customer/<int:id_customer>", methods=["GET", "POST"])
def editar_customer(id_customer):
    if request.method == "POST":
        # Actualizar customer
        data = request.form
        customer_repository().actualizar_customer(id_customer, data)
        return redirect(url_for('admin_bp.admin_customers'))
    
    # Mostrar formulario de edición
    customer = customer_repository().get_customer_by_id(id_customer)
    return render_template("admin_editar_customer.html", customer=customer)