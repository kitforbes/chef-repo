return unless node['platform_family'] == 'windows'

require 'mixlib/versioning'

include_recipe 'chocolatey::default'

# if Mixlib::Versioning.parse(node['chef_packages']['chef']['version']) >= Mixlib::Versioning.parse('14.3')
#   chocolatey_source 'chocolatey' do
#     source 'https://chocolatey.org/api/v2/'
#     action :add
#   end
# end

chocolatey_package 'chocolatey' do
  options '--allow-downgrade'
  version node['chocolatey']['version']
  action :install
end

chocolatey_install_dir = "#{ENV['ALLUSERSPROFILE']}\\chocolatey"

env 'ChocolateyInstall' do
  value chocolatey_install_dir
  action :create
end

env 'ChocolateyToolsLocation' do
  value 'C:\tools'
  action :create
end

directory 'C:\tools' do
  action :create
end

windows_path 'C:\tools' do
  action :add
end

directory "#{chocolatey_install_dir}\\config" do
  recursive true
  action :create
end

template "#{chocolatey_install_dir}\\config\\chocolatey.config" do
  source 'chocolatey.config.erb'
  variables(
    cache_location: node['chocolatey']['cache_location'],
    allow_gallery: node['chocolatey']['allow_gallery'],
    sources: node['chocolatey']['sources']
  )
  action :create
end

# Remove unnecessary files: https://github.com/bcurran3/ChocolateyPackages/blob/master/choco-cleaner/tools/choco-cleaner.ps1
file "#{chocolatey_install_dir}\\bin\\_processed.txt" do
  action :delete
end

[
  "#{chocolatey_install_dir}\\lib-bad",
  "#{chocolatey_install_dir}\\lib-bkp",
  "#{ENV['UserProfile']}\\AppData\\Local\\NuGet\\Cache",
].each do |dir|
  directory dir do
    recursive true
    action :delete
  end
end

[
  "#{chocolatey_install_dir}\\logs",
].each do |dir|
  ruby_block dir do
    block do
      Dir.entries(dir).each do |entry|
        next if /^\.|\.\.|chocolatey.log|choco.summary.log$/.match?(entry)
        FileUtils.remove_entry_secure(File.join(dir, entry))
      end
    end
    action :run
    only_if { Dir.exist?(dir) && Dir.entries(dir).length > 4 }
  end
end

[
  "#{ENV['Temp']}\\chocolatey",
].each do |dir|
  # TODO: Create a custom resource for directory cleaning.
  ruby_block dir do
    block do
      Dir.entries(dir).each do |entry|
        next if /^\.|\.\.$/.match?(entry)
        FileUtils.remove_entry_secure(File.join(dir, entry))
      end
    end
    action :run
    only_if { Dir.exist?(dir) && Dir.entries(dir).length > 2 }
  end
end
