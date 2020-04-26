## Overview
Role which provides configuration and deployment of customized usgo's
Wordpress for the [usgo.org/news](EJournal - News). Existing [usgo.org/news](EJournal - News)
Wordpress is removed with usgo.wordpress role and latest Wordpress version with customized plugins
is added.

## Variables
### Wordpress Database

| Name | Defaults |
| ---- | -------- |
| wordpress_database_host | localhost |
| wordpress_database_name |  '' |
| wordpress_database_user |  '' |
| wordpress_database_pass |  '' |
| wordpress_table_prefix |  'wp_' |

### Wordpress General
| wordpress_charset |  'utf8' |

### External Directories
| usgos_www_root |  '/var/www/usgo.org' |
| usgos_org_www_archives_dir |  "{{ usgos_www_root }}/usgo_org_past_releases" |

### EJournal Website Archive Filename
| ejournal_website_archive_filename |  "ejournal_website_{{ '%Y%m%d' | strftime(ansible_date_time.epoch) }}.bac.tar.gz" |

### USGO's Kabocha theme directory
| wordpress_kabocha_theme_dir |  "{{ usgos_www_root }}/theme/wordpress" |

### Wordpress Directories
| wordpress_root |  "{{ usgos_www_root }}/news" |
| wordpress_plugins_dir |  "{{ wordpress_root }}/wp-content/plugins" |
| wordpress_themes_dir |  "{{ wordpress_root }}/wp-content/themes" |
| wordpress_uploads_dir |  '/var/www/usgo-news-uploads' |

### Wordpress Plugins and Themes
| wordpress_plugins |
add-to-any
advanced-excerpt
akismet
amazon-polly
broken-link-checker
gallery-plugin
glift-go-game
maintenance-mode
photo-gallery
social-networks-auto-poster-facebook-twitter-g |

| wordpress_theme_name |  'kabocha' |

| wordpress_debug_mode |  False |

## Playbook USAGE
```
---
- hosts: test_lamp_servers
  become: yes 
  tasks:
    - include_role:
        name: usgo.wordpress
```
