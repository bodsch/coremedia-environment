# Infrastructure for an CoreMedia Setup

This is an Multi-Nodes Deployment.

The infrastructure is provided by Terraform.

The required software is rolled out via ansible.

This split the CoreMedia *Standard* (OneNode4All) deployment into a real production Multi-Nodes setup.

The services are rolled out to various virtual servers:

| Node         | Services |
| :------      | :---------- |
| **database** | mysql, mongodb |
| **backend**  | content-management-server, content-feeder, user-changes, elastic-worker, cae-preview,<br> studio, sitemanager, caefeeder-preview, workflow-server, solr |
| **frontend** | master-live-server, replication-live-server, caefeeder-live, solr |
| **delivery** | cae-live-1, cae-live-2, cae-live-3 |

![setup](setup.png)

# infrastructure

Take a look into `terraform`

# ansible

Take a look into `ansible`

# monitoring

Take a look into `monitoring`
