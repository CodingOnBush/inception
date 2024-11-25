#!/bin/bash

# Database settings
DB_NAME=thedatabase
DB_USER=theuser
DB_PASSWORD=abc
DB_PASS_ROOT=123
DB_HOST=mariadb

# Wordpress settings
WP_URL=mos.42.fr
WP_TITLE=Inception
WP_ADMIN_USER=theroot
WP_ADMIN_PASSWORD=123
WP_ADMIN_EMAIL=theroot@123.com
WP_USER=theuser
WP_PASSWORD=abc
WP_EMAIL=theuser@123.com
WP_ROLE=editor
WP_FULL_URL=https://mos.42.fr

# SSL settings
CERT_FOLDER=/etc/nginx/certs/
CERTIFICATE=/etc/nginx/certs/certificate.crt
KEY=/etc/nginx/certs/certificate.key
COUNTRY=BR
STATE=BA
LOCALITY=Salvador
ORGANIZATION=42
UNIT=42
COMMON_NAME=mos.42.fr

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
# database_password=abc
wp_admin_password=$WP_ADMIN_PASSWORD
wp_user_password=$WP_PASSWORD

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
		--dbhost=$DB_HOST \
		--dbname=$DB_NAME \
		--dbuser=$DB_USER \
		--dbpass=$DB_PASSWORD \
		--dbprefix=wp_ \
		--allow-root
fi
## Check if Wordpress is installed
if ! wp core is-installed --allow-root ; then
	echo "[Installing Wordpress]"
	## Setup Wordpress URL,Title,PATH and Admin user
	wp core install \
		--url=$WP_URL \
		--title=$WP_TITLE \
		--admin_user=$WP_ADMIN_USER \
		--admin_password=$wp_admin_password \
		--admin_email=$WP_ADMIN_EMAIL \
		--skip-email \
		--allow-root
	echo "[Creating user $WP_USER]"
	## Add User
	wp user create \
		$WP_USER $WP_EMAIL \
		--role=editor \
		--user_pass=$wp_user_password \
		--allow-root
fi
# Start

php-fpm$php_version -F -R --nodaemonize