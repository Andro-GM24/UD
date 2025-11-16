from flask import Flask
from flask import render_template
from controller.Customer_controller import customer_bp

app = Flask(__name__,template_folder='templates')


#está no existira


app.register_blueprint(customer_bp)

if __name__ == "__main__":
    app.run(debug=True)
