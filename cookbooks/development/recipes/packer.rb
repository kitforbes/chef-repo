return unless node['platform_family'] == 'windows'

[
  'Microsoft-Hyper-V-All',
  'Microsoft-Windows-Subsystem-Linux',
].each do |feature|
  windows_feature feature do
    install_method :windows_feature_dism
    action :install
  end
end

chocolatey_package 'packer' do
  action :install
end
