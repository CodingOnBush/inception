# Utiliser l'avant-dernière version stable d'Alpine comme base
FROM alpine:3.17

# Installer nginx et openssl pour générer les certificats
RUN apk update && apk add --no-cache nginx openssl

# Créer un répertoire pour les certificats SSL et générer un certificat auto-signé
RUN mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=FR/ST=Paris/L=Paris/O=42School/OU=IT Department/CN=login.42.fr"

# Copier le fichier de configuration nginx
COPY ./nginx.conf /etc/nginx/nginx.conf

# Créer les répertoires nécessaires
RUN mkdir -p /run/nginx

# Exposer le port 443 pour le trafic HTTPS
EXPOSE 443

# Définir la commande par défaut pour lancer nginx
CMD ["nginx", "-g", "daemon off;"]
