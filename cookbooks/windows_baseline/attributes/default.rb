default['chocolatey']['upgrade'] = false
default['chocolatey']['version'] = '0.10.11'
default['chocolatey']['install_vars'].tap do |env|
  env['chocolateyVersion'] = node['chocolatey']['version']
  env['chocolateyUseWindowsCompression'] = 'true'
end

default['chocolatey']['cache_location'] = nil

# Whether or not to allow the public Chocolatey gallery.
default['chocolatey']['allow_gallery'] = true

# The collection of sources to add.
default['chocolatey']['sources'] = [
]
