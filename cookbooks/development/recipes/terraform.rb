return unless node['platform_family'] == 'windows'

chocolatey_package 'terraform' do
  action :install
end
