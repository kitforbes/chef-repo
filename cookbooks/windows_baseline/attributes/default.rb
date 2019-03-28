default['powershell']['installation_reboot_mode'] = 'immediate_reboot'

default['chocolatey']['upgrade'] = false
default['chocolatey']['version'] = '0.10.11'
default['chocolatey']['install_vars'].tap do |env|
  env['chocolateyVersion'] = node['chocolatey']['version']
  env['chocolateyUseWindowsCompression'] = 'true'
end

# Modify global Chocolatey configuration.
default['chocolatey']['config'].tap do |config|
  config['cache_location'] = nil
  config['contains_legacy_package_installs'] = true
  config['command_execution_timeout_seconds'] = 2700
  config['proxy'] = nil
  config['proxy_user'] = nil
  config['proxy_password'] = nil
  config['web_request_timeout_seconds'] = 30
  config['proxy_bypass_list'] = nil
  config['proxy_bypass_on_local'] = true
end

# Modify global Chocolatey features.
default['chocolatey']['features'].tap do |feature|
  feature['checksum_files'] = true
  feature['auto_uninstaller'] = true
  feature['allow_global_confirmation'] = false
  feature['fail_on_auto_uninstaller'] = false
  feature['fail_on_standard_error'] = false
  feature['allow_empty_checksums'] = false
  feature['allow_empty_checksums_secure'] = true
  feature['powershell_host'] = true
  feature['log_environment_values'] = false
  feature['virus_check'] = false
  feature['fail_on_invalid_or_missing_license'] = false
  feature['ignore_invalid_options_switches'] = false
  feature['use_package_exit_codes'] = true
  feature['use_fips_compliant_checksums'] = false
  feature['show_non_elevated_warnings'] = true
  feature['show_download_progress'] = false
  feature['stop_on_first_package_failure'] = true
  feature['use_remembered_arguments_for_upgrades'] = false
  feature['scripts_check_last_exit_code'] = false
  feature['ignore_unfound_packages_on_upgrade_outdated'] = false
  feature['remove_package_information_on_uninstall'] = true
  feature['log_without_color'] = false
end

# Whether or not to allow the public Chocolatey gallery.
default['chocolatey']['allow_gallery'] = true

# The collection of sources to add.
default['chocolatey']['sources'] = [
]
