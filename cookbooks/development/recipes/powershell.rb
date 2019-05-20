return unless node['platform_family'] == 'windows'

[
  { name: 'PSScriptAnalyzer', version: '1.16.1' },
  { name: 'posh-git', version: '0.7.3' },
  { name: 'psake', version: '4.7.0' },
  { name: 'Pester', version: '4.3.1' },
  { name: 'Plaster', version: '1.1.3' },
  { name: 'platyPS', version: '0.8.3' },
].each do |m|
  powershell_package m[:name] do
    version m[:version]
    action :install
  end
end

template "#{ENV['USERPROFILE']}\\Documents\\WindowsPowerShell\\Microsoft.PowerShell_profile.ps1" do
  source 'Microsoft.PowerShell_profile.ps1.erb'
  action :create
end
