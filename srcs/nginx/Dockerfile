# Utiliser une image de base Alpine
FROM alpine:latest

# Installer Nginx
RUN apk update && \
    apk add nginx && \
    mkdir -p /run/nginx

# Copier la configuration Nginx
COPY ./nginx.conf /etc/nginx/nginx.conf

# Exposer le port pour Nginx
EXPOSE 443

# Commande par défaut pour démarrer Nginx
CMD ["nginx", "-g", "daemon off;"]
