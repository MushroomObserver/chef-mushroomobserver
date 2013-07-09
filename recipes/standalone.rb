#
# Cookbook Name:: mushroomobserver
# Recipe:: standalone
#
# Copyright 2013, Nathan Wilson
# License: MIT
#

# Uses db and app
# Loads example db
# [Where should the stuff for making the source code available between Vagrant and host go?  Vagrantfile?]

# Is this a good/reasonable way to run this for 'test' and for 'development'?
node['chef-mushroomobserver']['rails_environment'] = 'test'
include_recipe 'chef-mushroomobserver::db'

node['chef-mushroomobserver']['rails_environment'] = 'development'
include_recipe 'chef-mushroomobserver::db'


include_recipe 'chef-mushroomobserver::app'

mo_init_path = files("init.sql")
execute "mysql-init" do
  command "/usr/bin/mysql -u mo #{node['chef-mushroomobserver']['mo_db_pass']} < #{mo_init_path}"
end

# rake db:migrate
# rake lang:update
