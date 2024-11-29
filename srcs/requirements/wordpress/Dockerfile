FROM debian:buster

RUN apt-get update \
    && apt-get install -y \
    php-fpm \
    php-mbstring \
    php-mysql \
    php-phar curl \
    mariadb-client \
    sendmail

RUN mkdir -p /var/www/html /run/php

COPY ./tools/wp.sh /

RUN chmod +x /wp.sh

CMD ["sh", "/wp.sh"]