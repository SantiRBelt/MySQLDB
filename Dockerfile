# Usa una imagen base de Debian o Ubuntu
FROM debian:bullseye-slim

# Instala dependencias necesarias
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        apt-utils \
        python3 \
        default-mysql-server \
        default-mysql-client && \
    rm -rf /var/lib/apt/lists/*

# Configura las variables de entorno para MySQL
ENV MYSQL_ALLOW_EMPTY_PASSWORD=true
ENV MYSQL_DATABASE=universitybdd

# Copia el archivo .sql al contenedor para que MySQL lo ejecute al iniciar
COPY backups/*.sql /docker-entrypoint-initdb.d/

# Expone el puerto de MySQL
EXPOSE 3306

# Expone un puerto HTTP falso (8080)
EXPOSE 8080

# Crea un servidor HTTP falso en Python
RUN echo "import http.server; http.server.test(HandlerClass=http.server.SimpleHTTPRequestHandler, port=8080)" > /tmp/fake_http.py

# Inicia MySQL y el servidor HTTP falso
CMD sh -c "mysqld & python3 /tmp/fake_http.py"