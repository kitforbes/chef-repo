resource_name :chocolatey_feature

property :feature_key, String, name_property: true
property :enabled, [TrueClass, FalseClass], required: false

load_current_value do
  require 'rexml/document'
  current_val = fetch_config_element(feature_key)
  current_value_does_not_exist! if current_val.nil?

  feature_key feature_key
  enabled current_val
end

# @param [Object] obj an object to interogate
# @return [TrueClass, FalseClass] the element's enabled state
def true?(obj)
  obj.to_s.downcase == 'true'
end

# @param [String] id the config name
# @return [String] the element's enabled field
def fetch_config_element(id)
  config_file = 'C:\ProgramData\chocolatey\config\chocolatey.config'
  raise "Could not find the Chocolatey feature at #{config_file}!" unless ::File.exist?(config_file)

  contents = REXML::Document.new(::File.read(config_file))
  data = REXML::XPath.first(contents, "//features/feature[@name=\"#{id}\"]")
  data ? true?(data.attribute('enabled')) : nil # REXML just returns nil if it can't find anything so avoid an undefined method error
end

action :enable do
  new_resource.enabled = true
  converge_if_changed do
    shell_out!(choco_cmd('enable'))
  end
end

action :disable do
  new_resource.enabled = false
  converge_if_changed do
    shell_out!(choco_cmd('disable'))
  end
end

action_class do
  # @param [String] action the name of the action to perform
  # @return [String] the choco config command string
  def choco_cmd(action)
    cmd = "C:\\ProgramData\\chocolatey\\bin\\choco feature #{action} --name #{new_resource.feature_key}"
    cmd
  end
end
