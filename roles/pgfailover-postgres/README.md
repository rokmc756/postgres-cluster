## The architecture of pg_auto_failover cluster
![alt text](https://github.com/rokmc756/postgres-cluster/blob/main/roles/pgfailover-postgres/images/arch-single-standby.svg)

![alt text](https://github.com/rokmc756/postgres-cluster/blob/main/roles/pgfailover-postgres/images/arch-multi-standby.svg)

![alt text](https://github.com/rokmc756/postgres-cluster/blob/main/roles/pgfailover-postgres/images/arch-three-standby-one-async.svg)

## Main Components of pg_auto_failover cluster for VMware Postgres
- Patroni provides a template for creating, managing, maintaining and monitoring highly available clusters using Postgres streaming replication. Patroni handles the Postgres database initialization as well as planned switchovers or unplanned failovers.
- ETCD stores the state of the PostgreSQL cluster.  When any changes in the state of any PostgreSQL node are found, Patroni updates the state change in the ETCD key-value store. ETCD uses this information to elects the master node and keeps the cluster UP and running.
- HAProxy keeps track of changes in the Master/Slave nodes and connects to the appropriate master node when the clients request a connection.

It guides you how to set up a threer-node cluster with pg_auto_failover on CentOS 7.

## Supported Operrating Systems confirmed by Jack Moon so far.
- CentOS 7

## Download ansible-playbook for postgres-cluster
$ git clone https://github.com/rokmc756/postgres-cluster

## Go to the postgres-cluster directory
$ cd postgres-cluster

## Copy vmware-postgres rpm package into roles/pgfailover-postgres/files directory.
$ cp vmware-postgres-13.3-0.el7.x86_64.rpm roles/pgfailover-postgres/files/

# Modify your hostnames and ip addresses in ansible-hosts file.
~~~
$ vi ansible-hosts
[all:vars]
ssh_key_filename="id_rsa"
remote_machine_username="jomoon"         # sudo user in each nodes
remote_machine_password="changeme"       # sudo user's password in each nodes

# For pgautofailover
[monitor]
co7-master ansible_ssh_host=192.168.0.81

[primary]
co7-node01 ansible_ssh_host=192.168.0.83

[secondary]
co7-node02 ansible_ssh_host=192.168.0.84
co7-node03 ansible_ssh_host=192.168.0.85
~~~

## Configures variables of vmware-postgres packages and user / databases
~~~
$ vi  roles/pgfailover-postgres/vars/main.yml
package_name: vmware-postgres
major_version: 13
minor_version: 3
patch_version: 0
rhel_version: el7
database_name: vmware_postgres_testdb
username: postgres
# Application database name for replication
app_database: appdb
# Database names
monitor_database: monitor
primary_database: ha
secondary_database: ha
~~~

## Download and locate vmware-postgres rpm package you want to install
$ mv  vmware-postgres-13.3-0.el7.x86_64.rpm roles/pgfailover-postgres/files/

## Configure role of pg_auto_failover in postgres-cluster ansible-playbook
$ vi setup-host.yml
---
- hosts: all
  roles:
    - pgfailover-postgres

## Install or uninstall pg_auto_failover
$ make install
$ make uninstall

