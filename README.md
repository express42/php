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

* php::default - Installs and configures default php-fpm instance

# LWRP

This cookbook provides resource `php_pool`.

Examples
========
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
  php_var 'register_globals' => true,
          'short_open_tag' => true,
          'display_errors' => false,
          'max_execution_time' => '600',
          'error_reporting' => 'E_ALL &amp; ~E_DEPRECATED',
          'date.timezone' => 'UTC',
          'error_log' => '/var/log/zabbix-php-error.log',
          'memory_limit' => '128M',
          'post_max_size' => '32M',
          'max_input_time' => '300'
  action :add
end
```


# Usage

You must include `recipe[php::default]` to you `run_list` or via `include_recipe`.


# License and Maintainer

Maintainer:: LLC Express 42 (<cookbooks@express42.com>)

License:: MIT
