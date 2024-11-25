# Utiliser la version penultième stable d'Alpine comme base
FROM alpine:3.18

# Mettre à jour le système et installer NGINX, OpenSSL et les outils nécessaires
RUN apk update && apk add --no-cache \
    nginx \
    openssl \
    && rm -rf /var/cache/apk/*

# Créer les dossiers nécessaires pour les certificats SSL et les fichiers web
RUN mkdir -p /etc/nginx/ssl /var/www/html

# Copier la configuration NGINX personnalisée dans le conteneur
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Copier le script d'installation dans le conteneur
COPY tools/setup_nginx.sh /setup_nginx.sh

# Donner les droits d'exécution au script
RUN chmod +x /setup_nginx.sh

# Exposer le port HTTPS uniquement
EXPOSE 443

# Commande pour exécuter le script d'installation et démarrer NGINX
CMD ["/setup_nginx.sh"]
