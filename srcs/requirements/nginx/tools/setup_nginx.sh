#!/bin/sh

# Script d'installation et de configuration pour NGINX

# Créer les dossiers nécessaires pour les certificats SSL et les fichiers web
mkdir -p /etc/nginx/ssl /var/www/html

# Générer un certificat SSL auto-signé (remplacez "yourdomain.com" par votre domaine)
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=FR/ST=Ile-de-France/L=Paris/O=42/OU=IT Department/CN=yourdomain.com"

# Appliquer les bonnes permissions sur les fichiers du certificat
chmod 600 /etc/nginx/ssl/nginx.key /etc/nginx/ssl/nginx.crt

# Créer un fichier d'exemple pour le site web
echo "<h1>Bienvenue sur votre site sécurisé avec NGINX !</h1>" > /var/www/html/index.html

# Assurer les permissions correctes sur les fichiers du site web
chown -R nginx:nginx /var/www/html

# Démarrer NGINX
nginx -g "daemon off;"
