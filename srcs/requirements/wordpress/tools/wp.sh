#!/bin/bash

# Create WordPress directory and set permissions
mkdir -p /var/www/html/wordpress
chmod -R 775 /var/www/html/wordpress  # Provide full access to owner and group, read access to others
chown -R www-data:www-data /var/www/html/wordpress  # Set ownership to www-data user and group

# Navigate to WordPress directory
cd /var/www/html/wordpress

wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# Download WordPress core
wp core download --allow-root

# Wait for MariaDB to be ready
echo "Waiting for MariaDB to be ready..."
until mysql -h "$DB_HOST" -u root -p"$DB_ROOT_PASS" -e "SHOW DATABASES;" &>/dev/null; do
    echo "MariaDB is not ready, waiting..."
    sleep 2
done
echo "MariaDB is ready!"

# Create wp-config.php if it doesn't exist
if [ ! -f wp-config.php ]; then
    echo "Creating wp-config.php..."
    wp config create --allow-root \
        --dbname="$DB_NAME" \
        --dbhost="$DB_HOST" \
        --dbuser="$DB_USER" \
        --dbpass="$DB_PASS" \
        --dbprefix="wp_"
    echo "wp-config.php created successfully!"
else
    echo "wp-config.php already exists!"
fi

# Install WordPress if not already installed
if ! wp core is-installed --allow-root; then
    echo "Installing WordPress..."
    wp core install --allow-root \
        --url="$WP_URL" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --title="Inception" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --skip-email
    
    # Create non-admin user
    echo "Creating user: $WP_USER..."
    wp user create --allow-root \
        "$WP_USER" "$WP_USER_EMAIL" \
        --role="$WP_ROLE" \
        --user_pass="$WP_USER_PASSWORD"
else
    echo "WordPress is already installed!"
fi

# Set the PHP version from the system
# php_version=$(php -v | head -n 1 | awk '{print substr($2, 1, 3)}')

# Update PHP-FPM pool configuration to keep environment variables and listen on port 9000
sed -i 's/;clear_env = no/clear_env = no/' /etc/php/7.4/fpm/pool.d/www.conf
sed -i "s|listen = /run/php/php7.4-fpm.sock|listen = 9000|" /etc/php/7.4/fpm/pool.d/www.conf

# Ensure PHP-FPM runs in the foreground
sed -i 's/;daemonize = yes/daemonize = no/' /etc/php/7.4/fpm/php-fpm.conf

# Disable cgi.fix_pathinfo for security reasons
sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/' /etc/php/7.4/fpm/php.ini

# Start PHP-FPM in the foreground with no daemon mode
php-fpm7.4 -F -R --nodaemonize
