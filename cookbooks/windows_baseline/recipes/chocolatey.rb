return unless node['platform_family'] == 'windows'

require 'mixlib/versioning'

include_recipe 'chocolatey::default'

if Mixlib::Versioning.parse(node['chef_packages']['chef']['version']) >= Mixlib::Versioning.parse('14.3')
  chocolatey_source 'chocolatey' do
    source 'https://chocolatey.org/api/v2/'
    action :add
  end
end

chocolatey_package 'chocolatey' do
  options '--allow-downgrade'
  version node['chocolatey']['version']
  action :install
end

env 'ChocolateyInstall' do
  value "#{ENV['ALLUSERSPROFILE']}\\chocolatey"
  action :create
end

env 'ChocolateyToolsLocation' do
  value 'C:\\tools'
  action :create
end

directory 'C:\\tools' do
  action :create
end

windows_path 'C:\\tools' do
  action :add
end
