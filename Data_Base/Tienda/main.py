from flask import Flask
from flask import render_template
from controller.Customer_controller import customer_bp
from controller.Carrito_controller import carrito_bp
from controller.Producto_controller import producto_bp
from controller.direccion_controller import direccion_bp
from controller.pedido_controller import pedido_bp  

app = Flask(__name__,template_folder='templates')

app = Flask(__name__)
app.secret_key = "basededatos"


#está no existira


app.register_blueprint(customer_bp)
app.register_blueprint(producto_bp)
app.register_blueprint(carrito_bp)
app.register_blueprint(direccion_bp)
app.register_blueprint(pedido_bp)
  

if __name__ == "__main__":
    app.run(debug=True)

print(app.url_map)
