# To learn more about Custom Resources, see https://docs.chef.io/custom_resources.html
resource_name :supervisor_process

property :name, String, name_property: true
property :type, String, required: true, equal_to: ['program', 'eventlistener', 'fcgi-program']
# Program
property :command, String, required: true
property :process_name, String, default: '%(program_name)s'
property :numprocs, Integer, default: 1
property :numprocs_start, Integer, default: 0
property :priority, Integer, default: 999
property :autostart, [TrueClass, FalseClass], default: false
property :autorestart, [TrueClass, FalseClass], default: false
property :startsecs, Integer, default: 1
property :startretries, Integer, default: 3
property :exitcodes, Array, default: [0, 2]
property :stopsignal, [String, Symbol], default: :TERM
property :stopwaitsecs, Integer, default: 10
property :stopasgroup,  [TrueClass, FalseClass], default: true
property :killasgroup,  [TrueClass, FalseClass], default: true
property :user, [String, NilClass], default: nil
property :redirect_stderr, [TrueClass, FalseClass], default: false
property :environment, Hash, default: {}
property :directory, [String, NilClass], default: nil
property :umask, [String, NilClass], default: nil
property :serverurl, String, default: 'AUTO'
property :stdout_logfile, String, default: 'AUTO'
property :stdout_logfile_maxbytes, String, default: '50MB'
property :stdout_logfile_backups, Integer, default: 10
property :stdout_capture_maxbytes, String, default: '0'
property :stdout_events_enabled,  [TrueClass, FalseClass], default: false
property :stderr_logfile, String, default: 'AUTO'
property :stderr_logfile_maxbytes, String, default: '50MB'
property :stderr_logfile_backups, Integer, default: 10
property :stderr_capture_maxbytes, String, default: '0'
property :stderr_events_enabled, [TrueClass, FalseClass], default: false

# Eventlistener
property :eventlistener_buffer_size, Integer, default: 10
property :eventlistener_events, Array, default: ['EVENT']
property :eventlistener_result_handler, String, default: 'supervisor.dispatchers:default_handler'

# Fcgi Program
property :fcgi_socket, String, default: 'unix:///var/run/supervisor/%(program_name)s.sock'
property :fcgi_socket_owner, [String, NilClass], default: nil
property :fcgi_socket_mode, String, default: '0700'

property :template, String, default: 'gamegos-supervisor'

action :create do
  clean_name = new_resource.name.downcase.tr(' ', '_')
  unique_name_for_process = "#{new_resource.type}_#{clean_name}"
  template "supervisor_#{unique_name_for_process}" do
    cookbook new_resource.template
    path lazy { "#{node.run_state['supervisor']['directory']}/#{unique_name_for_process}.conf" }
    source 'process.conf.erb'
    owner 'root'
    group 'root'
    mode '644'
    variables(
      name: clean_name,
      service: new_resource
    )
  end
end
