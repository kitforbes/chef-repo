return unless platform_family?('windows')

powershell_script 'Disable SMB1Protocol' do
  code 'Set-SMBServerConfiguration -EnableSMB1Protocol $False -Confirm:$False'
  action :run
  not_if '(Get-SmbServerConfiguration).EnableSMB1Protocol -eq $false'
end

# Reference: dism /online /Get-Features
%w(
  Internet-Explorer-Optional-amd64
  SMB1Protocol
  Telnet-Client
  Telnet-Server
  Xps-Foundation-Xps-Viewer
).each do |feature|
  windows_feature feature do
    install_method :windows_feature_dism
    action :remove
  end
end
