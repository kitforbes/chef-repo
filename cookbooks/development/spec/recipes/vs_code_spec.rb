describe 'development::vs_code' do
  include_context 'chef_run'

  before do
    # TODO: Figure out how to mock attributes to avoid this horrible thing.
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
      stub_command "[Boolean]((C:\\Program` Files\\Microsoft` VS` Code\\bin\\code.cmd --list-extensions) -like '#{extension}')"
    end
  end

  context 'When all attributes are default' do
    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end
