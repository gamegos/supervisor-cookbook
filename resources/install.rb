# To learn more about Custom Resources, see https://docs.chef.io/custom_resources.html
resource_name :supervisor_install

property :version, String, name_property: true

action :create do
  python_runtime 'supervisor' do
    provider :system
    version '2'
    pip_version '18.0'
  end

  python_package 'supervisor' do
    version new_resource.version
  end
end
