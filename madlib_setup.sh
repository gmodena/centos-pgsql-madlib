#!/usr/bin/env bash
source env.sh
HOST=127.0.0.1:5432
DATABASE=maddb
USER=madlib
DBMS=postgres
PGPASSWORD=password

su --login postgres --command "/usr/pgsql-${PG_VERSION}/bin/postgres -D /var/lib/pgsql/${PG_VERSION}/data -p 5432" &
ps aux 

until pg_isready -h localhost -p ${PG_PORT}; do
    sleep 1
done


su --login postgres --command "/usr/pgsql-${PG_VERSION}/bin/psql -c \"CREATE USER madlib with CREATEROLE superuser PASSWORD '${PGPASSWORD}';\""
su --login postgres --command "/usr/pgsql-${PG_VERSION}/bin/psql -c \"CREATE DATABASE ${DATABASE};\""
su --login  postgres --command "/usr/pgsql-${PG_VERSION}/bin/psql -c \"\du;\""

su --login postgres --command "/usr/pgsql-${PG_VERSION}/bin/psql -c \"CREATE EXTENSION plpythonu;\""
# su --login postgres --command "/usr/pgsql-${PG_VERSION}/bin/psql -c \"CREATE EXTENSION madlib\""
su --login postgres --command "PATH=/usr/pgsql-${PG_VERSION}/bin/:${PATH} pgxn load madlib"

PGPASSWORD=${PGPASSWORD} /usr/local/madlib/bin/madpack -p $DBMS -c $USER@$HOST/$DATABASE install

if [ $? -eq 0 ]; then
	PGPASSWORD=${PGPASSWORD} /usr/local/madlib/bin/madpack -p $DBMS -c $USER@$HOST/$DATABASE install-check
fi

