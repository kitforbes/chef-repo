return unless node['platform_family'] == 'windows'

chef_gem 'mixlib-versioning' do
  compile_time true
  action :install
end

include_recipe 'windows_baseline::features'
include_recipe 'windows_baseline::powershell'
include_recipe 'windows_baseline::chocolatey'
