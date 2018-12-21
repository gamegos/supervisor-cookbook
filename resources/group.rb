# To learn more about Custom Resources, see https://docs.chef.io/custom_resources.html
resource_name :supervisor_group

property :name, String, name_attribute: true
property :programs, Array, required: true
property :priority, Integer, default: 999
property :template, String, default: 'gamegos-supervisor'

action :create do
  template "supervisor_group_#{new_resource.name}" do
    cookbook new_resource.template
    path lazy { "#{node.run_state['supervisor']['directory']}/group_#{new_resource.name}.conf" }
    source 'group.conf.erb'
    owner 'root'
    group 'root'
    mode '644'
    variables group: new_resource
  end
end
