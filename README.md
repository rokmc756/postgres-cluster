# What is PostgreSQL Cluster
postgres-cluster provide ansible playbook to deploy three kind of cluster such as gpfailover, patroni, mutlti master ( bdr ) with haproxy and etcd.


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
