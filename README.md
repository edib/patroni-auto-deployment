# Postgresql HA Tool: Patroni Auto Deployment in Ansible
This aoutomatic deployment script is for https://github.com/zalando/patroni.
* Following tools are used
    - Vagrant and virtualbox environment
    - Ubuntu 18.04 Bionic Bionic Beaver
    - Ansible 2.7.8


* For testing purposes I use 3 vagrant vms on virtualbox. Default vagrant config is used.
* Make 3 copies of vagrant folder and change the ips and hostnames accordingly. ie.

```
host11 10.0.0.11
host12 10.0.0.12
host13 10.0.0.13
```
* Redundant etcd cluster members are on the same patroni/postgres instances.
* Following ansible command aoutomaticly install all necessary services into vagrant vms and one master and two replica postgres services are up and running and ready to use.

```
ansible-playbook patroni.yml
```
* For now, confd setup on another machine is done [manually](confd).
