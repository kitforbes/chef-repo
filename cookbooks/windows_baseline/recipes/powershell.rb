return unless node['platform_family'] == 'windows'

require 'mixlib/versioning'

# TODO: Install PowerShell 5.1
if Mixlib::Versioning.parse(node['languages']['powershell']['version']) < Mixlib::Versioning.parse('5.1')
  log 'PowerShell 5.1 is required.'
  return
end

if Mixlib::Versioning.parse(node['chef_packages']['chef']['version']) >= Mixlib::Versioning.parse('14.3')
  powershell_package_source 'PSGallery' do
    provider_name 'NuGet'
    publish_location 'https://www.powershellgallery.com/api/v2/package/'
    script_publish_location 'https://www.powershellgallery.com/api/v2/package/'
    script_source_location 'https://www.powershellgallery.com/api/v2/items/psscript/'
    url 'https://www.powershellgallery.com/api/v2'
    trusted false
    action :register
  end
else
  powershell_script 'register-PSGallery' do
    code 'Register-PSRepository -Default'
    action :run
    only_if '(Get-PSRepository -Name PSGallery -ErrorAction SilentlyContinue) -eq $null'
  end
end

powershell_script 'NuGet' do
  code <<-EOH
  Find-PackageProvider -Name NuGet -RequiredVersion 2.8.5.208 |
      Install-PackageProvider -Force -Confirm:$false
  EOH
  action :run
  only_if '(Get-PackageProvider -Name NuGet -ListAvailable | Where-Object -Property Version -eq 2.8.5.208) -eq $null'
end

# Includes 'PackageManagement'
powershell_package 'PowerShellGet' do
  version '1.6.0'
  action :install
end

# Dependency of 'PowerShellGet'
powershell_package 'PackageManagement' do
  version '1.1.7.0'
  action :install
end
