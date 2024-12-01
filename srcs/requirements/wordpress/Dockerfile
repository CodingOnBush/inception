#base image
FROM debian:bullseye

EXPOSE 9000

RUN apt-get update &&\
    apt-get upgrade -y &&\
    apt-get -y install --no-install-recommends --no-install-suggests \
    ca-certificates \
    wget \
    php7.4 \
    php7.4-fpm \
    php7.4-mysql \
    php7.4-phar \
    mariadb-client && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/php

#we make the launching script executable in all cases
COPY ./tools/wp.sh /usr/local/bin
RUN chmod +x /usr/local/bin/wp.sh

RUN mkdir -p /var/www/html
RUN chown -R www-data:www-data /var/www/html

ENTRYPOINT [ "wp.sh" ]

# FROM debian:buster

# RUN apt-get update \
#     && apt-get install -y \
#     php-fpm \
#     php-mbstring \
#     php-mysql \
#     php-phar curl \
#     mariadb-client \
#     sendmail

# RUN mkdir -p /var/www/html /run/php

# COPY ./tools/wp.sh /

# RUN chmod +x /wp.sh

# CMD ["sh", "/wp.sh"]