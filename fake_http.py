import http.server
import mysql.connector
import json

class MySQLRequestHandler(http.server.BaseHTTPRequestHandler):
    def do_GET(self):
        # Configura la conexión a MySQL
        db = mysql.connector.connect(
            host="localhost",
            user="root",  # Usuario por defecto de MySQL
            password="",  # Contraseña vacía según tu configuración
            database="universitybdd"  # Nombre de la base de datos
        )
        cursor = db.cursor()

        # Realiza una consulta a la base de datos
        cursor.execute("SELECT * FROM your_table_name")  # Cambia "your_table_name" por el nombre de tu tabla
        result = cursor.fetchall()

        # Cierra la conexión a la base de datos
        cursor.close()
        db.close()

        # Convierte el resultado a JSON
        response = json.dumps(result)

        # Envía la respuesta HTTP
        self.send_response(200)
        self.send_header('Content-type', 'application/json')
        self.end_headers()
        self.wfile.write(response.encode('utf-8'))

    def do_POST(self):
        # Aquí puedes manejar solicitudes POST si es necesario
        self.send_response(501)  # 501 Not Implemented
        self.end_headers()

if __name__ == "__main__":
    server_address = ('', 8080)  # Escucha en el puerto 8080
    httpd = http.server.HTTPServer(server_address, MySQLRequestHandler)
    print("Servidor HTTP falso iniciado en el puerto 8080...")
    httpd.serve_forever()