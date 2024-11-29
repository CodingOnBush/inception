FROM debian:buster

RUN apt-get update \
    && apt-get install -y mariadb-server

COPY ./conf/my.cnf /etc/mysql/mariadb.conf.d/my.cnf
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
RUN echo "socket=/var/run/mysqld/mysqld.sock" >> /etc/mysql/my.cnf
COPY ./tools/db.sh /
RUN chmod +x /db.sh
CMD ["/db.sh"]
