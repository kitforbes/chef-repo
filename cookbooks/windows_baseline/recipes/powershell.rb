return unless platform_family?('windows')

if Gem::Requirement.new('< 10.0').satisfied_by?(Gem::Version.new(node['platform_version']))
  include_recipe 'powershell::powershell5'
end

powershell_script 'PSGallery' do
  code 'Register-PSRepository -Default'
  action :run
  only_if '(Get-PSRepository -Name PSGallery -ErrorAction SilentlyContinue) -eq $null'
end

powershell_script 'NuGet' do
  code <<-EOH
  Find-PackageProvider -Name NuGet -RequiredVersion 2.8.5.208 |
      Install-PackageProvider -Force -Confirm:$false
  EOH
  action :run
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
    not_if "(Get-Module -Name #{m[:name]} -ListAvailable | Where-Object -Property Version -eq #{m[:version]}) -eq $null"
    not_if "(Get-Module -Name #{m[:name]} -ListAvailable).Count -eq 1"
  end
end
