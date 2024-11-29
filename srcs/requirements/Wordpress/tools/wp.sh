#!/bin/bash

### No clear_env to keep environment variables
sed -i 's/;clear_env = no/clear_env = no/' /etc/php/7.3/fpm/pool.d/www.conf

# create necessary directories
mkdir -p /var/www/html/wordpress
chown -R www-data:www-data /var/www/html/wordpress
cd /var/www/html/wordpress 

# Check if wp-cli is already downloaded
if [ ! -f /usr/local/bin/wp ]; then
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    # make it executable and copy to bin
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
fi

# Check if WordPress is already installed
if ! wp core is-installed --allow-root; then
    wp core download --allow-root
else
    echo "WordPress is already installed."
fi

# Generate wp-config.php file
if [ ! -f /var/www/html/wordpress/wp-config.php ]; then
    wp config create --dbname=$DB_NAME \
        --dbuser=$DB_USER \
        --dbpass=$DB_PASS \
        --dbhost=$DB_HOST \
        --path=/var/www/html/wordpress --allow-root
fi

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
    --allow-root

if [ -f /var/www/html/wordpress/wp-config.php ]; then
    echo "Enabling debug mode."
    sed -i "s/define( 'WP_DEBUG', false );/define( 'WP_DEBUG', true );/" /var/www/html/wordpress/wp-config.php
fi

# updates the PHP-FPM configuration file to listen on port 9000 instead of using a Unix socket.
sed -i 's/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/g' /etc/php/7.3/fpm/pool.d/www.conf

# start PHP-FPM service
/usr/sbin/php-fpm7.3 -F -R --nodaemonize


# #!/bin/bash

# ### No clear_env to keep environment variables
# sed -i 's/;clear_env = no/clear_env = no/' /etc/php/7.3/fpm/pool.d/www.conf
# # ### Make php in foreground
# # sed -i 's/;daemonize = yes/daemonize = no/' /etc/php/$php_version/fpm/php-fpm.conf

# # create necessary directories
# mkdir -p /var/www/html/wordpress
# chown -R www-data:www-data /var/www/html/wordpress
# cd /var/www/html/wordpress 
# curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
# # make it executable and copy to bin
# chmod +x wp-cli.phar
# mv wp-cli.phar /usr/local/bin/wp
# wp core download --allow-root


# # Generate wp-config.php file
# if [ ! -f /var/www/html/wordpress/wp-config.php ]; then
#     wp config create --dbname=$DB_NAME \
#         --dbuser=$DB_USER \
#         --dbpass=$DB_PASS \
#         --dbhost=$DB_HOST \
#         --path=/var/www/html/wordpress  --allow-root
# fi


# # Check if WordPress is already installed
# if ! wp core is-installed --allow-root; then   
#     # Install WordPress
#     wp core install \
#         --url=$DOMAIN_NAME \
#         --title=$SITE_TITLE \
#         --admin_user=$ADMIN_USER \
#         --admin_password=$ADMIN_PASS \
#         --admin_email=$ADMIN_EMAIL \
#         --path=/var/www/html/wordpress \
#         --allow-root

#     # create a new user
#     wp user create \
#         $USER $EMAIL \
#         --role=author \
#         --allow-root
# else
#     echo "WordPress is already installed."
# fi

# # updates the PHP-FPM configuration file to listen on port 9000 instead of using a Unix socket.
# sed -i 's/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/g' /etc/php/7.3/fpm/pool.d/www.conf

# # start PHP-FPM service
# /usr/sbin/php-fpm7.3 -F -R --nodaemonize
