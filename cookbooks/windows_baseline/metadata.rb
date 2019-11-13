name 'windows_baseline'
maintainer 'Chris Forbes'
maintainer_email 'chef@chrisforbes.dev'
license 'MIT'
description 'Baseline requirements for a Windows machine.'
version '0.1.0'

supports 'windows'

depends 'chocolatey'
depends 'powershell'
depends 'windows'

source_url 'https://github.com/kitforbes/chef-repo'
issues_url 'https://github.com/kitforbes/chef-repo/issues'
chef_version '>= 14.3'
