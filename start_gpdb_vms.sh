#!/bin/bash
MDW_HOST="mdw6"
# HOST_LIST="mdw6 smdw6 sdw6-01 sdw6-02 sdw6-03"
# HOST_LIST="mdw4 smdw4 sdw4-01 sdw4-02 sdw4-03"
# HOST_LIST="kafka1 kafka2 kafka3"
# HOST_LIST="mdw6 smdw6 sdw6-01 sdw6-02 sdw6-03"
# HOST_LIST="postgres-haproxy postgres-ha01 postgres-ha02 postgres-ha03 kafka1 kafka2 kafka3"
# HOST_LIST="mdw6 smdw6 sdw6-01 sdw6-02 sdw6-03"
HOST_LIST="postgres-haproxy postgres-ha01 postgres-ha02 postgres-ha03"
for i in `echo $HOST_LIST`
do
   ssh root@192.168.0.1 virsh start $i
done

sleep 30

# ssh gpadmin@$MDW_HOST "source /usr/local/greenplum-db/greenplum_path.sh && gpstart -a"
