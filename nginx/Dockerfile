# nginx/Dockerfile
FROM nginx:alpine

# Copia configuración de nginx y certificados
COPY nginx.conf /etc/nginx/nginx.conf
COPY wait-for-index.sh /wait-for-index.sh

# Asegurar permisos y estructura de logs
RUN chmod +x /wait-for-index.sh && mkdir -p /var/log/nginx

# Exponer puertos para HTTPS y HTTP
EXPOSE 80 443

# Esperar al index antes de arrancar Nginx
CMD ["/wait-for-index.sh"]
