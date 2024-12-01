#!/bin/bash

mkdir -p /var/www/html/wordpress
chmod -R 774 /var/www/html/wordpress
chown -R www-data:www-data /var/www/html/wordpress
cd /var/www/html/wordpress

wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

wp core download --allow-root

echo "Waiting for MariaDB to be ready..."
# until mysql -h "$DB_HOST" -u root -p"$DB_ROOT_PASS" -e "SHOW DATABASES;" &>/dev/null; do
#     echo "MariaDB is not ready, waiting..."
#     sleep 2
# done
sleep 10
mysql -h "$DB_HOST" -u root -p"$DB_ROOT_PASS" -e "SHOW DATABASES;"
echo "MariaDB is ready!"

if [ ! -f wp-config.php ];
then
    echo "wp-config.php creation in progress"
    wp config create --allow-root \
        --dbname=$DB_NAME \
        --dbhost=$DB_HOST \
        --dbuser=$DB_USER \
        --dbpass=$DB_PASS \
        --dbprefix=wp_

    echo "wp-config.php created successfully!"
fi

if ! wp core is-installed --allow-root ; then
	echo "Installing Wordpress..."
    wp core install \
		--url=$WP_URL \
		--admin_email=$WP_ADMIN_EMAIL \
		--title="Inception" \
		--admin_user=$WP_ADMIN_USER \
		--admin_password=$WP_ADMIN_PASSWORD \
		--skip-email \
		--allow-root
    
    #we create the non-admin user as editor
    echo "Install done, "$WP_USER" user creation..."
    wp  user create\
        $WP_USER $WP_USER_EMAIL \
        --role=$WP_ROLE \
        --user_pass=$WP_ADMIN_PASSWORD \
        --allow-root
fi

# #set the php version from the system
php_version=$(php -v | head -n 1 | awk '{print substr($2, 1, 3)}')

# we keep our environment variables for NGINX
sed -i 's/;clear_env = no/clear_env = no/' /etc/php/$php_version/fpm/pool.d/www.conf

#we ensure that we are listenng on port 9000
sed -i "s/listen = \/run\/php\/php$php_version-fpm.sock/listen = 9000/" /etc/php/$php_version/fpm/pool.d/www.conf

#we ensure that php will run in the foreground
sed -i 's/;daemonize = yes/daemonize = no/' /etc/php/$php_version/fpm/php-fpm.conf

# for security reasons
sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/' /etc/php/$php_version/fpm/php.ini

#if the wp config doesn't exist we create it

#runs th fastCGI process manager in the foreground and in debug mode
php-fpm$php_version -F -R --nodaemonize
# exec "$@"