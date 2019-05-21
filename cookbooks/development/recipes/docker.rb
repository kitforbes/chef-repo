return unless node['platform_family'] == 'windows'

chocolatey_package 'docker-for-windows' do
  action :install
end
