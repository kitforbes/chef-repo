return unless platform_family?('windows')

chocolatey_package 'chef-workstation' do
  action :install
end

env 'EDITOR' do
  value 'code --wait'
  action :create
end
