#using debian buster image
FROM debian:bullseye

EXPOSE 443

# Install Nginx and OpenSSL
RUN apt-get update -y \
    && apt-get install -y nginx openssl \
    && apt-get clean

#we need to setup the nginx conf
RUN rm -f /etc/nginx/nginx.conf

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

#we need to create the TLS certificate
RUN mkdir -p /etc/nginx/ssl

#we create a self-signed certificate that doesn't ned a password
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/inception.key \
    -out /etc/nginx/ssl/inception.crt \
    -subj "/CN=mos.42.fr"
    # -subj "/C=${SSL_COUNTRY}/ST=${SSL_STATE}/L=${SSL_LOCALITY}/O=${SSL_ORGANIZATION}/OU=${SSL_ORG_UNIT}/CN=${SSL_COMMON_NAME}/UID=${SSL_UID}"

RUN chown -R www-data:www-data /var/www/html

#starts the NGINX server amd ensures it runs in the foreground
CMD ["nginx", "-g", "daemon off;"]