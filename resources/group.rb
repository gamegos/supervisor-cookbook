# To learn more about Custom Resources, see https://docs.chef.io/custom_resources.html
resource_name :supervisor_group

property :group_name, String, name_property: true
property :programs, Array, required: true
property :priority, Integer, default: 999
property :template, String, default: 'gamegos-supervisor'

action :create do
  declare_resource(:template, "supervisor_group_#{new_resource.group_name}") do
    cookbook new_resource.template
    path(lazy { "#{node.run_state['supervisor']['directory']}/group_#{new_resource.group_name}.conf" })
    source 'group.conf.erb'
    owner 'root'
    group 'root'
    mode '644'
    variables group: new_resource
    notifies :reread, find_resource(:supervisor_service, 'supervisor'), :delayed
  end
end

action :delete do
  file 'delete specific group configuration file' do
    path(lazy { "#{node.run_state['supervisor']['directory']}/group_#{new_resource.group_name}.conf" })
    action :delete
    notifies :reread, find_resource(:supervisor_service, 'supervisor'), :delayed
  end
end
