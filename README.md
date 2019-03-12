# gamegos-supervisor

[![Build Status](https://travis-ci.org/gamegos/supervisor-cookbook.svg?branch=master)](https://travis-ci.org/gamegos/supervisor-cookbook) [![Cookbook Version](https://img.shields.io/cookbook/v/gamegos-supervisor.svg)](https://supermarket.chef.io/cookbooks/gamegos-supervisor)

This cookbook installs and configures [Supervisor](https://github.com/Supervisor/supervisor).

# Requirements

## Platforms

- Ubuntu 12.04+
- Centos 7+
- Debian 7+

## Chef

- Chef 12+

## Cookbooks

- poise-python
- poise-service

# Usage

Here's a quick example of installing the supervisord and adding some programs.

```ruby
supervisor_install '3.3'

supervisor_config 'supervisor'

supervisor_process 'cat' do
  type 'program'
  command '/bin/cat'
end

supervisor_process 'vi' do
  type 'program'
  command '/usr/bin/vi'
end

supervisor_group 'cat' do
  programs ['cat']
end

supervisor_service 'supervisor'
```

# Recipes

- **default** - installs the supervisord.

# Resources

### supervisor_install

Install Supervisor with pip.

#### Actions

- `:create`

#### Examples

```ruby
supervisor_install '3.3'
```

### supervisor_config

Define configurations of supervisord.

#### Actions

- `:create`

#### Properties

| Property                       |       Type        |                  Default Value                   |
| ------------------------------ | :---------------: | :----------------------------------------------: |
| `socket_file`                  |     `String`      |           `'/var/run/supervisor.sock'`           |
| `unix_http_server_chmod`       |     `String`      |                     `'700'`                      |
| `unix_http_server_chown`       |     `Integer`     |                  `'root:root'`                   |
| `unix_http_server_username`    |  `[String, Nil]`  |                      `nil`                       |
| `unix_http_server_password`    |  `[String, Nil]`  |                      `nil`                       |
| `supervisord_config_directory` |     `String`      |               `'/etc/supervisor'`                |
| `supervisord_log_directory`    |     `String`      |             `'/etc/log/supervisor'`              |
| `supervisord_logfile`          |     `String`      | `"#{supervisord_log_directory}/supervisord.log"` |
| `supervisord_logfile_maxbytes` |     `String`      |                     `'50mb'`                     |
| `supervisord_logfile_backups`  |     `Integer`     |                       `10`                       |
| `supervisord_loglevel`         |     `String`      |                     `'info'`                     |
| `supervisord_pidfile`          |     `String`      |           `'/var/run/supervisord.pid'`           |
| `supervisord_nodaemon`         |     `Boolean`     |                     `false`                      |
| `supervisord_minfds`           |     `Integer`     |                      `1024`                      |
| `supervisord_minprocs`         |     `Integer`     |                      `200`                       |
| `supervisord_nocleanup`        |     `Boolean`     |                     `false`                      |
| `supervisord_user`             |  `[String, Nil]`  |                      `nil`                       |
| `supervisord_umask`            |  `[String, Nil]`  |                      `nil`                       |
| `supervisord_identifier`       |     `String`      |                  `'supervisor'`                  |
| `supervisord_strip_ansi`       |     `Boolean`     |                     `false`                      |
| `supervisord_environment`      |      `Hash`       |                       `{}`                       |
| `inet_port`                    |     `String`      |                 `'0.0.0.0:9001'`                 |
| `inet_username`                |  `[String, Nil]`  |                      `nil`                       |
| `inet_password`                |  `[String, Nil]`  |                      `nil`                       |
| `include_files`                | `[String, Array]` |    `"#{supervisord_config_directory}/*.conf"`    |
| `action`                       |     `Symbol`      |                    `:create`                     |

#### Examples

```ruby
# Create a custom config
supervisor_config 'supervisor' do
  supervisord_config_directory '/etc/supervisor'
  socket_file '/run/supervisor.sock'
  inet_port '0.0.0.0:9010'
  inet_username 'randy'
  inet_password 'elite'
  supervisord_environment NODE_CONFIG_PORT: '5000', NODE_CONFIG_KEY: '1DFS123SDFK'
  include_files [ '/etc/supervisor/*.conf', '/etc/supervisor/*.ini' ]
  action :create
end
```

```ruby
# Create a default config
supervisor_config 'supervisor'
```

#### Notes

The name property of the resource should always just be `supervisor`.

### supervisor_process

Creates a process for supervisor. The process may be a 'program', 'eventlistener' or 'fcgi-program'.

#### Actions

- `:create`
- `:delete`

#### Properties

| Property                       |        Type        |                    Default Value                     |
| ------------------------------ | :----------------: | :--------------------------------------------------: |
| `type` (@required)             |      `String`      |                          ``                          |
| `command` (@required)          |      `String`      |                          ``                          |
| `process_name`                 |      `String`      |                 `'%(program_name)s'`                 |
| `numprocs`                     |     `Integer`      |                         `1`                          |
| `numprocs_start`               |     `Integer`      |                         `0`                          |
| `priority`                     |     `Integer`      |                        `999`                         |
| `autostart`                    |     `Boolean`      |                       `false`                        |
| `autorestart`                  |     `Boolean`      |                       `false`                        |
| `startsecs`                    |     `Integer`      |                         `1`                          |
| `startretries`                 |     `Integer`      |                         `3`                          |
| `exitcodes`                    |      `Array`       |                       `[0, 2]`                       |
| `stopsignal`                   | `[String, Symbol]` |                       `:TERM`                        |
| `stopwaitsec`                  |     `Integer`      |                         `10`                         |
| `stopasgroup`                  |     `Boolean`      |                        `true`                        |
| `killasgroup`                  |     `Boolean`      |                        `true`                        |
| `user`                         |      `String`      |                        `nil`                         |
| `redirect_stderr`              |     `Boolean`      |                       `false`                        |
| `environment`                  |       `Hash`       |                         `{}`                         |
| `directory`                    |  `[String, Nil]`   |                        `nil`                         |
| `umask`                        |  `[String, Nil]`   |                        `nil`                         |
| `serverurl`                    |      `String`      |                       `'AUTO'`                       |
| `stdout_logfile`               |      `String`      |                       `'AUTO'`                       |
| `stdout_logfile_maxbytes`      |      `String`      |                       `'50mb'`                       |
| `stdout_logfile_backups`       |     `Integer`      |                         `10`                         |
| `stdout_capture_maxbytes`      |      `String`      |                        `'0'`                         |
| `stdout_events_enabled`        |     `Boolean`      |                       `false`                        |
| `stderr_logfile`               |      `String`      |                       `'AUTO'`                       |
| `stderr_logfile_maxbytes`      |      `String`      |                       `'50mb'`                       |
| `stderr_logfile_backups`       |     `Integer`      |                         `10`                         |
| `stderr_capture_maxbytes`      |      `String`      |                        `'0'`                         |
| `stderr_events_enabled`        |     `Boolean`      |                       `false`                        |
| `eventlistener_buffer_size`    |     `Integer`      |                         `10`                         |
| `eventlistener_events`         |      `Array`       |                     `['EVENT']`                      |
| `eventlistener_result_handler` |      `String`      |      `'supervisor.dispatchers:default_handler'`      |
| `fcgi_socket`                  |      `String`      | `'unix:///var/run/supervisor/%(program_name)s.sock'` |
| `fcgi_socket_owner`            |  `[String, Nil]`   |                        `nil`                         |
| `fcgi_socket_mode`             |      `String`      |                        `0700`                        |
| `action`                       |      `Symbol`      |                      `:create`                       |

#### Examples

```ruby
supervisor_process 'my-nginx' do
  type 'program'
  command "/usr/sbin/nginx -g 'daemon off;'"
  numprocs 5
  process_name "%(program_name)s_%(process_num)02d"
  autorestart true
  user 'root'
end
```

```ruby
supervisor_process 'cat' do
  type 'program'
  command '/bin/cat'
end
```

### supervisor_group

Creates a group for supervisor.

#### Actions

- `:create`
- `:delete`

#### Properties

| Property               |   Type    | Default Value |
| ---------------------- | :-------: | :-----------: |
| `programs` (@required) |  `Array`  |      ``       |
| `priority`             | `Integer` |     `999`     |
| `action`               | `Symbol`  |   `:create`   |


#### Examples

```ruby
supervisor_group 'my-web-servers' do
  programs [ 'my-nginx', 'my-apache' ]
  priorty 100
end
```

### supervisor_service

Creates Supervisor service for your systems.

#### Actions

- `:create`
- `:reload`

#### Properties


| Property                      |   Type   |                  Default Value                   |
| ----------------------------- | :------: | :----------------------------------------------: |
| `supervisord_executable_path` | `String` | `node['supervisor']['supervisord_default_path']` |
| `action`                      | `Symbol` |                    `:create`                     |

#### Examples

```ruby
supervisor_service 'supervisor'
```

#### Note

The name property of the resource should always just be `supervisor`.
