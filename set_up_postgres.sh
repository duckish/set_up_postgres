#!/bin/sh -e

sudo apt update && apt -y install gnupg2

wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

RELEASE=$(lsb_release -cs)

echo $RELEASE

echo "deb http://apt.postgresql.org/pub/repos/apt/ ${RELEASE}"-pgdg main | sudo tee  /etc/apt/sources.list.d/pgdg.list

sudo apt update
sudo apt -y install postgresql-12 postgresql-client-12

APP_DB_USER=dbuser
APP_DB_PASS=dbpass

# Edit the following to change the name of the database that is created (defaults to the user name)
APP_DB_NAME=dbname

PG_CONF="/etc/postgresql/12/main/postgresql.conf"
PG_HBA="/etc/postgresql/12/main/pg_hba.conf"
PG_DIR="/var/lib/postgresql/12/main"

# Edit postgresql.conf to change listen address to '*':
sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" "$PG_CONF"

# Append to pg_hba.conf to add password auth:
echo "host    all             all             all                     md5" >> "$PG_HBA"

# Explicitly set default client_encoding
echo "client_encoding = utf8" >> "$PG_CONF"

# Restart so that all new config is loaded:
service postgresql restart

cat << EOF | su - postgres -c psql
-- Create the database user:
CREATE USER $APP_DB_USER WITH PASSWORD '$APP_DB_PASS';
-- Create the database:
CREATE DATABASE $APP_DB_NAME WITH OWNER=$APP_DB_USER
                                  LC_COLLATE='en_US.utf8'
                                  LC_CTYPE='en_US.utf8'
                                  ENCODING='UTF8'
                                  TEMPLATE=template0;
EOF


echo "Successfully created PostgreSQL dev virtual machine."
