return unless platform_family?('windows')

vscode_install_directory = 'C:\\Program Files\\Microsoft VS Code'
safe_vscode_install_directory = vscode_install_directory.gsub! ' ', '` '
vscode_data_directory = "#{ENV['HOME']}\\AppData\\Roaming\\Code"

chocolatey_package 'vscode' do
  options '--params "/NoDesktopIcon"'
  action :install
end

windows_path "#{vscode_install_directory}\\bin" do
  action :add
end

cookbook_file "#{vscode_data_directory}\\User\\settings.json" do
  source 'settings.json'
  action :create
end

node['vscode']['extensions'].each do |extension|
  powershell_script "install-#{extension}" do
    code "#{safe_vscode_install_directory}\\bin\\code.cmd --install-extension #{extension}"
    action :run
    not_if "[Boolean]((#{safe_vscode_install_directory}\\bin\\code.cmd --list-extensions) -like '#{extension}')"
  end
end
