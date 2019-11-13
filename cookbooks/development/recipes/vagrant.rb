return unless platform_family?('windows')

chocolatey_package 'vagrant' do
  action :install
end

# TODO: Install Vagrant plugins:
#   https://github.com/sous-chefs/vagrant

# https://www.vagrantup.com/docs/other/environmental-variables.html
%w(
  CHECKPOINT_DISABLE
  VAGRANT_CHECKPOINT_DISABLE
).each do |var|
  env var do
    value '1'
    action :create
  end
end
