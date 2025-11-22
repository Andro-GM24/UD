from model.Category import Category
from sql.database import get_connection 

class category_repository:  

    def listar_categorias(self):
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM fn_listar_categorias()") 
        results = cursor.fetchall()
        categories = []
        for row in results:# obtiene una tupla por cada fila
            category = Category(
                id_category=row[0],
                name=row[1],
                description=row[2]   
            )
            categories.append(category)
        cursor.close()
        return categories # devuelve las categorias