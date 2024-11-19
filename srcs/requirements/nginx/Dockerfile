FROM debian:bullseye

# Installer NGINX
RUN apt-get update -y && \
	apt-get upgrade -y && \
    apt-get install -y vim curl nginx openssl

COPY conf/nginx.conf /etc/nginx/nginx.conf
RUN	mkdir -p /etc/nginx/ssl

# SSL certificate 
RUN	openssl req \
	-x509 \
	-nodes \
	-out /etc/nginx/ssl/inception.crt \
	-keyout /etc/nginx/ssl/inception.key \
	-subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=mos.42.fr/UID=mos"

RUN chmod 644 /etc/nginx/ssl/inception.crt /etc/nginx/ssl/inception.key
RUN chown -R www-data:www-data /var/www/html

CMD ["nginx", "-g", "daemon off;"]