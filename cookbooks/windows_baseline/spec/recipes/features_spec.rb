describe 'windows_baseline::features' do
  include_context 'chef_run'

  before do
    stub_command('(Get-SmbServerConfiguration).EnableSMB1Protocol -eq $false')
  end

  context 'When all attributes are default' do
    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end
