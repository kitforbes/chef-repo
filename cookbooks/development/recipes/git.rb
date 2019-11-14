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

template "#{ENV['HOME']}\\.ssh\\config" do
  source 'config.erb'
  variables(
    hosts: [
      {
        host: 'github.com',
        user: 'git',
        identityFile: '~/.ssh/github',
      },
      {
        host: 'gitlab.com',
        user: 'git',
        identityFile: '~/.ssh/id_rsa',
      },
      {
        host: 'bitbucket.org',
        user: 'git',
        identityFile: '~/.ssh/id_rsa',
      },
    ]
  )
  action :create
end

# TODO: Add to known hosts first.
node['git']['github_repositories'].each do |repository|
  git "github:#{node['git']['username']}/#{repository}" do
    checkout_branch 'master'
    revision 'master'
    destination "C:\\dev\\#{node['git']['username']}\\#{repository}"
    repository "git@github.com:#{node['git']['username']}/#{repository}.git"
    timeout node['git']['timeout']
    enable_checkout false
    enable_submodules true
    action :checkout
  end
end

node['git']['gitlab_repositories'].each do |repository|
  git "gitlab:#{node['git']['username']}/#{repository}" do
    checkout_branch 'master'
    revision 'master'
    destination "C:\\dev\\#{node['git']['username']}\\#{repository}"
    repository "git@gitlab.com:#{node['git']['username']}/#{repository}.git"
    timeout node['git']['timeout']
    enable_checkout false
    enable_submodules true
    action :checkout
  end
end

chocolatey_package 'gitkraken' do
  action :install
end
