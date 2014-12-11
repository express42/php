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
