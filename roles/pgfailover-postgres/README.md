# What is pg_auto_failover?
## Facilitates the creation of a High Availability (HA) configuration
## Monitors replication between Postgres instances
## Manages automatic failover for a group of Postgres nodes.
## Optimizes for simplicity and correctness.
## Guarantees availability for business continuity of the Postgres service to users and applications with asynchronous replication in the event of a standby node failure while automating maintenance operations as a trade-off involved.
## Configuration changes in a live system without downtime.


## Main Components of pg_auto_failover cluster for VMware Postgres
# Requires three key components as a minimum:
a pg_auto_failover monitor node as a witness and an orchestrator.
a Postgres primary node.
a Postgres secondary node, using by default a synchronous hot standby setup.
# Consists of the following parts:
a PostgreSQL extension named pgautofailover
a PostgreSQL service to operate the pg_auto_failover monitor
a pg_auto_failover keeper to operate your PostgreSQL instances



## The architecture of pg_auto_failover cluster
# Single Standby node
![alt text](https://github.com/rokmc756/postgres-cluster/blob/main/roles/pgfailover-postgres/images/arch-single-standby.svg)
Monitor node implements a state machine and relies on in-core PostgreSQL facilities to deliver HA.
For example. when the secondary node is detected to be unavailable or when its lag is too much, then the Monitor removes it from the synchronous_standby_names setting on the primary node.
Until the secondary is back to being monitored healthy, failover and switchover operations are not allowed, preventing data loss.

# Multi Standby nodes
![alt text](https://github.com/rokmc756/postgres-cluster/blob/main/roles/pgfailover-postgres/images/arch-multi-standby.svg)
Even after losing any Postgres node, this architecture maintains two copies of the data on two different nodes.
When using more than one standby, different architectures can be achieved with pg_auto_failover, depending on the objectives and trade-offs needed for your setup.

# Three Standby nodes
![alt text](https://github.com/rokmc756/postgres-cluster/blob/main/roles/pgfailover-postgres/images/arch-three-standby-one-async.svg)
## Two standby nodes participating in the replication quorum, allowing for number_sync_standbys = 1.
## A minimum of two copies of the data set: one on the primary, another one on one on either node B or node D.
## Guarantee two copies of the data set whenever losing one of those nodes.
## Standby server C will not participate in the replication quorum.
## Node C will not be found in the synchronous_standby_names list of nodes.
## Node C will never be a candidate for failover, with candidate-priority = 0.
## Fit a situation where nodes A, B, and D are deployed in the same data center or availability zone, and node C in another.
## Support the main production traffic and implement high availability of both the Postgres service and the data set.
## Node C might be set up for Business Continuity in case the first data center is lost, or maybe for reporting the need for deployment on another application domain.


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

