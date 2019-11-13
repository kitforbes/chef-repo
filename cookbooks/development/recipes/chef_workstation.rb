return unless platform_family?('windows')

chocolatey_package 'chef-workstation' do
  action :install
end
