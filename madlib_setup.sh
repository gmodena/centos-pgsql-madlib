#!/bin/bash
export HOST=127.0.0.1:5432
export DATABASE=maddb
export USER=madlib
export DBMS=postgres
export PGPASSWORD=password

su --login postgres --command "/usr/pgsql-9.2/bin/postgres -D /var/lib/pgsql/9.2/data -p 5432" &
# ugly busy wait
sleep 10
ps aux 

su --login - postgres --command "PGPASSWORD=${PGPASSWORD} /usr/local/madlib/bin/madpack -p $DBMS -c $USER@$HOST/$DATABASE install"

if [ $? -eq 0 ]; then
	su --login - postgres --command "PGPASSWORD=${PGPASSWORD} /usr/local/madlib/bin/madpack -p $DBMS -c $USER@$HOST/$DATABASE install-check"
fi
