## What is PostgreSQL Cluster
postgres-cluster provide ansible playbook to deploy three kind of clusters such as gpfailover, patroni cluster, mutlti master replication ( bdr ).

## The architecture of Patroni cluster
![alt text](https://github.com/rokmc756/postgres-cluster/blob/main/roles/patroni-postgres/images/patroni_cluster_architecture.png)


## Main Components of Patroni cluster for VMware Postgres
- Patroni provides a template for creating, managing, maintaining and monitoring highly available clusters using Postgres streaming replication. Patroni handles the Postgres database initialization as well as planned switchovers or unplanned failovers.
- ETCD stores the state of the PostgreSQL cluster.  When any changes in the state of any PostgreSQL node are found, Patroni updates the state change in the ETCD key-value store. ETCD uses this information to elects the master node and keeps the cluster UP and running.
- HAProxy keeps track of changes in the Master/Slave nodes and connects to the appropriate master node when the clients request a connection.

It guides you how to set up a threer-node PostgreSQL cluster with Patroni on CentOS 7.

## How to install Patroni Cluster for VMware Postgres
~~~
# Clone postgres-cluster ansible playbook from github
$ git clone https://github.com/rokmc756/postgres-cluster

# Copy vmware-postgres rpm package into roles/patroni-postgres/files directory.
$ cp vmware-postgres-13.3-0.el7.x86_64.rpm roles/patroni-postgres/files/

# Modify your hostnames and ip addresses in ansible-hosts file.
$ vi ansible-hosts
[all:vars]
ssh_key_filename="id_rsa"
remote_machine_username="jomoon"
remote_machine_password="changeme"

[postgres-ha]
postgres-ha01 ansible_ssh_host=192.168.0.81
postgres-ha02 ansible_ssh_host=192.168.0.82
postgres-ha03 ansible_ssh_host=192.168.0.83

[master]
postgres-ha01 ansible_ssh_host=192.168.0.81

[slave]
postgres-ha02 ansible_ssh_host=192.168.0.82
postgres-ha03 ansible_ssh_host=192.168.0.83

$ vi setup-hosts.yml
---
- hosts: all
  roles:
    - patroni-postgres

$ make install
~~~
## How to uninstall Patroni Cluster for VMware Postgres
~~~
$ make install
~~~
## How to upgrade Patroni Cluster for VMware Postgres
~~~
$ make upgrade
~~~


## How to install PostgreSQL BDR
~~~
- hosts: all
  roles:
    - pgsql94-bdr
    - haproxy

- hosts: postgres-haproxy01
  roles:
     - { role: keepalived, keepalived_shared_ip: "192.168.0.79", keepalived_role: "master" }

- hosts: postgres-haproxy02
  roles:
     - { role: keepalived, keepalived_shared_ip: "192.168.0.80", keepalived_role: "slave" }
~~~



https://www.techsupportpk.com/2020/02/how-to-create-highly-available-postgresql-cluster-using-patroni-haproxy-centos-rhel-7.html
