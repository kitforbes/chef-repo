# Inspec test for recipe windows_baseline::features

describe powershell('(Get-SmbServerConfiguration).EnableSMB1Protocol') do
  its('strip') { should match 'False' }
end

%w(
  Internet-Explorer-Optional-amd64
  SMB1Protocol
  Telnet-Client
  Telnet-Server
  Xps-Foundation-Xps-Viewer
).each do |f|
  describe windows_feature(f) do
    it { should_not be_installed }
  end
end
