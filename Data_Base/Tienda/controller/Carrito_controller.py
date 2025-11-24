from flask import Blueprint, redirect, render_template, request, session, url_for
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
    
@carrito_bp.route('/carrito/add', methods=['POST'])
def add_to_cart():
    # Agrega un producto al carrito del usuario en sesión
    sess = session.get('id_customer')
    if not sess:
        return redirect('/login')

    data = request.form
    try:
        id_producto = int(data.get('id_producto'))
    except Exception:
        return redirect(url_for('producto_bp.home'))

    try:
        cantidad = int(data.get('cantidad', 1))
    except Exception:
        cantidad = 1

    # Llama al repositorio para agregar el producto (usa stored procedure en DB)
    carrito_repo.agregar_al_carrito(sess, id_producto, cantidad)

    return redirect(url_for('producto_bp.home'))

#hacer función para agregar al carrito    

# Ruta para eliminar producto del carrito
@carrito_bp.route('/carrito/remove', methods=['POST'])
def remove_from_cart():
    sess = session.get('id_customer')
    if not sess:
        return redirect('/login')
    data = request.form
    try:
        id_producto = int(data.get('id_producto'))
    except Exception:
        return redirect(url_for('carrito_bp.carrito_view'))
    carrito_repo.eliminar_del_carrito(sess, id_producto)
    return redirect(url_for('carrito_bp.carrito_view'))