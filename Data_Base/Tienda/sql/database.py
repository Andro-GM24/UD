import psycopg2

def get_connection():
    return psycopg2.connect(
        host="localhost",
        database="tienda",
        user="postgres",
        password="MYSQL",
        port=5432
    )
