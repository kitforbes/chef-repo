chocolatey_package 'firefox' do
  options '--params "l=en-GB"'
  action :install
end

service 'MozillaMaintenance' do
  action %i( stop disable )
end
