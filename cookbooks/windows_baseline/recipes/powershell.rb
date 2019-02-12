return unless node['platform_family'] == 'windows'

if Gem::Requirement.new('< 10.0').satisfied_by?(Gem::Version.new(node['platform_version']))
  include_recipe 'powershell::powershell5'
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

[
  # Includes 'PackageManagement'
  { name: 'PowerShellGet', version: '1.6.0' },
  { name: 'PackageManagement', version: '1.1.7.0' },
].each do |m|
  powershell_package m[:name] do
    version m[:version]
    action :install
  end
end

[
  { name: 'PowerShellGet', version: '1.0.0.1' },
  { name: 'PackageManagement', version: '1.0.0.1' },
  { name: 'Pester', version: '3.4.0' },
].each do |m|
  powershell_script "remove-builtin-#{m[:name]}" do
    code <<-EOH
    $module = Get-Module -Name #{m[:name]} -ListAvailable | Where-Object -Property Version -eq #{m[:version]}
    Remove-Module $module.Name -Force -Confirm:$false
    Remove-Item -Path $module.ModuleBase -Force -Recurse
    EOH
    action :run
    guard_interpreter :powershell_script
    not_if "(Get-Module -Name #{m[:name]} -ListAvailable | Where-Object -Property Version -eq #{m[:version]}) -eq $null"
    guard_interpreter :powershell_script
    not_if "(Get-Module -Name #{m[:name]} -ListAvailable).Count -eq 1"
  end
end
