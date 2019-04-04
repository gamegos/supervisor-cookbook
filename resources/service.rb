# To learn more about Custom Resources, see https://docs.chef.io/custom_resources.html
resource_name :supervisor_service

property :supervisord_executable_path, String, default: lazy { node['supervisor']['supervisord_default_path'] }

action :create do
  supervisor('create')
end

action :stop do
  supervisor('stop')
end

action :reload do
  # update: Reload config and add/remove as necessary
  supervisorctl('update')
end

action :update do
  action_reload
end

action :reread do
  # reread: Reload the daemon's configuration files
  supervisorctl('reread')
end

action :restart do
  # reload: Restart the remote supervisord.
  supervisorctl('reload')
end

action_class do
  def supervisor(actn)
    poise_service 'supervisor' do
      action actn.to_sym
      command(lazy { "#{new_resource.supervisord_executable_path}/supervisord -n -c #{node.run_state['supervisor']['config_file']}" })
      stop_signal 'SIGTERM'
    end
  end

  def supervisorctl(command)
    execute "supervisorctl #{command}" do
      command(lazy { "#{new_resource.supervisord_executable_path}/supervisorctl -c #{node.run_state['supervisor']['config_file']} #{command}" })
      action :run
    end
  end
end
