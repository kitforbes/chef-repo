return unless platform_family?('windows')

chocolatey_package 'nugetpackageexplorer' do
  action :install
end
