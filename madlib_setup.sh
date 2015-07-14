#!/bin/bash
export HOST=127.0.0.1:5432
export DATABASE=maddb
export USER=madlib
export DBMS=postgres
export PGPASSWORD=password

su --login - postgres --command "/usr/local/madlib/bin/madpack -p $DBMS -c $USER@$HOST/$DATABASE install"

if [ $? -eq 0 ]; then
	su --login - postgres --command "/usr/local/madlib/bin/madpack -p $DBMS -c $USER@$HOST/$DATABASE install-check"
fi
