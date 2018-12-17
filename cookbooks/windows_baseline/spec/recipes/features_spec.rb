describe 'windows_baseline::features' do
  include_context 'chef_run'

  context 'When all attributes are default' do
    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end
