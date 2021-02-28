**usgo.containers.agagd** is a role which deploys the agagd as a docker container.

## Requirements
* usgo.containers
* usgo.containers.nginx

## Images
* [usgo/agagd][1]

[1]: https://hub.docker.com/repository/docker/usgo/agagd

## Default Variables
Variable | Default Value | Notes
---|--- |
usgo_agagd_google_analytics_id | '' | id for google analytics property
usgo_agagd_min_containers | 2 | min number of containers to create
usgo_agagd_last_min_containers | 2 | last min number created in previous run
usgo_container_agagd_version | 'latest' |
usgo_container_agagd_container_name | 'agagd' |
usgo_container_agagd_virtual_host | '' | i.e., agagd.usgo.org
usgo_container_agagd_letsencrypt_host | '' | i.e., agagd.usgo.org
usgo_container_agagd_virtual_port | '3031' |
usgo_container_agagd_db_host | '' |
usgo_container_agagd_db_port | '' |
usgo_container_agagd_db_name | '' |
usgo_container_agagd_db_user | '' |
usgo_container_agagd_db_password | '' |
usgo_container_agagd_secret_key | '' |
