#!/usr/bin/env bash
source env.sh

su --login - postgres --command "/usr/pgsql-${PG_VERSION}/bin/postgres -D /var/lib/pgsql/${PG_VERSION}/data -p ${PG_PORT}"

