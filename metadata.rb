name 'gamegos-supervisor'
maintainer 'Fatih Sarhan'
maintainer_email 'f9n@protonmail.com'
license 'GPL-3.0'
description 'Installs/Configures supervisor'
long_description 'Installs/Configures supervisor'
chef_version '>= 12.0'
%w(amazon centos debian redhat ubuntu).each do |os|
  supports os
end
version '1.0.0'

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
issues_url 'https://github.com/gamegos/supervisor-cookbook/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
source_url 'https://github.com/gamegos/supervisor-cookbook'

depends 'poise-python', '~> 1.7.0'
depends 'poise-service', '~> 1.5.2'
