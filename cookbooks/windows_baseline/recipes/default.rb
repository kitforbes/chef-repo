chef_gem 'mixlib-versioning' do
  compile_time true
  action :install
end

include_recipe 'windows_baseline::features'
include_recipe 'windows_baseline::chocolatey'
include_recipe 'windows_baseline::google_chrome'
include_recipe 'windows_baseline::firefox'

chocolatey_package '7zip' do
  action :install
end

chocolatey_package 'dropbox' do
  action :install
end

chocolatey_package 'googledrive' do
  action :install
end

chocolatey_package 'vlc' do
  options '--params "/Language:en"'
  action :install
end

chocolatey_package 'teamviewer' do
  action :install
end
