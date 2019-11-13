return unless platform_family?('windows')

%w(
  powershell
  git
  chef_workstation
  vs_code
  utilities
).each do |recipe|
  include_recipe "development::#{recipe}"
end
