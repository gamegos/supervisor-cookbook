#
# Cookbook:: gamegos-supervisor
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
supervisor_install '3.3'

supervisor_config '/etc/supervisor' do
  action :create
end

supervisor_process 'cat' do
  type 'eventlistener'
  command '/bin/cat'
end

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
