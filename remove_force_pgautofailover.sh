#!/bin/bash

for i in `echo "80 81 82 83"`
do
    ssh root@192.168.0.$i "systemctl stop patroni; killall etcd; rm -rf /var/lib/pgsql/* ; rm -rf /var/lib/pgsql/.* ; rpm -Uvh /home/jomoon/vmware-postgres-11.12-0.el7.x86_64.rpm --force ; ls -al /var/lib/pgsql"
    # ssh root@192.168.0.$i "systemctl stop pgautofailover; rm -rf /var/lib/pgsql/* ; rm -rf /var/lib/pgsql/.* ; rpm -Uvh /home/jomoon/vmware-postgres-11.12-0.el7.x86_64.rpm --force ; ls -al /var/lib/pgsql"
done
