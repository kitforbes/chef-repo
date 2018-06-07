# Reference: dism /online /Get-Features

%w(
  Telnet-Client
  Telnet-Server
  SMB1Protocol
  Xps-Foundation-Xps-Viewer
).each do |feature|
  windows_feature feature do
    install_method :windows_feature_dism
    action :remove
  end
end
