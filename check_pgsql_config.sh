#!/bin/bash

for i in `echo 81 82 83`
do
    ssh root@192.168.0.$i "cat /var/lib/pgsql/9.4-bdr/data/postgresql.conf"
    ssh root@192.168.0.$i "cat /var/lib/pgsql/9.4-bdr/data/pg_hba.conf"
done

