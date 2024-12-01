# Base image
FROM debian:bullseye

# Expose PHP-FPM port
EXPOSE 9000

# Set environment variable for non-interactive installations
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    ca-certificates \
    wget \
    php7.4 \
    php7.4-fpm \
    php7.4-mysql \
    php7.4-phar \
    mariadb-client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create directory for PHP-FPM runtime files
RUN mkdir -p /run/php

# Copy WordPress setup script and make it executable
COPY ./tools/wp.sh /usr/local/bin/wp.sh
RUN chmod +x /usr/local/bin/wp.sh

# Create web root directory and set appropriate permissions
RUN mkdir -p /var/www/html && \
    chown -R www-data:www-data /var/www/html

# Set the entrypoint to launch WordPress setup script
ENTRYPOINT ["/usr/local/bin/wp.sh"]
