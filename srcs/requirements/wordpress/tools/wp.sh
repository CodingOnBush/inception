#!/bin/bash

mkdir -p /run/php
mkdir -p /var/www/html/wordpress
chmod -R 774 /var/www/html/wordpress
chown -R www-data:www-data /var/www/html/wordpress
chown -R root:root /var/www/wordpress
cd /var/www/html/wordpress

sleep 5

if [ ! -f wp-cli.phar ]; then
    wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
fi

if [ ! -f wp-load.php ]; then
    wp core download --allow-root
fi

# we wait for the database to be ready
sleep 10
mysql -h "$DB_HOST" -u root -p"$DB_ROOT_PASS" -e "SHOW DATABASES;"

if [ ! -f wp-config.php ]; then
    wp config create --allow-root \
        --dbname=$DB_NAME \
        --dbhost=$DB_HOST \
        --dbuser=$DB_USER \
        --dbpass=$DB_PASS \
        --dbprefix=wp_
else
    echo "wp-config.php already exists"
fi

if ! wp core is-installed --allow-root ; then
    wp core install \
		--url=$WP_URL \
		--admin_email=$WP_ADMIN_EMAIL \
		--title="Inception" \
		--admin_user=$WP_ADMIN_USER \
		--admin_password=$WP_ADMIN_PASSWORD \
		--skip-email \
		--allow-root
    
    wp  user create\
        $WP_USER $WP_USER_EMAIL \
        --role=$WP_ROLE \
        --user_pass=$WP_ADMIN_PASSWORD \
        --allow-root
else
    echo "WordPress is already installed"
fi

# we keep our environment variables for NGINX
sed -i 's/;clear_env = no/clear_env = no/' /etc/php/7.4/fpm/pool.d/www.conf

#we ensure that we are listenng on port 9000
sed -i "s/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/" /etc/php/7.4/fpm/pool.d/www.conf

#we ensure that php will run in the foreground
sed -i 's/;daemonize = yes/daemonize = no/' /etc/php/7.4/fpm/php-fpm.conf

echo "WordPress is ready to use"

#runs th fastCGI process manager in the foreground and in debug mode
php-fpm7.4 -F -R --nodaemonize