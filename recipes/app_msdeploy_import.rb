#
# Cookbook Name:: myiis-cookbook
# Recipe:: app_msdeploy_import
#
# Copyright 2015, Great Websites Inc
#

log "*** Hello from the myiis-cookbook::app_msdeploy_import recipe!"

include_recipe 'msdeploy::install'

# Add app version to node data. Unknown for now
node.set['myiis-cookbook']['app-ver'] = 'unknown'

# Use the 'msdeploy_sync' resource to checkout from the provided repository
msdeploy_sync "" do
  source node['myiis-cookbook']['msdeploy']['zip']
  destination 'auto'
  action :sync
end

powershell_script 'dir git folder' do
  code '
    dir c:\inetpub\wwwroot
  '
  action :run
end

# Get the app version from VERSION.txt and add it to the node data
ruby_block 'Retrieve app version' do
  block do
    version = File.open("#{node['myiis-cookbook']['doc-root']}/VERSION.txt").readline.chomp
    node.set['myiis-cookbook']['app-ver'] = version
  end
  only_if { File.exist?("#{node['myiis-cookbook']['doc-root']}/VERSION.txt") }
end


