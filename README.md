# Infrastructure for an CoreMedia Setup

This is an Multi-Nodes Deployment.

The infrastructure is provided by Terraform.

The required software is rolled out via ansible.

This split the CoreMedia *Standard* (OneNode4All) deployment into a real production Multi-Nodes setup.

The services are rolled out to various virtual servers:

| Node         | Services |
| :------      | :---------- |
| **database** | mysql, mongodb |
| **backend**  | content-management-server, content-feeder, user-changes, elastic-worker, cae-preview,<br> studio, caefeeder-preview, workflow-server, solr |
| **frontend** | master-live-server, caefeeder-live, solr |
| **delivery** | replication-live-server, cae-live-1, cae-live-2, cae-live-3 |

![setup](setup.png)

# prepare your system **before** you start

add some `hosts` entries for DNS resolutions

```
192.168.124.10          database.cm.local
192.168.124.20          backend.cm.local
192.168.124.30          frontend.cm.local
192.168.124.35          delivery.cm.local
192.168.124.50          monitoring.cm.local
```


# create the infrastructure

Take a look into `terraform`

# deploy the CoreMedia stack

Take a look into `ansible`

# take a look in the monitoring

Take a look into `monitoring`


