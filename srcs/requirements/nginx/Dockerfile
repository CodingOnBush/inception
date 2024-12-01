# Using Debian Bullseye image
FROM debian:bullseye

# Expose HTTPS port
EXPOSE 443

# Set environment variable to run non-interactive installations
ENV DEBIAN_FRONTEND=noninteractive

# Install Nginx and OpenSSL
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends nginx openssl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy custom Nginx configuration
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# Create directory for SSL certificates
RUN mkdir -p /etc/nginx/ssl

# Create a self-signed TLS certificate without password
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/inception.key \
    -out /etc/nginx/ssl/inception.crt \
    -subj "/CN=momrane.42.fr"

# Change ownership of web directory to Nginx user
RUN chown -R www-data:www-data /var/www/html

# Ensure Nginx runs in the foreground
CMD ["nginx", "-g", "daemon off;"]
