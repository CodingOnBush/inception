#!/bin/bash

# Get password from secret file
psswd=$(cat $MYSQL_PASSWORD_FILE)
root_psswd=$(cat $MYSQL_ROOT_PASSWORD_FILE)
#mysql_grafana_password=$(cat $MYSQL_GRAFANA_PASSWORD_FILE)

# MariaDB configuration

# Config the database
## Start the service
service mariadb start

sleep 5

# Create Database
echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;" > /tmp/database.sql
## Create user with access from localhost
echo "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'localhost' IDENTIFIED BY '$psswd';" >> /tmp/database.sql
## Give elevated privileges to created user for all the tables in the database (%: mean can connect form any host: localhost and other address)
echo "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$psswd';" >> /tmp/database.sql

## [Grafana]
### Add a grafana user
#echo "CREATE USER IF NOT EXISTS '$MYSQL_GRAFANA_USER'@'localhost' IDENTIFIED BY '$mysql_grafana_password';" >> /tmp/database.sql
### Give elevated privileges to created user for read access to the database (%: mean can connect form any host: localhost and other address)
#echo "GRANT SELECT ON $MYSQL_DATABASE.* TO '$MYSQL_GRAFANA_USER'@'%' IDENTIFIED BY '$mysql_grafana_password';" >> /tmp/database.sql

## Protect root connection via localhost
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$root_psswd';" >> /tmp/database.sql
## Load changes into database
echo "FLUSH PRIVILEGES;" >> /tmp/database.sql
## Load changes into database
mysql < /tmp/database.sql
## Remove the file
rm -f /tmp/database.sql

# Launch in recommended: safety mode (with auto restart in case of error and more safety features)
## Stop MYSQL server
kill $(cat /var/run/mysqld/mysqld.pid)
## Restart with CMD command
exec $@

##!/bin/sh

##start my sql service
#service mysql start;

## create a database (if the database does not exist)
#mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"

## create an user with a password (if the user does not exist)
#mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"

## give all privileges to the user
#mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"

##modify sql database
#mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"

##reload the database
#mysql -e "FLUSH PRIVILEGES;"

##shutdown
#mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown

##use exec to 
#exec mysqld_safe