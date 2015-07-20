#
# Cookbook Name:: myiis-cookbook
# Recipe:: app_msdeploy_import
#
# Copyright 2015, Great Websites Inc
#

Chef::Log.warn '*** Hello from the myiis-cookbook::app_msdeploy_import recipe!'

include_recipe 'msdeploy::install'

# Use the 'msdeploy_sync' resource to checkout from the provided repository
# Equivalent powershell command:
# msdeploy -verb:sync -source:package="c:\all_sites.zip" -dest:auto
msdeploy_sync "Import msdeply package" do
  source ({ package: node['myiis-cookbook']['msdeploy']['zip'] })
  dest ({ auto: nil })
  action :run
  notifies :run, "ruby_block[retrieve_version]", :immediately
end

# Add app version to node data. Unknown for now
node.set['myiis-cookbook']['app-ver'] = 'unknown'

# Use the 'ruby_block' resource to get the app version from VERSION.txt and add it to the node data
# Only executed when notified by the previous 'msdeploy_sync' resource
ruby_block 'retrieve_version' do
  block do
    version = File.open("#{node['myiis-cookbook']['doc-root']}/VERSION.txt").readline.chomp
    node.set['myiis-cookbook']['app-ver'] = version
  end
  only_if { File.exist?("#{node['myiis-cookbook']['doc-root']}/VERSION.txt") }
  action :nothing
end
