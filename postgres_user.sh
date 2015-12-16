#!/bin/bash

PGVERSION=9.4

su --login postgres --command "/usr/pgsql-${PGVERSION}/bin/postgres -D /var/lib/pgsql/${PGVERSION}/data -p 5432" &
# ugly busy wait
sleep 10
ps aux 

su --login - postgres --command "/usr/pgsql-${PGVERSION}/bin/psql -c \"CREATE USER madlib with CREATEROLE superuser PASSWORD 'password';\""
su --login - postgres --command "/usr/pgsql-${PGVERSION}/bin/psql -c \"CREATE DATABASE maddb;\""
su --login - postgres --command "/usr/pgsql-${PGVERSION}/bin/psql -c \"\du;\""