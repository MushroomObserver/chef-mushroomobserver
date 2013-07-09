#
# Cookbook Name:: mushroomobserver
# Recipe:: production
#
# Copyright 2013, Nathan Wilson
# License: MIT
#

node['chef-mushroomobserver']['rails_environment'] = 'production'
include_recipe 'chef-mushroomobserver::db'

include_recipe 'chef-mushroomobserver::app'

# Configure Unicorn and nginx (do these need to get listed in metadata.rb?)
include_recipe 'unicorn'
include_recipe 'nginx'

# Configure firewall rules (using iptables right?)
include_recipe 'iptables'

include_recipe 'dump_production'

mo_prod_path = files("prod.sql")
execute "mysql-prod" do
  command "/usr/bin/mysql -u mo #{node['chef-mushroomobserver']['mo_db_pass']} < #{mo_prod_path}"
end

# rake db:migrate
# rake lang:update

# Configs to update image servers using ssh (security?)

# Sets up production cron jobs
