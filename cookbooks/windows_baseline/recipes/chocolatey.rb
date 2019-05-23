return unless node['platform_family'] == 'windows'

chocolatey_install_dir = "#{ENV['ALLUSERSPROFILE']}\\chocolatey"

include_recipe 'chocolatey::default' unless ::File.exists?("#{chocolatey_install_dir}\\bin\\choco.exe")

chocolatey_source 'chocolatey' do
  source 'https://chocolatey.org/api/v2/'
  action node['chocolatey']['allow_gallery'] ? :add : :remove
end

node['chocolatey']['sources'].each do |s|
  chocolatey_source s[:name] do
    source s[:url]
    action :add
  end
end

node['chocolatey']['config'].each do |k, v|
  chocolatey_config k do
    value v.to_s
    action :set
  end if v
end

node['chocolatey']['features'].each do |k, v|
  chocolatey_feature k do
    action v ? :enable : :disable
  end if v
end

chocolatey_package 'chocolatey' do
  options '--allow-downgrade'
  version node['chocolatey']['version']
  action :install
end

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

# Remove unnecessary files: https://github.com/bcurran3/ChocolateyPackages/blob/master/choco-cleaner/tools/choco-cleaner.ps1
file "#{chocolatey_install_dir}\\bin\\_processed.txt" do
  action :delete
end

[
  "#{chocolatey_install_dir}\\lib-bad",
  "#{chocolatey_install_dir}\\lib-bkp",
  "#{ENV['HOME']}\\AppData\\Local\\NuGet\\Cache",
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
      ::Dir.entries(dir).each do |entry|
        next if /^\.|\.\.|chocolatey.log|choco.summary.log$/.match?(entry)
        ::FileUtils.remove_entry_secure(::File.join(dir, entry))
      end
    end
    action :run
    only_if { ::Dir.exist?(dir) && ::Dir.entries(dir).length > 4 }
  end
end

[
  "#{ENV['Temp']}\\chocolatey",
].each do |dir|
  # TODO: Create a custom resource for directory cleaning.
  ruby_block dir do
    block do
      ::Dir.entries(dir).each do |entry|
        next if /^\.|\.\.$/.match?(entry)
        ::FileUtils.remove_entry_secure(::File.join(dir, entry))
      end
    end
    action :run
    only_if { ::Dir.exist?(dir) && ::Dir.entries(dir).length > 2 }
  end
end
