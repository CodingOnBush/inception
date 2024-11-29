FROM debian:buster

RUN apt-get update \
    && apt-get install -y mariadb-server

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./tools/db.sh /
RUN chmod +x /db.sh
CMD ["/db.sh"]
