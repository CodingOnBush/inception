#!/bin/bash

# create necessary directories
mkdir -p /var/www/html/wordpress
chown -R www-data:www-data /var/www/html/wordpress
cd /var/www/html/wordpress 

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
# make it executable and copy to bin
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp
wp core download --allow-root
# change to directory for WordPress installation

# Generate wp-config.php file
wp config create --dbname=$DB_NAME \
                --dbuser=$DB_USER \
                --dbpass=$DB_PASS \
                --dbhost=$DB_HOST \
                --path=/var/www/html/wordpress  --allow-root
                       
# Install WordPress
wp core install \
    --url=$DOMAIN_NAME \
    --title=$SITE_TITLE \
    --admin_user=$ADMIN_USER \
    --admin_password=$ADMIN_PASS \
    --admin_email=$ADMIN_EMAIL \
    --path=/var/www/html/wordpress \
    --allow-root

# create a new user
wp user create \
    $USER $EMAIL \
    --role=author \
    --user_pass=$PASS \
    --allow-root

# update PHP-FPM configuration : updates the PHP-FPM configuration file to listen on port 9000 instead of using a Unix socket. 
sed -i 's/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/g' /etc/php/7.3/fpm/pool.d/www.conf

# start PHP-FPM service
/usr/sbin/php-fpm7.3 -F -R
