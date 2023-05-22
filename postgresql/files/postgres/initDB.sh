#!/bin/bash

if [ ! -d "/run/postgresql" ]; then
    mkdir /run/postgresql
    chown postgres:postgres /run/postgresql
fi

if [ ! -d "/var/lib/postgresql/data" ]; then
    su postgres -c "/usr/bin/initdb -D /var/lib/postgresql/data"
    su postgres -c "/var/lib/postgresql/createDB.sh"
    su postgres -c "rm -f /var/lib/postgresql/createDB.sh"
fi
