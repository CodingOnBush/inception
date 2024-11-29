#using debian buster image
FROM debian:buster

# Install Nginx and OpenSSL
RUN apt-get update && apt-get install -y nginx openssl
#create ssl folder
RUN mkdir -p /etc/nginx/ssl

#generate ssl certificate
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/CN=mos.42.fr"

#copy new  nginx config file
COPY ./conf/nginx.conf /etc/nginx/sites-available/default

#execute nginx
CMD ["nginx", "-g", "daemon off;"]
