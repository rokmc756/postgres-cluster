#!/bin/bash
MDW_HOST="mdw$1"
# HOST_LIST="mdw$1 smdw$1 sdw$1-01 sdw$1-02 sdw$1-03 postgres-haproxy postgres-ha01 postgres-ha02 postgres-ha03 kafka1 kafka2 kafka3"
# HOST_LIST="mdw$1 smdw$1 sdw$1-01 sdw$1-02 sdw$1-03"
# HOST_LIST="postgres-haproxy postgres-ha01 postgres-ha02 postgres-ha03"
# HOST_LIST="kafka1 kafka2 kafka3"
# HOST_LIST="mdw$1 smdw$1 sdw$1-01 sdw$1-02 sdw$1-03"
# HOST_LIST="postgres-haproxy postgres-ha01 postgres-ha02 postgres-ha03"
HOST_LIST="mdw$1 smdw$1 sdw$1-01 sdw$1-02 sdw$1-03 postgres-haproxy01 postgres-haproxy02 postgres-ha01 postgres-ha02 postgres-ha03"
for i in `echo $HOST_LIST`
do
   ssh root@192.168.0.1 virsh shutdown $i
done

sleep 20

ssh root@192.168.0.1 "shutdown -h now"

# ssh gpadmin@$MDW_HOST "source /usr/local/greenplum-db/greenplum_path.sh && gpstart -a"
