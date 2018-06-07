name 'windows_baseline'
maintainer 'Chris Forbes'
maintainer_email 'kitforbes@users.noreply.github.com'
license 'MIT'
readme_file = IO.read(File.join(File.dirname(__FILE__), 'README.md'))
description readme_file.match(/<!-- begin: description -->(.*?)<!-- end: description -->/m)[1].strip
long_description readme_file
version '0.1.0'

supports 'windows'

depends 'windows'
depends 'chocolatey-cookbook'

source_url 'https://github.com/kitforbes/chef-repo'
issues_url 'https://github.com/kitforbes/chef-repo/issues'
chef_version '>= 12.1' if respond_to?(:chef_version)
