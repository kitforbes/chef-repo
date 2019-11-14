return unless platform_family?('windows')

[
  'C:\dev',
  "C:\\dev\\#{node['git']['username']}",
  "#{ENV['HOME']}\\.ssh",
].each do |dir|
  directory dir do
    action :create
  end
end

chocolatey_package 'git' do
  options '--params "/GitAndUnixToolsOnPath /NoAutoCrlf /WindowsTerminal /NoShellIntegration /NoCredentialManager /NoGitLfs /SChannel"'
  action :install
end

template "#{ENV['HOME']}\\.gitconfig" do
  source '.gitconfig.erb'
  variables(
    email: node['git']['config']['email'],
    name: node['git']['config']['name']
  )
  action :create
end

file "#{ENV['HOME']}\\.ssh\\known_hosts" do
  action :create
end

hosts = []
node['git']['servers'].each do |server|
  hosts.push(
    host: server['host'],
    identityFile: server['identityFile']
  )
end

template "#{ENV['HOME']}\\.ssh\\config" do
  source 'config.erb'
  variables(
    hosts: hosts
  )
  action :create
end

# TODO: Add to known hosts first.
node['git']['servers'].each do |server|
  server['repositories'].each do |repository|
    git "#{server['host']}:#{server['organisation']}/#{repository}" do
      checkout_branch 'master'
      revision 'master'
      destination "C:\\dev\\#{server['organisation']}\\#{repository}"
      repository "git@#{server['host']}:#{server['organisation']}/#{repository}.git"
      timeout node['git']['timeout']
      enable_checkout false
      enable_submodules true
      action :checkout
    end
  end
end

chocolatey_package 'gitkraken' do
  action :install
end
