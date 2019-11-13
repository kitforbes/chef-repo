return unless platform_family?('windows')

windows_feature 'NetFx3' do
  install_method :windows_feature_dism
  action :install
end

chocolatey_package 'DotNet4.5.2' do
  version '4.5.2.20140902'
  action :install
end

chocolatey_package 'DotNet4.6.1' do
  version '4.6.01055.20170308'
  action :install
end

chocolatey_package 'dotnetcore-sdk' do
  version '2.1.105'
  action :install
end

env 'DOTNET_CLI_TELEMETRY_OPTOUT' do
  value '1'
  action :create
end
