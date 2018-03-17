# encoding: utf-8

# Inspec test for recipe my_windows::default

describe windows_feature('Telnet-Server') do
  it { should_not be_installed }
end

describe windows_feature('Telnet-Client') do
  it { should_not be_installed }
end
