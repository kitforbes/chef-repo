# frozen_string_literal: true

# Cookbook:: example
# Recipe:: default

log "Welcome to Chef, #{node['example']['name']}!" do
  level :info
end

# For more information, see the documentation: https://docs.chef.io/recipes.html
