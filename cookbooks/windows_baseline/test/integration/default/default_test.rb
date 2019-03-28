# Inspec test for recipe windows_baseline::default

describe windows_feature('Telnet-Server') do
  it { should_not be_installed }
end

describe windows_feature('Telnet-Client') do
  it { should_not be_installed }
end

describe command('(Get-Module -Name RemoteDesktop -ListAvailable).Name') do
  its('stdout') { should match 'RemoteDesktop' }
end
