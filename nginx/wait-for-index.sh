#!/bin/sh

echo "⏳ Esperando a que Angular termine de compilar..."

while [ ! -f /usr/share/nginx/html/dist/my-angular-app/browser/index.html ]; do
  sleep 2
done

echo "✅ Angular está listo. Iniciando Nginx..."
nginx -g 'daemon off;'
