## Short Description
Ansible configuration for the usgo web infrastructure. 

## What makes this work?
The configuration here uses a series of roles which then are placed in various playbooks.
Naming conventions are fairly straight forward i.e., `inventory_name_[description].yaml`.
In the case of `test_playbook.yaml` there is one imported playbook that uses two roles,
web and mysql. These roles basically create a base apache web server and a mysql database
that match production.

The production roles will differ slightly because of the necessary configurations
associated with certbot and lets encrypt that enable HTTPs on our servers.

# Requirements
* python 3
* ansible
* ssh public key in the `~/.ssh/authorized_keys`

## Basic Usage
* `shell> ansible-playbook -u [username] -K -i [inventory] [playbook.yml]`
