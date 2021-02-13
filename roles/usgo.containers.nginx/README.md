**usgo.containers.nginx** is a role which deploys two containers for easy container application deployment behind a proxy and automatic renewal of our SSL certificates.

### Variables

Variable | Default Value
---|---
usgo_nginx_certbot_email | ''
usgo_nginx_frontend_network_name | ''
usgo_nginx_frontend_apps | []
usgo_docker_compose_nginx_directory | '/etc/docker-nginx-proxy'
usgo_docker_compose_apps_directory | '/etc/docker-nginx-apps'

### Images

* [jwilder/nginx-proxy][1]
* [jrcs/letsencrypt-nginx-proxy-companion][2]

[1]: https://hub.docker.com/r/jwilder/nginx-proxy
[2]: https://hub.docker.com/r/jrcs/letsencrypt-nginx-proxy-companion
