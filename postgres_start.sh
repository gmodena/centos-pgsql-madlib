#!/bin/bash
PGVERSION=9.4

su --login - postgres --command "/usr/pgsql-${PGVERSION}/bin/postgres -D /var/lib/pgsql/${PGVERSION}/data -p 5432"

