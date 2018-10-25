# To learn more about Custom Resources, see https://docs.chef.io/custom_resources.html
resource_name :supervisor_install

property :version, String, name_property: true

action :create do
  node.override['poise-python']['options']['pip_version'] = '18.0'

  python_runtime '2'

  python_package 'supervisor' do
    version new_resource.version
  end
end
