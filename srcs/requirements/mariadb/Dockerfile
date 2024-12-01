FROM debian:bullseye

# Set environment variable for non-interactive mode
ENV DEBIAN_FRONTEND=noninteractive

# Expose default MariaDB port
EXPOSE 3306

# Update base image, install MariaDB server, and clean up apt cache to reduce image size
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    mariadb-server && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Remove default MariaDB configuration file
RUN rm /etc/mysql/mariadb.conf.d/50-server.cnf

# Copy custom MariaDB configuration file to the appropriate location
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

# Copy and make the database setup script executable
COPY ./tools/db.sh /usr/local/bin/db.sh
RUN chmod +x /usr/local/bin/db.sh

# Set default command to run the setup script and start MariaDB server
CMD ["/usr/local/bin/db.sh"]
