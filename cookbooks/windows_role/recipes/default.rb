# frozen_string_literal: true

# Cookbook:: windows_role
# Recipe:: default

%w(
  Telnet-Client
  Telnet-Server
).each do |feature|
  windows_feature feature do
    action :remove
    install_method :windows_feature_powershell
  end
end
