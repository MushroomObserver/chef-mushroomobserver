#
# Cookbook Name:: mushroomobserver
# Recipe:: db
#
# Copyright 2013, Nathan Wilson
# License: MIT
#

# Installs MySQL server
# Initializes DB
#   How and when does the inital DB get created?  Seems like another recipe that results in an update to something that goes into
#   chef-mushroomobserver/files.  Should there be a directory for each recipe under files?  Is there typically an attributes file for
#   every recipe?

include_recipe 'build-essential' # Why is this needed here?
include_recipe 'mysql::client'
include_recipe 'mysql::server'
include_recipe 'database'
gem_package 'mysql'

# create the databases if they don't exist
database_name = "mo_#{node['chef-mushroomobserver']['rails_environment']}"

mysql_database database_name do
  connection ({:username => "root", :password => node['mysql']['server_root_password']})
  action :create
end

grants_string = Array.new

# Create mo user
# Create tables

# create/fetch the DB credentials.
# For EOL these are stored in encrypted databags in for production, or generated on the fly in other (dev,testing,staging) environment.
# Is there any reason not to generate the production one on the fly as well?  Maybe other users wouldn't be able to look up the password then?

node.set_unless['chef-mushroomobserver']['mo_db_pass'] = secure_password # secure_password is a helper method
grants_string << "GRANT ALL ON #{database_name}.* TO 'mo'@'%' IDENTIFIED BY '#{node['chef-mushroomobserver']['mo_db_pass']}';"

# Do the grants need to written to a file?
# mo_grants_path = "#{node['mysql']['conf_dir']}/mysql_mo_grants.sql"

# begin
#   t = resources("template[#{mo_grants_path}]")
# rescue
#   Chef::Log.info("Could not find previously defined mysql_mo_grants.sql resource")
#   t = template mo_grants_path do # What should the template look like?
#     source "mo_grants.sql.erb"
#     owner "root"
#     group "root"
#     mode "0600"
#     action :create
#     variables :grants => grants_string.join
#   end
# end

execute "mysql-install-privileges" do # How does this work?  Is this essentially just a label for doing something?
  # command "/usr/bin/mysql -u root #{node['mysql']['server_root_password'].empty? ? '' : '-p' }#{node['mysql']['server_root_password']} < #{mo_grants_path}"
  command "/usr/bin/mysql -u root #{node['mysql']['server_root_password'].empty? ? '' : '-p' }#{node['mysql']['server_root_password']} -e \"#{grants_string.join}\""
  action :nothing
  # subscribes :run, resources("template[#{eol_grants_path}]"), :immediately # What does this do?
end
