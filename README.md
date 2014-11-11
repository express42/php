Description
============

This cookbook installs and configures PHP-FPM via LWRP.

Requirements
============

Platform
--------

* Ubuntu 12.04/14.04

Attributes
==========

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['php']['fpm']['pools_dir']</tt></td>
    <td>String</td>
    <td>Path to pools directory</td>
    <td><tt>/etc/php5/fpm/pool.d</tt></td>
  </tr>
  <tr>
    <td><tt>['php']['fpm']['main_conf']</tt></td>
    <td>String</td>
    <td>Path to php-fpm.conf</td>
    <td><tt>/etc/php5/fpm/php-fpm.conf</tt></td>
  </tr>
  <tr>
    <td><tt>['php']['fpm']['create_default_pool']</tt></td>
    <td>Boolean</td>
    <td>Create default pool</td>
    <td><tt>true</tt></td>
  </tr>
</table>

Usage
=====

You must include `recipe[php::default]` to you `run_list` or via `include_recipe`.

Resources/Providers
===================

This cookbook provides resourse `php_pool`.

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

License and Authors
===================
Author:: LLC Express 42 (<info@express42.com>)

Copyright (C) 2012-2013 LLC Express 42

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
