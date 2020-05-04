## Overview
Role which deploys and configures AGAGD.

## Local Configuration Requirements
* ssh forwarding must be enabled in the `.ansible.cfg`
* vault password file `.prod_app_vault_pass` must be supplied with the correct 
  prod app vault password if deploying to production

## Example `~/.ansible.cfg`
```
[defaults]
host_key_checking = False

[ssh_connection]
ssh_args = -o ForwardAgent=yes
```

## Playbook USAGE
```
---
- hosts: prod_app_servers
  become: yes
  tasks:
    - include_role:
        name: usgo.agagd
```

## Notes
* The AGAGD is only configured for usgo's test.agagd.usgo.org.
