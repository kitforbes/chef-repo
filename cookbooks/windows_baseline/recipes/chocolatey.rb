include_recipe 'chocolatey::default'

# chocolatey_version = '0.10.10'
# chocolatey_install_script = 'https://chocolatey.org/install.ps1'
# powershell_script 'install-chocolatey' do
#   code <<-EOH
#   $env:ChocolateyVersion = '#{chocolatey_version}'
#   $env:ChocolateyUseWindowsCompression = 'true'
#   Set-ExecutionPolicy Bypass -Scope Process -Force
#   Invoke-Expression -Command ((New-Object System.Net.WebClient).DownloadString('#{chocolatey_install_script}'))
#   EOH
#   action :run
#   not_if { ::File.directory?("#{ENV['ALLUSERSPROFILE']}\\chocolatey") }
# end

chocolatey_package 'chocolatey' do
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
