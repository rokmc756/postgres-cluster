## What is pgBackrest?
pgBackRest aims to be a reliable, easy-to-use backup and restore solution that can seamlessly scale up to the largest databases and workloads by utilizing algorithms that are optimized for database-specific requirements.

## The architecture of pgBackrest
![alt text](https://github.com/rokmc756/postgres-cluster/blob/main/roles/pgbackrest/images/pgBackRest.png)
<img src="https://github.com/rokmc756/postgres-cluster/blob/main/roles/pgbackrest/images/pgBackRest.png" width="50%" height="50%">

## Advantages of using pgBackRest
For users who are new to PostgreSQL and thinking of migrating to Postgres, we would like to talk about some of the advantages in using pgBackRest as a preferred backup tool for postgres. These advantages should prove the reason why pgBackRest is the next generation backup tool that is totally unique from a several list of backup tools of different databases in the world today.
- pgBackRest is the most advanced Open Source backup tool that is also available in the PGDG (PostgreSQL Global Development Group) repository for downloads. No licensing or extra costs involved in using this tool.
- Supports Parallel backup that could stream compressed files to a local or a remote repository or to Cloud.
- Supports Incremental and Differential backups.
- Stream backups to Cloud - Supports AWS, Azure and GCS compatible object store.
- Supports encryption. The repository can be encrypted by pgBackRest to secure the backups.
- Does not need a local staging area to stream backups to a remote storage or cloud. Can directly stream backup to cloud or a remote repository without writing any files locally.
- Supports Millions or Billions of Objects in PostgreSQL. See this patch for more details.
- Highly preferred backup tool for postgres databases of Terrabytes in size.
- Simple commands for restore and recovery including point in time recovery. No manual intervention needed in pulling a certain WAL segemnts manually for a PITR.
- Serves the purpose of an Enterprise backup tool that can act as a Unified solution for maintaining backups of all the PostgreSQL databases across the Infrastructure from a single Backup server.
- Support backups from a Standby server (or read replica) that has been configured using Streaming Replication. See this article on how we can setup Streaming Replication in PostgreSQL.
- Ability to utilize the computing power of multiple standby servers in performing backups.
- Supports automatic retention of backups and archives based on the configuration.
- Supports Parallel asynchronous Archiving to improve the archiving speed.
- Supports backup of Postgres databases with thousands of tablespaces.

### Supported Operrating Systems confirmed by Jack Moon so far.
- CentOS 7

## Prerequistes of deploying pgbackrest by ansible playbook
- Patroni cluster should be deployed with non synchronous mode.
- vmware-postgres-13.x version are only supporetd so far.

## How to install pgbackrest for patroni cluster
#### Clone pgbackrest ansible playbook from github
~~~
$ git clone https://github.com/rokmc756/postgres-cluster/roles/pgbackrest
~~~

#### Modify your hostnames and ip addresses in ansible-hosts file.
~~~
$ vi ansible-hosts
[all:vars]
ssh_key_filename="id_rsa"
remote_machine_username="jomoon"
remote_machine_password="changeme"
# ansible_python_interpreter="/usr/bin/python3"

# pgBackrest
[postgres-ha]
co7-node01 ansible_ssh_host=192.168.0.83
co7-node02 ansible_ssh_host=192.168.0.84
co7-node03 ansible_ssh_host=192.168.0.85

[repository]
co7-master ansible_ssh_host=192.168.0.81
~~~

## Modfiy variables of pgbackrest
~~~
$ vi  pgbackrest/vars/main.yml

# pgbackrest_path: "/opt/vmware/postgres/14/bin/pgbackrest"
pgbackrest_path: "/usr/bin/pgbackrest"
package_name: vmware-postgres
major_version: 13
minor_version: 3
patch_version: 0
rhel_version: el7
database_name: vmware_postgres_testdb
username: postgres
patroni_path: "/usr/local/bin/patroni"
patronictl_path: "/usr/local/bin/patronictl"
~~~

## Define ansible role of pgbackrest
~~~
$ vi setup-hosts.yml
---
- hosts: all
  roles:
    - pgbackrest
~~~

## How to install pgbackrest for patroni cluster
~~~
$ make install
~~~

## How to uninstall pgbackrest for patroni cluster
~~~
$ make uninstall
~~~
