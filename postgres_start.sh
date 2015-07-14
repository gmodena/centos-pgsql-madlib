#!/bin/bash

su --login - postgres --command "/usr/pgsql-9.2/bin/postgres -D /var/lib/pgsql/9.2/data -p 5432"

