# Usa la imagen oficial de MySQL
FROM mysql:8.0

# Configura las variables de entorno
ENV MYSQL_ALLOW_EMPTY_PASSWORD=true
ENV MYSQL_DATABASE=universitybdd

# Copia el archivo .sql al contenedor para que MySQL lo ejecute al iniciar
COPY backups/*.sql /docker-entrypoint-initdb.d/

# Expone el puerto de MySQL
EXPOSE 3306
