FROM node:lts

WORKDIR /tmp/angular

RUN npm install -g @angular/cli

CMD sh -c "\
  if [ ! -f /app/angular.json ]; then \
    echo '📦 Creando proyecto Angular...' && \
    ng new my-angular-app --defaults --skip-git && \
    cp -a my-angular-app/. /app && rm -rf my-angular-app; \
  fi && \
  cd /app && npm install && ng build --configuration production && \
  echo '✅ Aplicación Angular compilada y lista.'"
