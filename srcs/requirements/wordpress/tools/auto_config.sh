#!/bin/bash

# Attendre que la base de données MariaDB soit disponible
sleep 10

# Se rendre dans le répertoire de WordPress
cd /var/www/wordpress

# Si le fichier wp-config.php n'existe pas, le créer
if [ ! -f wp-config.php ]; then
    wp config create --allow-root \
    --dbname=$SQL_DATABASE \
    --dbuser=$SQL_USER \
    --dbpass=$SQL_PASSWORD \
    --dbhost=mariadb:3306 --path='/var/www/wordpress'

    # Installer WordPress avec les informations de base
    wp core install --allow-root \
    --url=$DOMAIN_NAME \
    --title="Inception WordPress" \
    --admin_user=$WP_ADMIN_USER \
    --admin_password=$WP_ADMIN_PASSWORD \
    --admin_email=$WP_ADMIN_EMAIL

    # Créer un utilisateur supplémentaire
    wp user create $WP_USER $WP_USER_EMAIL --role=author --user_pass=$WP_USER_PASSWORD --allow-root
fi

# Démarrer PHP-FPM
/usr/sbin/php-fpm7.3 -F