# Postgresql HA Tool: Patroni Auto Deployment in Ansible
This aoutomatic deployment script is for https://github.com/zalando/patroni.
* Following tools are used
    - Vagrant and virtualbox environtment
    - Ubuntu 18.04 Bionic Bionic Beaver
    - Ansible 2.7.8


There are 3 vagrant folders and ready to use Vagrant files inside each folder. Start the each vm in related folder. Default vagrant machines configuration is used.
Cluster has 3 nodes. Redundant etcd cluster members are on the same patroni/postgres instances.

```
ansible-playbook patroni.yml
```
