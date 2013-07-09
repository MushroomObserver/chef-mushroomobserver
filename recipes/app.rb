#
# Cookbook Name:: mushroomobserver
# Recipe:: app
#
# Copyright 2013, Nathan Wilson
# License: MIT
#

# The chef-mushroomobserver::db recipe is expected to have already run and set node['chef-mushroomobserver']['mo_db_pass'].
# However, an include_recipe isn't appropriate since we don't know which of 'test', 'development' or 'production' are wanted.
node['chef-mushroomobserver']['mo_db_pass'] # Will this fail if it hasn't been set?

include_recipe 'build-essential' # Need this to be able to build MO tools (or should it just come from db.rb?)

# Installs appropriate Ruby and gems (rails 2.1.1, mysql, mysql2 0.2.18, test-unit, RedCloth, sparql)

include_recipe 'rvm' # Prolly want the other RVM, but need to figure that out...
include_recipe 'rvm::ruby_193'

gem_package 'rails:2.1.1' # How do you specify version number?
gem_package 'mysql'
gem_package 'mysql2:0.2.18' # How do you specify version number?
gem_package 'test-unit'
gem_package 'RedCloth'
gem_package 'sparql'


# Installs imagemagick and rmagick gem
# include_recipe 'imagemagick' # Wonder if there is one or do I just use apt in some way?
# gem_package 'rmagick' # Or would this be part of the above?

# Create 'mo' user?  Appropriate for production.  Not sure about dev/Vagrant.

# Installs MO code base from https://github.com/MushroomObserver/mushroom-observer.git as mo (vagrant?) user
# git https://github.com/MushroomObserver/mushroom-observer.git --git-dir node['chef-mushroomobserver']['repo_path']

# Create database YML file
mo_yml_path = "#{node['chef-mushroomobserver']['repo_path']}/mushroom-observer/config/database.yml"

begin
  t = resources("template[#{mo_yml_path}]")
rescue
  Chef::Log.info("Could not find previously defined database.yml resource")
  t = template mo_yml_path do # What should the template look like?
    source "mo_yml.sql.erb"
    owner "mo" # Does this create this user or do we need to do that before this gets run?
    group "mo"
    mode "0600"
    action :create
    variables :password => node['chef-mushroomobserver']['mo_db_pass']
  end
end


# Build and install MO tools
# if [ -f /usr/local/sbin/jpegresize ];
#   then
#     gcc script/jpegresize.c -ljpeg -lm -O2 -o /usr/local/sbin/jpegresize
# fi
# if [ -f /usr/local/sbin/jpegexiforient ];
#   then
#     gcc script/jpegexiforient.c -o /usr/local/sbin/jpegexiforient
# fi
# if [ -f /usr/local/sbin/exifautotran ];
#   then
#     cp script/exifautotran.sh /usr/local/sbin/exifautotran; chmod 755 /usr/local/sbin/exifautotran
# fi
