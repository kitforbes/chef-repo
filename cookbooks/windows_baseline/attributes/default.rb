default['powershell']['installation_reboot_mode'] = 'immediate_reboot'

default['chocolatey']['upgrade'] = false
default['chocolatey']['version'] = '0.10.11'
default['chocolatey']['install_vars'].tap do |env|
  env['chocolateyVersion'] = node['chocolatey']['version']
  env['chocolateyUseWindowsCompression'] = 'true'
end

# Modify global Chocolatey configuration.
default['chocolatey']['config'].tap do |config|
  config['cacheLocation'] = nil
  config['containsLegacyPackageInstalls'] = true
  config['commandExecutionTimeoutSeconds'] = 2700
  config['proxy'] = nil
  config['proxyUser'] = nil
  config['proxyPassword'] = nil
  config['webRequestTimeoutSeconds'] = 30
  config['proxyBypassList'] = nil
  config['proxyBypassOnLocal'] = true
end

# Modify global Chocolatey features.
default['chocolatey']['features'].tap do |feature|
  feature['checksumFiles'] = true
  feature['autoUninstaller'] = true
  feature['allowGlobalConfirmation'] = false
  feature['failOnAutoUninstaller'] = false
  feature['failOnStandardRrror'] = false
  feature['allowEmptyChecksums'] = false
  feature['allowEmptyChecksumsSecure'] = true
  feature['powershellHost'] = true
  feature['logEnvironmentValues'] = false
  feature['virusCheck'] = false
  feature['failOnInvalidOrMissingLicense'] = false
  feature['ignoreInvalidOptionsSwitches'] = false
  feature['usePackageExitCodes'] = true
  feature['useFipsCompliantChecksums'] = false
  feature['showNonElevatedWarnings'] = true
  feature['showDownloadProgress'] = false
  feature['stopOnFirstPackageFailure'] = true
  feature['useRememberedArgumentsForUpgrades'] = false
  feature['scriptsCheckLastExitCode'] = false
  feature['ignoreUnfoundPackagesOnUpgradeOutdated'] = false
  feature['removePackageInformationOnUninstall'] = true
  feature['logWithoutColor'] = false
end

# Whether or not to allow the public Chocolatey gallery.
default['chocolatey']['allow_gallery'] = true

# The collection of sources to add.
default['chocolatey']['sources'] = [
]
