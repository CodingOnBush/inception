FROM debian:bullseye

RUN apt-get update && apt-get install -y nginx && apt-get clean

COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./ssl /etc/nginx/ssl

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
