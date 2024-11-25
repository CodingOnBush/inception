#!/bin/bash

# this script run in the building container
# it changes the ownership of the /var/www/inception/ folder to www-data user
# then sure that the wp-config.php file is in the /var/www/inception/ folder
# then it downloads the wordpress core files if they are not already there
# then it installs wordpress if it is not already installed
# and set the admin user and password if they are not already set
# this variables are set in the .env file
# the penultimate line download and activate the raft theme, that I liked most
# at the end, exec $@ run the next CMD in the Dockerfile.
# In this case: starts the php-fpm7.4 server in the foreground

# set -ex # print commands & exit on error (debug mode)

# WP_URL=mos.42.fr
# WP_TITLE=Inception
# WP_ADMIN_USER=theroot
# WP_ADMIN_PASSWORD=123
# WP_ADMIN_EMAIL=theroot@123.com
# WP_USER=theuser
# WP_PASSWORD=abc
# WP_EMAIL=theuser@123.com
# WP_ROLE=editor

chown -R www-data:www-data /var/www/inception/

if [ ! -f "/var/www/inception/wp-config.php" ]; then
   echo "copying wp-config.php QPOWMDPQOMWDMQWMDPOMQWOPDQPOWMDPMQWDOMQPMWODPOQMWQPOWMDPQOMWDMQWMDPOMQWOPDQPOWMDPMQWDOMQPMWODPOQMWQPOWMDPQOMWDMQWMDPOMQWOPDQPOWMDPMQWDOMQPMWODPOQMW"
   mv /tmp/wp-config.php /var/www/inception/
fi

sleep 10

wp --allow-root --path="/var/www/inception/" core download || true

if ! wp --allow-root --path="/var/www/inception/" core is-installed;
then
    wp  --allow-root --path="/var/www/inception/" core install \
        --url=mos.42.fr \
        --title=Inception \
        --admin_user=theroot \
        --admin_password=123 \
        --admin_email=theroot@123.com
fi;

if ! wp --allow-root --path="/var/www/inception/" user get theuser;
then
    wp  --allow-root --path="/var/www/inception/" user create \
        theuser \
        theuser@123.com \
        --user_pass=abc \
        --role=editor
fi;

wp --allow-root --path="/var/www/inception/" theme install raft --activate 

exec $@