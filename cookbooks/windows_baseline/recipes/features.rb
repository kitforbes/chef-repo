return unless node['platform_family'] == 'windows'

powershell_script 'Disable SMB1Protocol' do
  code 'Set-SMBServerConfiguration -EnableSMB1Protocol $False -Confirm:$False'
  action :run
  guard_interpreter :powershell_script
  not_if '(Get-SmbServerConfiguration).EnableSMB1Protocol -eq $false'
end

# Reference: dism /online /Get-Features
%w(
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
