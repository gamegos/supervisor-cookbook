# gamegos-supervisor

[![Build Status](https://travis-ci.org/gamegos/supervisor-cookbook.svg?branch=master)](https://travis-ci.org/gamegos/supervisor-cookbook)

This cookbook installs and configures [Supervisor](https://github.com/Supervisor/supervisor).

# Requirements

## Platforms

- Ubuntu 14.04+
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

- `socket_file` - (is: String)
- `unix_http_server_chmod` - (is: String)
- `unix_http_server_chown` - (is: String)
- `unix_http_server_username` - (is: String)
- `unix_http_server_password` - (is: String)
- `supervisord_config_directory` - (is: String)
- `supervisord_log_directory` - (is: String)
- `supervisord_logfile` - (is: String)
- `supervisord_logfile_maxbytes` - (is: String)
- `supervisord_logfile_backups` - (is: Integer)
- `supervisord_loglevel` - (is: String)
- `supervisord_pidfile` - (is: String)
- `supervisord_nodaemon` - (is: Boolean)
- `supervisord_minfds` - (is: Integer)
- `supervisord_minprocs` - (is: Integer)
- `supervisord_nocleanup` - (is: Boolean)
- `supervisord_user` - (is: String)
- `supervisord_umask` - (is: String)
- `supervisord_identifier` - (is: String)
- `supervisord_strip_ansi` - (is: Boolean)
- `supervisord_environment` - (is: Hash)
- `inet_port` - (is: String)
- `inet_username` - (is: String)
- `inet_password` - (is: String)
- `include_files` - (is: [String, Array])

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

#### Properties

- `type` - (is: String)
- `command` - (is: String)
- `process_name` - (is: String)
- `numprocs` - (is: Integer)
- `numprocs_start` - (is: Integer)
- `priority` - (is: Integer)
- `autostart` - (is: Boolean)
- `autorestart` - (is: [String, Boolean, Symbol])
- `startsecs` - (is: Integer)
- `startretries` - (is: Integer)
- `exitcodes` - (is: Array)
- `stopsignal` - (is: [String, Symbol])
- `stopwaitsec` - (is: Integer)
- `stopasgroup` - (is: Boolean)
- `killasgroup` - (is: Boolean)
- `user` - (is: String)
- `redirect_stderr` - (is: Boolean)
- `environment` - (is: Hash)
- `directory` - (is: [String, Nil])
- `umask` - (is: [String, Nil])
- `serverurl` - (is: String)
- `stdout_logfile` - (is: String)
- `stdout_logfile_maxbytes` - (is: String)
- `stdout_logfile_backups` - (is: Integer)
- `stdout_capture_maxbytes` - (is: String)
- `stdout_events_enabled` - (is: Boolean)
- `stderr_logfile` - (is: String)
- `stderr_logfile_maxbytes` - (is: String)
- `stderr_logfile_backups` - (is: Integer)
- `stderr_capture_maxbytes` - (is: String)
- `stderr_events_enabled` - (is: Boolean)
- `eventlistener_buffer_size` - (is: Integer)
- `eventlistener_events` - (is: Array)
- `eventlistener_result_handler` - (is: String)
- `fcgi_socket` - (is: String)
- `fcgi_socket_owner` - (is: [String, Nil])
- `fcgi_socket_mode` - (is: String)

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

#### Properties

- `programs` - (is: Array)
- `priority` - (is: Integer)

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

#### Examples

```ruby
supervisor_service 'supervisor'
```

#### Note

The name property of the resource should always just be `supervisor`.
