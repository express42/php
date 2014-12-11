# Description

Installs and configures php-fpm. Provides LWRPs for managing multiple instances.

# Requirements

## Platform:

* Ubuntu

# Attributes

* `node['php']['fpm']['pools_dir']` -  Defaults to `"/etc/php5/fpm/pool.d"`.
* `node['php']['fpm']['main_conf']` -  Defaults to `"/etc/php5/fpm/php-fpm.conf"`.
* `node['php']['fpm']['create_default_pool']` -  Defaults to `"true"`.

# Recipes

* php::default - Installs and configures default php-fpm instance.

# LWRP

This cookbook provides resource `php_pool`.

## Actions

- add:  Default action.

## Attribute Parameters

- name:  Name of the pool.
- user:  Defaults to <code>"www-data"</code>.
- group:  Defaults to <code>"www-data"</code>.
- allow:  Defaults to <code>"127.0.0.1"</code>.
- address:  Defaults to <code>"127.0.0.1"</code>.
- port:  Port to bind.
- backlog:  Defaults to <code>-1</code>.
- request_terminate_timeout:  Defaults to <code>"60s"</code>.
- limits:  Defaults to <code>{:core=>0, :files=>1024, :requests=>500, :children=>5, :spare_children=>{:min=>1, :max=>3}}</code>.
- php_var:  Defaults to <code>{}</code>.
- php_user_var:  Defaults to <code>{}</code>.


# Usage

You must include `recipe[php::default]` to you `run_list` or via `include_recipe`.

```
php_pool 'www' do
  port '9000'
  action :add
end
```

```
php_pool 'zabbix-runtime' do
  address '127.0.0.1'
  port '9200'
  allow '127.0.0.1'
  backlog { -1 }
  limits core: 0, files: 1024, requests: 500, children: 5, spare_children: { min: 1, max: 3 }
  php_var register_globals: true,
          short_open_tag: true,
          display_errors: false,
          max_execution_time: 600,
          error_reporting: 'E_ALL &amp; ~E_DEPRECATED',
          error_log: '/var/log/zabbix-php-error.log',
          memory_limit: '128M',
          post_max_size: '32M',
          max_input_time: '300'
  action :add
end
```

See fixture cookbook in `tests/fixtures/cookbooks`.


# License and Maintainer

Maintainer:: LLC Express 42 (<cookbooks@express42.com>)

License:: MIT
