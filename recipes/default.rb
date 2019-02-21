#
# Cookbook:: gamegos-supervisor
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
supervisor_install '3.3'

supervisor_config 'supervisor'

supervisor_service 'supervisor'
