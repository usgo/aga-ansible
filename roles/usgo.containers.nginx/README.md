**usgo.containers.nginx** is a role which deploys two containers for easy container application deployment behind a proxy and automatic renewal of our SSL certificates.

### Variables

Variable | Default Value
---|---
usgo_container_agagd_version | 'latest'
usgo_container_agagd_container_name | 'agagd'
usgo_container_agagd_virtual_host | ''
usgo_container_agagd_letsencrypt_host | ''
usgo_container_agagd_virtual_port | '3031'
usgo_container_agagd_db_host | ''
usgo_container_agagd_db_port | ''
usgo_container_agagd_db_name | ''
usgo_container_agagd_db_user | ''
usgo_container_agagd_db_password | ''
usgo_container_agagd_secret_key | ''

### Images

* [jwilder/nginx-proxy][1]
* [jrcs/letsencrypt-nginx-proxy-companion][2]

[1]: https://hub.docker.com/r/jwilder/nginx-proxy
[2]: https://hub.docker.com/r/jrcs/letsencrypt-nginx-proxy-companion
