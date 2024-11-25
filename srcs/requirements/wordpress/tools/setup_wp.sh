#!/bin/sh

# Script de configuration et d'installation de WordPress

# Variables
WORDPRESS_ROOT=/var/www/html
WORDPRESS_URL="https://wordpress.org/latest.tar.gz"

# Créer le répertoire pour WordPress
mkdir -p $WORDPRESS_ROOT

# Télécharger et extraire WordPress
echo "Téléchargement de WordPress..."
wget -q -O /tmp/wordpress.tar.gz $WORDPRESS_URL
tar -xzf /tmp/wordpress.tar.gz -C /tmp
mv /tmp/wordpress/* $WORDPRESS_ROOT

# Configurer les permissions
echo "Configuration des permissions..."
chown -R www-data:www-data $WORDPRESS_ROOT
chmod -R 755 $WORDPRESS_ROOT

# Générer le fichier wp-config.php
echo "Création de wp-config.php..."
cat > $WORDPRESS_ROOT/wp-config.php <<EOL
<?php
define('DB_NAME', getenv('MYSQL_DATABASE'));
define('DB_USER', getenv('MYSQL_USER'));
define('DB_PASSWORD', getenv('MYSQL_PASSWORD'));
define('DB_HOST', 'mariadb');
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');
define('AUTH_KEY',         '$(openssl rand -base64 32)');
define('SECURE_AUTH_KEY',  '$(openssl rand -base64 32)');
define('LOGGED_IN_KEY',    '$(openssl rand -base64 32)');
define('NONCE_KEY',        '$(openssl rand -base64 32)');
define('AUTH_SALT',        '$(openssl rand -base64 32)');
define('SECURE_AUTH_SALT', '$(openssl rand -base64 32)');
define('LOGGED_IN_SALT',   '$(openssl rand -base64 32)');
define('NONCE_SALT',       '$(openssl rand -base64 32)');
\$table_prefix = 'wp_';
define('WP_DEBUG', false);
if ( !defined('ABSPATH') )
    define('ABSPATH', dirname(__FILE__) . '/');
require_once(ABSPATH . 'wp-settings.php');
EOL

# Nettoyage
echo "Nettoyage..."
rm -rf /tmp/wordpress /tmp/wordpress.tar.gz

echo "WordPress est installé et configuré !"

# Lancer PHP-FPM
php-fpm8 -F
