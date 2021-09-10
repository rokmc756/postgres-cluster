#!/bin/bash

for i in `echo 81 82 83`
do
    ssh root@192.168.0.$i "su - postgres -c '/usr/pgsql-9.4/bin/pg_ctl -D /var/lib/pgsql/9.4-bdr/data $1 &'"
done
