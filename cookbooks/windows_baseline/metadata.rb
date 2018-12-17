name 'windows_baseline'
maintainer 'Chris Forbes'
maintainer_email 'kitforbes@users.noreply.github.com'
license 'MIT'
description ''
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.0'

supports 'windows'

depends 'windows'
depends 'chocolatey'

source_url 'https://github.com/kitforbes/chef-repo'
issues_url 'https://github.com/kitforbes/chef-repo/issues'
chef_version '>= 12.1' if respond_to?(:chef_version)
