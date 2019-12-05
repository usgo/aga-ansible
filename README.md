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
with a `[hostname].extra.conf.j2` that has the same hostname which was defined in group_vars.

[1]: roles/web/templates/vhost.conf.j2
[2]: roles/web/templates/vhost_ssl.conf.j2

The production roles will differ slightly because of the necessary configurations
associated with certbot and lets encrypt that enable HTTPs on our servers.

## Requirements
* python 3
* ansible
* ssh public key in the `~/.ssh/authorized_keys`

## Adding a vhost
1) Create a folder for the inventory group within group_vars
2) Add a vars.yaml to the inventory group folder within group_vars with:something like:

```
---
vhost:
  - hostname: test.example.com
    serveradmin: webmaster@test.example.com
    documentroot: /var/www/test.example.com
  - hostname: example.com
    serveradmin: webmaster@example.com
    documentroot: /var/www/example.com
```

3) Create a extra file for the vhost for each hostname

```
Define example_com_root {{ item.documentroot }}

LogLevel info ssl:warn

ErrorLog ${APACHE_LOG_DIR}/{{ item.hostname }}-error.log
CustomLog ${APACHE_LOG_DIR}/{{ item.hostname }}-access.log combined

<Directory ${example_com_root}>
      Options +FollowSymLinks -Indexes -MultiViews
      AllowOverride all
      Require all granted
</Directory>
```

4) (Optional) Pass in Extra Params to the Vhost

```
vhost:
  - hostname: test.example.com
    serveradmin: webmaster@test.example.com
    documentroot: /var/www/test.example.com
    extra_params: |
          RewriteCond %{SERVER_NAME} =test.example.com
          RewriteRule ^ https://%{SERVER_NAME}%{REQUEST_URI} [END,NE,R=permanent]
``` 

## Basic Usage
* `shell> ansible-playbook -u [username] -K -i [inventory] [playbook.yml]`

## Ansible Vault Usage
* `shell> ansible-playbook --ask-vault-pass -u [username] -K -i [inventory] [playbook.yaml]`
