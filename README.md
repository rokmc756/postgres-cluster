# What is PostgreSQL Cluster
postgres-cluster provide ansible playbook to deploy three kind of cluster such as gpfailover, patroni, mutlti master ( bdr ) with haproxy and etcd.

# Main Components of Patroni cluster for PostgreSQL
- Patroni provides a template for configuring a highly available PostgreSQL cluster.
- ETCD stores the state of the PostgreSQL cluster.  When any changes in the state of any PostgreSQL node are found, Patroni updates the state change in the ETCD key-value store. ETCD uses this information to elects the master node and keeps the cluster UP and running.
- HAProxy keeps track of changes in the Master/Slave nodes and connects to the appropriate master node when the clients request a connection.
- It guides you how to set up a threer-node PostgreSQL cluster with Patroni on CentOS 7.

 

# How to install PostgreSQL BDR in postgres-cluster
~~
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
~~


https://www.techsupportpk.com/2020/02/how-to-create-highly-available-postgresql-cluster-using-patroni-haproxy-centos-rhel-7.html
