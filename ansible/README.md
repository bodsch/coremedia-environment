# ansible deployment

ansible environment to deploy an full coremedia stack

## rules

Local role names must be maintained uniformly.

Word separations should be made by underscore (_) e.g. `jmx_exporter`!

Role configurations can be done in the directories `group_vars` or `host_vars`.

In the configurations, please only define the values that differ from the respective role standards!


## prepare your environment

### download all playbooks from different repositories
```
ansible-galaxy install -r requirements.yml
```


