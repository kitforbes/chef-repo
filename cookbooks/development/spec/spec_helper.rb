require 'chefspec'
require 'chefspec/berkshelf'

# at_exit { ChefSpec::Coverage.report! }

RSpec.shared_context 'chef_run' do
  let(:chef_run) do
    ChefSpec::ServerRunner.new(attributes) do |node, server|
      server.create_environment(environment, default_attributes: environment_attributes)
      node.chef_environment = environment
      server.create_role(role, default_attributes: role_attributes)

      server.update_node(node)
    end.converge(described_recipe)
  end

  let(:attributes) do
    {
      platform: 'windows',
      version: '2012R2',
    }
  end
  let(:role) { '' }
  let(:role_attributes) { {} }
  let(:environment) { '_default' }
  let(:environment_attributes) { {} }
end
