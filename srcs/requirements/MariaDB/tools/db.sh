#!/bin/bash

 # Start mysql service
 service mysql start

 # Create SQL file with database setup commands
 echo "CREATE DATABASE IF NOT EXISTS $DB_NAME ;" > /tmp/db.sql

 echo "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS' ;" >> /tmp/db.sql

 echo "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%' ;" >> /tmp/db.sql

 echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASS' ;" >> /tmp/db.sql

 echo "FLUSH PRIVILEGES;" >> /tmp/db.sql

# Execute SQL file
mysql -u root -p"$DB_ROOT_PASS" < /tmp/db.sql
# mysql < /tmp/db.sql

rm -f /tmp/db.sql

# Stop mysql service            |  #  sends a signal to the MariaDB process to stop it
service mysql stop			    |  #  kill $(cat /var/run/mysqld/mysqld.pid)

# kill $(cat /var/run/mysqld/mysqld.pid)

mysqld
#  mysqld --bind-address=0.0.0.0