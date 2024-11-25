# Utiliser la version penultième stable d'Alpine comme base
FROM alpine:3.18

# Installer PHP, PHP-FPM et les dépendances nécessaires
RUN apk update && apk add --no-cache \
    php8 \
    php8-fpm \
    php8-opcache \
    php8-mysqli \
    php8-json \
    php8-session \
    php8-curl \
    php8-dom \
    php8-exif \
    php8-fileinfo \
    php8-mbstring \
    php8-openssl \
    php8-xml \
    php8-zip \
    mariadb-client \
    bash \
    wget \
    curl \
    openssl \
    && mkdir -p /run/php \
    && rm -rf /var/cache/apk/*

# Créer le dossier pour WordPress
RUN mkdir -p /var/www/html

# Copier le script de configuration
COPY tools/setup_wp.sh /setup_wp.sh

# Donner les permissions d'exécution au script
RUN chmod +x /setup_wp.sh

# Définir le dossier de travail
WORKDIR /var/www/html

# Exposer le port utilisé par PHP-FPM
EXPOSE 9000

# Commande d'entrée pour exécuter le script et lancer PHP-FPM
CMD ["/setup_wp.sh"]
