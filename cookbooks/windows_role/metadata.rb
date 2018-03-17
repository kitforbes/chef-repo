# frozen_string_literal: true

name 'windows_role'
maintainer 'Chris Forbes'
maintainer_email 'kitforbes@users.noreply.github.com'
license 'MIT'
description ''
long_description ''
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

issues_url 'https://github.com/kitforbes/chef-repo/issues'
source_url 'https://github.com/kitforbes/chef-repo'

supports 'windows'

depends 'windows'
