# frozen_string_literal: true
source 'https://supermarket.chef.io'

# Source cookbooks within the Chef repo's "cookbooks" directory.
cookbook_dir = File.join(File.dirname(__FILE__), 'cookbooks')
Dir.entries(cookbook_dir).select { |entry| File.directory? File.join(cookbook_dir, entry) and !(entry =='.' || entry == '..') }.each do |name|
  cookbook name, path: "cookbooks/#{name}"
end
