# Usa la imagen oficial de MySQL
FROM mysql:8.0

# Configura las variables de entorno
ENV MYSQL_ALLOW_EMPTY_PASSWORD=true
ENV MYSQL_DATABASE=universitybdd

# Copia el archivo .sql al contenedor para que MySQL lo ejecute al iniciar
COPY backups/*.sql /docker-entrypoint-initdb.d/

# Expone el puerto de MySQL
EXPOSE 3306

# Expone un puerto HTTP falso (8080)
EXPOSE 8080

# Instala un servidor HTTP falso para engañar a Render
RUN apt-get update && apt-get install -y python3
RUN echo "import http.server; http.server.test(HandlerClass=http.server.SimpleHTTPRequestHandler, port=8080)" > /tmp/fake_http.py

# Inicia MySQL y el servidor HTTP falso
CMD sh -c "python3 /tmp/fake_http.py & mysqld"