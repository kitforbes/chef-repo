return unless platform_family?('windows')

chocolatey_package 'chef-workstation' do
  version '0.2.39'
  action :install
end
