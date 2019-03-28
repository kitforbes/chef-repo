return unless node['platform_family'] == 'windows'

include_recipe 'chocolatey::default'

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
    cache_location: node['chocolatey']['config']['cache_location'],
    contains_legacy_package_installs: node['chocolatey']['config']['contains_legacy_package_installs'],
    command_execution_timeout_seconds: node['chocolatey']['config']['command_execution_timeout_seconds'],
    proxy: node['chocolatey']['config']['proxy'],
    proxy_user: node['chocolatey']['config']['proxy_user'],
    proxy_password: node['chocolatey']['config']['proxy_password'],
    web_request_timeout_seconds: node['chocolatey']['config']['web_request_timeout_seconds'],
    proxy_bypass_list: node['chocolatey']['config']['proxy_bypass_list'],
    proxy_bypass_on_local: node['chocolatey']['config']['proxy_bypass_on_local'],
    checksum_files: node['chocolatey']['features']['checksum_files'],
    auto_uninstaller: node['chocolatey']['features']['auto_uninstaller'],
    allow_global_confirmation: node['chocolatey']['features']['allow_global_confirmation'],
    fail_on_auto_uninstaller: node['chocolatey']['features']['fail_on_auto_uninstaller'],
    fail_on_standard_error: node['chocolatey']['features']['fail_on_standard_error'],
    allow_empty_checksums: node['chocolatey']['features']['allow_empty_checksums'],
    allow_empty_checksums_secure: node['chocolatey']['features']['allow_empty_checksums_secure'],
    powershell_host: node['chocolatey']['features']['powershell_host'],
    log_environment_values: node['chocolatey']['features']['log_environment_values'],
    virus_check: node['chocolatey']['features']['virus_check'],
    fail_on_invalid_or_missing_license: node['chocolatey']['features']['fail_on_invalid_or_missing_license'],
    ignore_invalid_options_switches: node['chocolatey']['features']['ignore_invalid_options_switches'],
    use_package_exit_codes: node['chocolatey']['features']['use_package_exit_codes'],
    use_fips_compliant_checksums: node['chocolatey']['features']['use_fips_compliant_checksums'],
    show_non_elevated_warnings: node['chocolatey']['features']['show_non_elevated_warnings'],
    show_download_progress: node['chocolatey']['features']['show_download_progress'],
    stop_on_first_package_failure: node['chocolatey']['features']['stop_on_first_package_failure'],
    use_remembered_arguments_for_upgrades: node['chocolatey']['features']['use_remembered_arguments_for_upgrades'],
    scripts_check_last_exit_code: node['chocolatey']['features']['scripts_check_last_exit_code'],
    ignore_unfound_packages_on_upgrade_outdated: node['chocolatey']['features']['ignore_unfound_packages_on_upgrade_outdated'],
    remove_package_information_on_uninstall: node['chocolatey']['features']['remove_package_information_on_uninstall'],
    log_without_color: node['chocolatey']['features']['log_without_color'],
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
