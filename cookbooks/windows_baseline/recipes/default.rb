return unless platform_family?('windows')

include_recipe 'windows_baseline::features'
include_recipe 'windows_baseline::powershell'
include_recipe 'windows_baseline::chocolatey'
include_recipe 'windows_baseline::user_settings'
