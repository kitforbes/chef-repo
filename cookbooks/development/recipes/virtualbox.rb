return unless platform_family?('windows')

chocolatey_package 'virtualbox' do
  options '--params "/CurrentUser /NoDesktopShortcut"'
  action :install
end
