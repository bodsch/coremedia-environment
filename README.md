# Infrastructure for an CoreMedia Setup

**The repository is not offered by [CoreMedia](https://www.coremedia.com/de/) or my employer ([Tallence AG](https://www.tallence.com))!**

**The information or code found here is created by me in my spare time!**

---

This repository is intended to serve as a demonstrator for the automated provision of a CoreMedia system.

Starting with the development of the infrastructure via Terraform, to the roll-out of the CoreMedia software via Ansible and the implementation of a monitoring system.

The demonstrator and the infrastructure used here is based on my past experience with CoreMedia systems (among others for stern.de) and my personal recommendation.

It will therefore differ from development systems and possibly also from an already existing infrastructure.

If you have any questions, please do not hesitate to contact me if you have a suitable timeframe.

For further information or problem analyses, both CoreMedia and my employer - or other specialized companies - are at your disposal.

---

**I reserve the right to block or delete this repository at any time.**

---

My recommendation for a CoreMedia setup is as follows

| Virtual Machine         | Services |
| :------                 | :---------- |
| **database backend**    | mysql, mongodb, solr |
| **database frontend**   | mysql |
| **backend**      | content-management-server, content-feeder, user-changes, elastic-worker, cae-preview,<br> studio, caefeeder-preview, workflow-server |
| **frontend**     | master-live-server, caefeeder-live, solr-master |
| **delivery**     | replication-live-server, cae-live-1, cae-live-2, cae-live-3, solr-slave |

![setup](setup.png)


## repositories

I separated the repositories a bit and put them together in a GitLab group.

### infrastructure

https://gitlab.com/coremedia-as-code/infrastructure

### Ansible Deployment

https://gitlab.com/coremedia-as-code/ansible-coremedia

### Monitoring

https://gitlab.com/coremedia-as-code/monitoring



Take a look into `terraform`

# deploy the CoreMedia stack

Take a look into `ansible`

# take a look in the monitoring

Take a look into `monitoring`


## vault support

```
openssl rand -base64 2048 > ansible-vault.pass

ansible-vault edit   host_vars/monitoring.cm.local/vault --vault-password-file=ansible-vault.pass
ansible-vault create host_vars/monitoring.cm.local/vault --vault-password-file=ansible-vault.pass

ansible -i hosts -m debug -a 'var=hostvars[inventory_hostname]' monitoring --vault-password-file=ansible-vault.pass

time ansible-playbook  --inventory=hosts monitoring.yml --vault-password-file=ansible-vault.pass

```

