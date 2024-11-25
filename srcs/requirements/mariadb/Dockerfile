
# this dockerfile is used to build the image for the mariadb container
# it installs mariadb-server only and copies the configuration file
# the EXPOSE port is 3306 its a way to tell docker that the container will use this port
# at the end it runs the setup_db.sh and start the mysql

FROM	debian:bullseye

EXPOSE	3306

RUN		apt-get update && \
		apt-get install -y --no-install-recommends --no-install-suggests \
		mariadb-server && \
		rm -rf /var/lib/apt/lists/*

COPY	conf/50-server.cnf /etc/mysql/mariadb.conf.d/

COPY	tools/setup_db.sh /bin/
RUN		chmod +x /bin/setup_db.sh

CMD		["setup_db.sh", "mysqld_safe"]