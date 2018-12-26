# To learn more about Custom Resources, see https://docs.chef.io/custom_resources.html
resource_name :supervisor_service
property :supervisord_executable_path, String, default: '/usr/local/bin/supervisord'

action :create do
  poise_service 'supervisor' do
    command lazy { "#{new_resource.supervisord_executable_path} -n -c #{node.run_state['supervisor']['config_file']}" }
  end
end

action :reload do
  with_run_context :root do
    find_resource(:poise_service, 'supervisor') do
    end.run_action(:reload)
  end
end
