#!/bin/bash
HOST=127.0.0.1:5432
DATABASE=maddb
USER=madlib
DBMS=postgres
PGPASSWORD=password

PGVERSION=9.4

su --login postgres --command "/usr/pgsql-${PGVERSION}/bin/postgres -D /var/lib/pgsql/${PGVERSION}/data -p 5432" &
# ugly busy wait
sleep 10
ps aux 

su --login - postgres --command "PGPASSWORD=${PGPASSWORD} /usr/local/madlib/bin/madpack -p $DBMS -c $USER@$HOST/$DATABASE install"

if [ $? -eq 0 ]; then
	su --login - postgres --command "PGPASSWORD=${PGPASSWORD} /usr/local/madlib/bin/madpack -p $DBMS -c $USER@$HOST/$DATABASE install-check"
fi
