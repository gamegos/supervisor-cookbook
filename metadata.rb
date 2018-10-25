name 'gamegos-supervisor'
maintainer 'Fatih Sarhan'
maintainer_email 'f9n@protonmail.com'
license 'GPL-3.0'
description 'Installs/Configures supervisor'
long_description 'Installs/Configures supervisor'
version '0.1.0'
chef_version '>= 13.0'

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
