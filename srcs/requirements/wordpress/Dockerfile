FROM	debian:bullseye

# RUN		env

# EXPOSE	9000

# ARG		PHPPATH=/etc/php/7.4/fpm

RUN		apt-get update && apt-get install --no-install-recommends --no-install-suggests -y \
		php7.4-fpm

COPY	conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

# RUN		service php7.4-fpm stop

# COPY	conf/www.conf ${PHPPATH}/pool.d/

# RUN		sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' ${PHPPATH}/php.ini && \
# 		sed -i "s/listen = \/run\/php\/php$PHP_VERSION_ENV-fpm.sock/listen = 9000/g" ${PHPPATH}/pool.d/www.conf && \
# 		sed -i 's/;listen.mode = 0660/listen.mode = 0660/g' ${PHPPATH}/pool.d/www.conf && \
# 		sed -i 's/;daemonize = yes/daemonize = no/g' ${PHPPATH}/pool.d/www.conf

# RUN		wget --no-check-certificate https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
# 		chmod +x wp-cli.phar && \
# 		mv wp-cli.phar /usr/local/bin/wp

# RUN		mkdir -p /run/php/ && \
# 		mkdir -p /var/run/php/ && \
# 		mkdir -p /var/www/html/

# RUN		chown -R www-data:www-data /var/www/html/

# COPY	conf/wp-config.php /tmp/

# COPY	tools/setup_wp.sh /bin/
# RUN		chmod +x /bin/setup_wp.sh

# CMD		["setup_wp.sh", "php-fpm7.4", "--nodaemonize"]
CMD		["php-fpm7.4", "-F"]