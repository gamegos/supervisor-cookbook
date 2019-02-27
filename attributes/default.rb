default['supervisor']['supervisord_default_path'] = if platform_family?('rhel')
                                                      '/usr/bin'
                                                    else
                                                      '/usr/local/bin'
                                                    end
