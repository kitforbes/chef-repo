# frozen_string_literal: true

name 'example'
maintainer 'Chris Forbes'
maintainer_email 'kitforbes@users.noreply.github.com'
license 'MIT'
description 'Installs/Configures example'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.0'

recipe 'example::default', 'Log a name'

supports 'centos'
supports 'ubuntu'

source_url 'https://github.com/kitforbes/chef-repo'
issues_url 'https://github.com/kitforbes/chef-repo/issues'

chef_version '>= 12.1' if respond_to?(:chef_version)
