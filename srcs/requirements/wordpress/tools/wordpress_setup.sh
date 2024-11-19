#!/bin/bash

sleep 10

# PHP configuration

php_version=$(php -v | head -n 1 | awk '{print substr($2, 1, 3)}')

## Edit php-fpm configuration
### No clear_env to keep environment variables
sed -i 's/;clear_env = no/clear_env = no/' /etc/php/$php_version/fpm/pool.d/www.conf
### Change listen to 9000 (container port)
sed -i "s/listen = \/run\/php\/php$php_version-fpm.sock/listen = 9000/" /etc/php/$php_version/fpm/pool.d/www.conf
### Fix path info (security - prevent from executing php files in the wrong directory)
sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/' /etc/php/$php_version/fpm/php.ini
### Make php in foreground
sed -i 's/;daemonize = yes/daemonize = no/' /etc/php/$php_version/fpm/php-fpm.conf

# Wordpress configuration

## Install WP-CLI
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -P /usr/local/bin/
chmod +x /usr/local/bin/wp-cli.phar
mv /usr/local/bin/wp-cli.phar /usr/local/bin/wp

## Recover password from secret file
database_password=e40bbe
wp_admin_password=e40bbe
wp_user_password=e40bbe

## Download Wordpress
wp core download --path='/var/www/html/wordpress' --allow-root
cd /var/www/html/wordpress
## Set permissions for Wordpress files (www-data - allow to write)
chmod -R 774 /var/www/html/wordpress
chown -R www-data:www-data /var/www/html/wordpress

## Check if wp-config.php exists
if [ ! -f wp-config.php ] ; then
	echo "[Creating wp-config.php]"
	## Create wp-config.php
	wp config create \
		--dbhost=mos \
		--dbname=WORDPRESS_DB_NAME \
		--dbuser=WORDPRESS_DB_USER \
		--dbpass=e40bbe \
		--dbprefix=wp_ \
		--allow-root
fi
## Check if Wordpress is installed
if ! wp core is-installed --allow-root ; then
	echo "[Installing Wordpress]"
	## Setup Wordpress URL,Title,PATH and Admin user
	wp core install \
		--url=mos.42.fr \
		--title=mostafa \
		--admin_user=admin_user \
		--admin_password=e40bbe \
		--admin_email=mostafa.omrane@proton.me \
		--skip-email \
		--allow-root
	echo "[Creating user mousse]"
	## Add User
	wp user create \
		mousse mostafa.omrane@proton.me \
		--role=editor \
		--user_pass=e40bbe \
		--allow-root
fi

# Start

php-fpm$php_version -F -R --nodaemonize