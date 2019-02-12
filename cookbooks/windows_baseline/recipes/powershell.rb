return unless node['platform_family'] == 'windows'

if Gem::Requirement.new('< 5.1').satisfied_by?(Gem::Version.new(node['languages']['powershell']['version']))
  throw 'PowerShell 5.1 is required.'
end

if Gem::Requirement.new('>= 14.3').satisfied_by?(Gem::Version.new(node['chef_packages']['chef']['version']))
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
    guard_interpreter :powershell_script
    only_if '(Get-PSRepository -Name PSGallery -ErrorAction SilentlyContinue) -eq $null'
  end
end

powershell_script 'NuGet' do
  code <<-EOH
  Find-PackageProvider -Name NuGet -RequiredVersion 2.8.5.208 |
      Install-PackageProvider -Force -Confirm:$false
  EOH
  action :run
  guard_interpreter :powershell_script
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

powershell_script 'remove-builtin-PowerShellGet' do
  code <<-EOH
  $module = Get-Module -Name PowerShellGet -ListAvailable | Where-Object -Property Version -eq 1.0.0.1
  Remove-Module $module.Name -Force -Confirm:$false
  Remove-Item -Path $module.ModuleBase -Force -Recurse
  EOH
  action :run
  guard_interpreter :powershell_script
  not_if '(Get-Module -Name PowerShellGet -ListAvailable | Where-Object -Property Version -eq 1.0.0.1) -eq $null'
  guard_interpreter :powershell_script
  not_if '(Get-Module -Name PowerShellGet -ListAvailable).Count -eq 1'
end

powershell_script 'remove-builtin-PackageManagement' do
  code <<-EOH
  $module = Get-Module -Name PackageManagement -ListAvailable | Where-Object -Property Version -eq 1.0.0.1
  Remove-Module $module.Name -Force -Confirm:$false
  Remove-Item -Path $module.ModuleBase -Force -Recurse
  EOH
  action :run
  guard_interpreter :powershell_script
  not_if '(Get-Module -Name PackageManagement -ListAvailable | Where-Object -Property Version -eq 1.0.0.1) -eq $null'
  guard_interpreter :powershell_script
  not_if '(Get-Module -Name PackageManagement -ListAvailable).Count -eq 1'
end

powershell_script 'remove-builtin-Pester' do
  code <<-EOH
  $module = Get-Module -Name Pester -ListAvailable | Where-Object -Property Version -eq 3.4.0
  Takeown /d Y /R /f $module.ModuleBase | Out-Null
  Icacls $module.ModuleBase /GRANT:r administrators:F /T /c /q
  Remove-Item -Path $module.ModuleBase -Force -Recurse
  EOH
  action :run
  guard_interpreter :powershell_script
  not_if '(Get-Module -Name Pester -ListAvailable | Where-Object -Property Version -eq 3.4.0) -eq $null'
  guard_interpreter :powershell_script
  not_if '(Get-Module -Name Pester -ListAvailable).Count -eq 1'
end
