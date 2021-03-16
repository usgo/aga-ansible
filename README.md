## Short Description
Ansible configuration for the usgo web infrastructure. 

## What makes this work?
The configuration here uses a series of roles which then are placed in various playbooks.
Naming conventions are fairly straight forward i.e., `inventory_name_[description].yaml`.
In the case of `test_playbook.yaml` there is one imported playbook that uses two roles,
web and mysql. These roles basically create a base apache web server and a mysql database
that match production. 

Apache Virtual Hosts have two main templates: [vhost.conf.j2][1] and [vhost_ssl.conf.j2][2] which
provide a base for our vhost configuration. Host specific configurations for the web role are provided
with a `[servername].extra.conf.j2` that has the same hostname which was defined in group_vars.

[1]: roles/web/templates/vhost.conf.j2
[2]: roles/web/templates/vhost_ssl.conf.j2

The production roles will differ slightly because of the necessary configurations
associated with certbot and lets encrypt that enable HTTPs on our servers.

## Requirements
* python 3
* ansible
* ssh public key in the `~/.ssh/authorized_keys`
* `~/.ansible.cfg` configured to allow the local ssh agent to be forwarded i.e.,
* `roles/requirements.txt` installed
  * `ansible-galaxy install -r roles/requirements.txt`

```
[ssh_connection]
ssh_args = -o ForwardAgent=yes -C -o ControlMaster=auto -o ControlPersist=60s
```

**Note: Host key checking can be disabled as well; however, consider the implications before doing so.
For more details see: [Connection Methods - Managing Host Key Checking][3]**

[3]: https://docs.ansible.com/ansible/latest/user_guide/connection_details.html#managing-host-key-checking

* `~/.ansible.cfg` also requires that python3 be enabled:

```
[defaults]
interpreter_python=python3
```

* `~/.ansible.cfg`

```
[defaults]
interpreter_python=python3

[ssh_connection]
ssh_args = -o ForwardAgent=yes -C -o ControlMaster=auto -o ControlPersist=60s
```

## Adding a vhost
1) Create a folder for the inventory group within group_vars
2) Add a vars.yaml to the inventory group folder within group_vars with:something like:

```
---
vhost:
  - servername: test.example.com
    serveradmin: webmaster@test.example.com
    documentroot: /var/www/test.example.com
  - servername: example.com
    serveradmin: webmaster@example.com
    documentroot: /var/www/example.com
```

3) Create a extra file for the vhost for each hostname

```
Define example_com_root {{ item.documentroot }}

LogLevel info ssl:warn

ErrorLog ${APACHE_LOG_DIR}/{{ item.servername }}-error.log
CustomLog ${APACHE_LOG_DIR}/{{ item.servername }}-access.log combined

<Directory ${example_com_root}>
      Options +FollowSymLinks -Indexes -MultiViews
      AllowOverride all
      Require all granted
</Directory>
```

4) (Optional) Pass in Extra Params to the Vhost

```
vhost:
  - servername: test.example.com
    serveradmin: webmaster@test.example.com
    documentroot: /var/www/test.example.com
    extra_params: |
          RewriteCond %{SERVER_NAME} =test.example.com
          RewriteRule ^ https://%{SERVER_NAME}%{REQUEST_URI} [END,NE,R=permanent]
``` 

## Available Tags for Roles

| Role | Tag(s) |
| ---- | ------- |
| usgo.agagd | usgo.agagd |

## Basic Usage
* `shell> ansible-playbook -u [username] -K -i [inventory] [playbook.yml]`

## Ansible Usage with Limits
* `shell> ansible-playbook -u [username] -K -i [inventory] [playbook.yaml] --limit='[host1,host2]'`

## Ansible Usage Add Devops User to New Server
* `shell> ansible [hosts_group] -i 'inventories/production' --vault-password-file=.prod_vault_pass -u [username] -K -b -m include_role -a name=usgo.devops_user`

## Ansible Vault Usage
* `shell> ansible-playbook --ask-vault-pass -u [username] -K -i [inventory] [playbook.yaml]`
* `shell> ansible-playbook --vault-password-file=[vault_password_file] -K -i [inventory] [playbook.yaml]`
