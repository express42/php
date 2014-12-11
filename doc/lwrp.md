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
