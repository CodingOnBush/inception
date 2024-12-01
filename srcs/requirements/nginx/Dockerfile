FROM debian:bullseye

EXPOSE 443

RUN apt-get update -y \
    && apt-get install -y nginx openssl \
    && apt-get clean

RUN rm -f /etc/nginx/nginx.conf

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/inception.key \
    -out /etc/nginx/ssl/inception.crt \
    -subj "/CN=momrane.42.fr"

RUN chown -R www-data:www-data /var/www/html

CMD ["nginx", "-g", "daemon off;"]