return unless node['platform_family'] == 'windows'

cmder_config_dir = 'C:\tools\cmder\config'

# This version fixes the "green output" issue.
powershell_package 'PSReadline' do
  version '2.0.0-beta4'
  action :install
end

chocolatey_package 'cmder' do
  action :install
end

directory cmder_config_dir do
  recursive true
  action :create
end

template "#{cmder_config_dir}\\settings" do
  source 'cmder_settings.erb'
  action :create
end

template "#{cmder_config_dir}\\user-ConEmu.xml" do
  source 'cmder_ConEmu.xml.erb'
  action :create
end

template "#{cmder_config_dir}\\user_aliases.cmd" do
  source 'cmder_aliases.cmd.erb'
  action :create
end

template "#{cmder_config_dir}\\user_profile.cmd" do
  source 'cmder_profile.cmd.erb'
  action :create
end

template "#{cmder_config_dir}\\user_profile.ps1" do
  source 'cmder_profile.ps1.erb'
  action :create
end
