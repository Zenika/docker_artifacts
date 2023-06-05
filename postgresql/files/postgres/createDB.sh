#!/bin/bash

# Start PGSQL in order to get the client to work
/usr/bin/pg_ctl start -D /var/lib/postgresql/data

psql -c "CREATE ROLE ___USERNAME___ WITH LOGIN SUPERUSER PASSWORD '___PASSWORD___';"

# Stop the DB server. We're done
/usr/bin/pg_ctl stop -D /var/lib/postgresql/data
