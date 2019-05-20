current_dir = File.dirname(__FILE__)
if Dir.exists?("#{current_dir}/../vendor/cookbooks")
  cookbook_path ["#{current_dir}/../vendor/cookbooks"]
else
  cookbook_path ["#{current_dir}/../cookbooks"]
end

cookbook_copyright 'Chris Forbes'
cookbook_email     'chef@chrisforbes.dev'
cookbook_license   'mit'
