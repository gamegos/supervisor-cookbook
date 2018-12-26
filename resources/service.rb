# To learn more about Custom Resources, see https://docs.chef.io/custom_resources.html
resource_name :supervisor_service

action :create do
  poise_service 'supervisor' do
    command lazy { "/usr/local/bin/supervisord -n -c #{node.run_state['supervisor']['config_file']}" }
  end
end
