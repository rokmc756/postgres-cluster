#!/bin/bash

for i in `echo "79 80 81 82 83"`
do
    #ssh root@192.168.0.$i "systemctl stop patroni"
    #ssh root@192.168.0.$i "killall etcd"
    #ssh root@192.168.0.$i "rm -rf /var/lib/pgsql/*"
    #ssh root@192.168.0.$i "rm -rf /var/lib/pgsql/.*"
    #ssh root@192.168.0.$i "yum remove -y vmware-postgres"
    #ssh root@192.168.0.$i "ls -al /var/lib/pgsql"
    ssh root@192.168.0.$i "systemctl stop pgautofailover; killall postgres; yum remove -y vmware-postgres ; rm -rf /var/lib/pgsql/* ; rm -rf /var/lib/pgsql/.* ; ls -al /var/lib/pgsql"
    # ssh root@192.168.0.$i "systemctl stop pgautofailover; killall etcd; killall postgres; yum remove -y vmware-postgres ; rm -rf /var/lib/pgsql/* ; rm -rf /var/lib/pgsql/.* ; ls -al /var/lib/pgsql"
done
