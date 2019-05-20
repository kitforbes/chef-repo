describe 'development::default' do
  include_context 'chef_run'

  before do
    # Stubs for "development::vs_code"
    [
      'bbenoist.vagrant',
      'burtlo.inspec',
      'codezombiech.gitignore',
      'DotJoshJohnson.xml',
      'EditorConfig.EditorConfig',
      'hashhar.gitattributes',
      'jirkafajfr.vscode-kitchen',
      'mauve.terraform',
      'ms-python.python',
      'ms-vscode.cpptools',
      'ms-vscode.csharp',
      'ms-vscode.PowerShell',
      'Pendrica.chef',
      'PeterJausovec.vscode-docker',
      'vscoss.vscode-ansible',
      'waderyan.gitblame',
      'wholroyd.jinja',
    ].each do |extension|
      stub_command "[Boolean]((code --list-extensions) -like '#{extension}')"
    end

    # Stubs for "windows_baseline"
    stub_command('(Get-SmbServerConfiguration).EnableSMB1Protocol -eq $false')
    stub_command('(Get-PSRepository -Name PSGallery -ErrorAction SilentlyContinue) -eq $null')
    stub_command('(Get-PackageProvider -Name NuGet -ListAvailable | Where-Object -Property Version -eq 2.8.5.208) -eq $null')
    [
      { name: 'PowerShellGet', version: '1.0.0.1' },
      { name: 'PackageManagement', version: '1.0.0.1' },
      { name: 'Pester', version: '3.4.0' },
    ].each do |m|
      stub_command("(Get-Module -Name #{m[:name]} -ListAvailable | Where-Object -Property Version -eq #{m[:version]}) -eq $null")
      stub_command("(Get-Module -Name #{m[:name]} -ListAvailable).Count -eq 1")
    end
  end

  context 'When all attributes are default' do
    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end
