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

supervisor_group 'vi' do
  programs ['vi']
end

supervisor_service 'supervisor'
