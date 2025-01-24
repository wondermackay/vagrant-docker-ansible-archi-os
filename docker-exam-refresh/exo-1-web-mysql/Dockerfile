FROM nginx:alpine

RUN apk add --no-cache curl mysql-client

COPY index.html /usr/share/nginx/html/

RUN chmod 644 /usr/share/nginx/html/index.html

# Modifier la configuration pour écouter sur le port 5555
RUN sed -i 's/listen\s*80;/listen 5555;/g' /etc/nginx/conf.d/default.conf

# Supprimer la directive user de nginx.conf
RUN sed -i '/user nginx;/d' /etc/nginx/nginx.conf

# Ajuster les chemins des fichiers temporaires et de logs
RUN sed -i 's!^pid\s*/var/run/nginx.pid;!pid /tmp/nginx.pid;!' /etc/nginx/nginx.conf && \
    sed -i 's!error_log\s*/var/log/nginx/error.log warn;!error_log /dev/stderr warn;!' /etc/nginx/nginx.conf && \
    sed -i 's!access_log\s*/var/log/nginx/access.log main;!access_log /dev/stdout main;!' /etc/nginx/nginx.conf && \
    sed -i '/^http {/a \    client_body_temp_path /tmp/client_temp;\n    proxy_temp_path /tmp/proxy_temp;\n    fastcgi_temp_path /tmp/fastcgi_temp;\n    uwsgi_temp_path /tmp/uwsgi_temp;\n    scgi_temp_path /tmp/scgi_temp;' /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]
