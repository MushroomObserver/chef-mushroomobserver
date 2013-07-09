#
# Cookbook Name:: mushroomobserver
# Recipe:: dump_production
#
# Copyright 2013, Nathan Wilson
# License: MIT
#

# Does what is currently done by the MO dump script:
#   Connects to real production system to create dump
#   Transfers dump using scp to prod.sql

# Does this suggest that update_backup should become a Chef recipe?
