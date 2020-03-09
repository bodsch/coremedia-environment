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

## setup

My recommendation for a staging CoreMedia setup is as follows


| Virtual Machine         | Resources                    | Services    |
| :------                 | :-----------                 | :---------- |
| **database backend**    | 1 vCPU, 1 GiB RAM, 8 GiB HDD | mysql, mongodb |
| **database frontend**   | 1 vCPU, 2 GiB RAM, 8 GiB HDD | mysql |
| **backend**             | 2 vCPU, 4 GiB RAM, 8 GiB HDD | content-management-server, content-feeder, user-changes, elastic-worker, cae-preview,<br> studio, caefeeder-preview, workflow-server, solr |
| **frontend**            | 2 vCPU, 4 GiB RAM, 8 GiB HDD | master-live-server, caefeeder-live, solr-master |
| **delivery**            | 1 vCPU, 2 GiB RAM, 8 GiB HDD | replication-live-server, cae-live-1, cae-live-2, cae-live-3, solr-slave |

![setup](setup.png)

## security

For security reasons, the connections between the different environments and the VMs have been reduced to a minimum.

In addition, communication between the VMs on the VMs is restricted using iptables.

My recommendation is also to equip all VMs with an additional network card. This should be used for communication between the CoreMedia Services.

## scalability

The only application that can sensibly handle more traffic is an additional CAE.

However, for performance reasons, an RLS can only serve a limited number of CAEs.

In the case of excessive and high-frequency traffic, an additional VM with an RLS and additional CAEs can be included in the setup.

With high-frequency websites, you should consider whether including an external CDN in the architecture could be a worthwhile investment.


## repositories

I separated the repositories a bit and put them together in a GitLab group.

### infrastructure

[build an local infrastructur](https://gitlab.com/coremedia-as-code/infrastructure)

### deployment

[deployment of CoreMedia components](https://gitlab.com/coremedia-as-code/deployment)

### monitoring

[deployment of an Monitoring system](https://gitlab.com/coremedia-as-code/monitoring)


## quick start

**For more detailed information, please read the documentation for the individual subrepositories!**

**It is still assumed that all dependencies are resolved!**

How the dependencies are resolved can be read in the corresponding repositories.

### infrastructure

```
$ mkdir ~/coremedia-automation/{infrastructure,deployment,monitoring}
$ cd ~/coremedia-automation/infrastructure
# git clone https://gitlab.com/coremedia-as-code/infrastructure/terraform.git
# git checkout provider/kvm
# terraform init
# terraform apply

```

### CoreMedia deployment

```
# cd ~/coremedia-automation/deployment
# git clone https://gitlab.com/coremedia-as-code/deployment/ansible-deployment.git
# ansible-galaxy install -r requirements.yml
# ansible-playbook --inventory hosts --extra-vars @coremedia-config.yml --vault-password-file vault/ansible-vault.pass prepare.yml
# ansible-playbook --inventory hosts --extra-vars @coremedia-config.yml --vault-password-file vault/ansible-vault.pass deployment.yml
# ansible-playbook --inventory hosts --extra-vars @coremedia-config.yml --vault-password-file vault/ansible-vault.pass content-import.yml
```

### Monitoring

```
# cd ~/coremedia-automation/monitoring
# git clone https://gitlab.com/coremedia-as-code/monitoring/ansible-deployment.git
# ansible-galaxy install -r requirements.yml
# ansible-playbook --inventory hosts --vault-password-file host_vars/monitoring.cm.local/ansible-vault.pass monitoring.yml
```

After this, we can use the standard CoreMedia [Overview](https://overview.cm.local) with shortlinks.

Or for the Monitoring with [Grafana](https://monitoring.cm.local/grafana/) and [Icinga2](https://monitoring.cm.local/icinga).

