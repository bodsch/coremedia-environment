# ansible deployment

ansible environment to deploy an full coremedia stack.

this deployment use only *war* or *zip* artefacts, expectly from the *deployment-archive.zip*.


## rules

Role configurations can be done in the directories `group_vars` or `coremedia-config.yml`.

In the configurations, please only define the values that differ from the respective role standards!


## prepare your environment

Use an Artefact Server to hold all CoreMedia *war* and *zip* Artefakts.

For Example: https://gitlab.com/ansible-coremedia/content-repository





### download all playbooks from different repositories

```
ansible-galaxy install -r requirements.yml [--force]
```

## prepare destination hosts

```
ansible-playbook -i hosts -e @coremedia-config.yml  prepare.yml
```

## deploy CoreMedia services

```
ansible-playbook -i hosts -e @coremedia-config.yml  deployment.yml
```
