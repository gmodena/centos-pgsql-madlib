#!/bin/bash


su --login postgres --command "/usr/pgsql-9.2/bin/postgres -D /var/lib/pgsql/9.2/data -p 5432" &
# ugly busy wait
sleep 10
ps aux 

su --login - postgres --command "/usr/pgsql-9.2/bin/psql -c \"CREATE USER madlib with CREATEROLE superuser PASSWORD 'password';\""
su --login - postgres --command "/usr/pgsql-9.2/bin/psql -c \"CREATE DATABASE maddb;\""
su --login - postgres --command "/usr/pgsql-9.2/bin/psql -c \"\du;\""