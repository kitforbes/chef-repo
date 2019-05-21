return unless node['platform_family'] == 'windows'

vscode_directory = "#{ENV['HOME']}\\AppData\\Roaming\\Code"

chocolatey_package 'visualstudiocode' do
  options '--params "/NoDesktopIcon"'
  action :install
end

windows_path 'C:\\Program Files\\Microsoft VS Code\\bin' do
  action :add
end

cookbook_file "#{vscode_directory}\\User\\settings.json" do
  source 'settings.json'
  action :create
end

node['vscode']['extensions'].each do |extension|
  powershell_script "install-#{extension}" do
    code "code --install-extension #{extension}"
    action :run
    guard_interpreter :powershell_script
    not_if "[Boolean]((code --list-extensions) -like '#{extension}')"
  end
end
