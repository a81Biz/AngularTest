# 🐳 Contenedor Angular + Nginx + TLS (Dockerized Angular Dev/Build)

Este entorno está diseñado para facilitar el desarrollo y despliegue de una aplicación Angular usando Docker. Incluye:

- 🔧 Angular CLI con proyecto autocreado si no existe.
- 🌐 Nginx configurado para servir el build de producción de Angular.
- 🔐 Certificados autofirmados para HTTPS.
- 💾 Persistencia del proyecto Angular en `./public_html/` para modificar desde el host.

---

## 🧱 Estructura del proyecto

```
.
├── angular_app/             # Contiene el Dockerfile para Angular
│   └── Dockerfile
├── nginx/                   # Configuración de Nginx
│   ├── Dockerfile
│   ├── nginx.conf
│   └── wait-for-index.sh
├── certs/                   # Certificados SSL autofirmados
│   ├── nginx-selfsigned.crt
│   └── nginx-selfsigned.key
├── public_html/             # Proyecto Angular completo y persistente
├── docker-compose.yml
└── README.md
```

---

## 🚀 ¿Qué hace este entorno?

1. El contenedor `angular_app`:
   - Verifica si existe un proyecto Angular en `./public_html`.
   - Si no existe, lo crea automáticamente con Angular CLI.
   - Ejecuta `npm install` y `ng build --configuration production`.

2. El contenedor `nginx_web`:
   - Espera a que Angular genere el archivo `index.html` compilado.
   - Sirve la app desde `./public_html/dist/my-angular-app/browser/`.
   - Usa certificados autofirmados para HTTPS.

---

## 📺 ¿Cómo sé que todo está funcionando?

Al ejecutar por primera vez:

```bash
docker-compose up --build
```

La creación del proyecto Angular puede tardar **varios minutos (5 a 10)**.

Observa estos mensajes clave en consola:

| Etapa | Mensaje esperado |
|-------|------------------|
| 🚀 Inicio del proceso | `📦 Creando proyecto Angular...` |
| 📦 Instalación de paquetes | `✔ Packages installed successfully.` |
| 🛠️ Proceso de compilación | `❯ Building...` seguido de `✔ Building...` |
| 📦 Final del build | `Output location: /app/dist/my-angular-app` |
| ✅ Confirmación de Angular | `✅ Aplicación Angular compilada y lista.` |
| 🕒 Espera de Nginx | `⏳ Esperando a que Angular termine de compilar...` |
| 🚪 Inicio de Nginx | `✅ Angular está listo. Iniciando Nginx...` |

Una vez que veas el mensaje final:
```
✅ Angular está listo. Iniciando Nginx...
```

➡️ Ya puedes abrir tu navegador y acceder a:

- `http://localhost`
- `https://localhost` (acepta el certificado autofirmado)

---

## ✅ Primer uso (configuración inicial)

### 1. Clona el proyecto o crea los archivos necesarios
Asegúrate de tener esta estructura, especialmente las carpetas `angular_app`, `nginx`, `certs` y `public_html` vacía.

### 2. Genera certificados autofirmados si aún no existen
```bash
mkdir certs
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout certs/nginx-selfsigned.key \
  -out certs/nginx-selfsigned.crt \
  -subj "/CN=localhost"
```

### 3. Levanta el entorno por primera vez
```bash
docker-compose up --build
```

🔁 Esto:
- Creará el proyecto Angular en `./public_html/` (solo si no existe).
- Lo compilará.
- Levantará Nginx y servirá tu app en `http://localhost` o `https://localhost`.

---

## ☕ Reanudando trabajo otro día

Cuando apagues y luego quieras volver a trabajar:

```bash
docker-compose up
```

✔️ Esto retoma donde te quedaste sin reconstruir nada.  
📦 Todo lo que hiciste en `public_html/` se mantiene intacto.

---

## 🔧 Recompilar Angular si haces cambios

Puedes modificar los archivos Angular en `./public_html/` y luego volver a compilar así:

### 🧩 Opción A — Desde tu máquina (si tienes Node/Angular CLI instalados):
```bash
cd public_html
npm install
ng build --configuration production
```

### 🐳 Opción B — Desde el contenedor Angular:
```bash
docker-compose run angular_app bash
cd /app
ng build --configuration production
```

---

## 🧼 Limpieza (opcional)

Si deseas empezar de cero:
```bash
docker-compose down -v
rm -rf public_html/*
```

---

## 🙌 Créditos

Infraestructura creada y adaptada para desarrollo local y despliegue rápido con Angular y Nginx sobre Docker.
