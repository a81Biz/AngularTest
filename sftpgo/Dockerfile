# Dockerfile personalizado para SFTPGo
FROM drakkan/sftpgo:latest

# Crear los archivos y carpetas necesarios para la base de datos y el directorio de archivos
RUN mkdir -p /var/lib/sftpgo/data && \
    touch /var/lib/sftpgo/data/sftpgo.db && \
    mkdir -p /var/lib/sftpgo/public

# Configurar variables de entorno para que SFTPGo use estas rutas
ENV SFTPGO_DB_DIR=/var/lib/sftpgo/data
ENV SFTPGO_DATA_PROVIDER__DRIVER=sqlite
ENV SFTPGO_DATA_PROVIDER__NAME=/var/lib/sftpgo/data/sftpgo.db
ENV SFTPGO_HTTPD__TLS_ENABLED=false
