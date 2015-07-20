#
# Cookbook Name:: myiis-cookbook
# Recipe:: app_checkout
#
# Copyright 2015, Great Websites Inc
#

Chef::Log.warn '*** Hello from the myiis-cookbook::app_checkout recipe!'

# Run the 'defaut' recipe of the 'git' cookbook
include_recipe 'git::default'

# Use the 'git' resource to checkout from the provided repository
git node['myiis-cookbook']['doc-root'] do
  repository node['myiis-cookbook']['git-repo']
  revision node['myiis-cookbook']['git-revision']
  action :sync
  notifies :run, "ruby_block[retrieve_version]", :immediately
end

# Add app version to node data. Unknown for now
node.set['myiis-cookbook']['app-ver'] = 'unknown'

# Use the 'ruby_block' resource to get the app version from VERSION.txt and add it to the node data
# Only executed when notified by the previous git resource
ruby_block 'retrieve_version' do
  block do
    version = File.open("#{node['myiis-cookbook']['doc-root']}/VERSION.txt").readline.chomp
    node.set['myiis-cookbook']['app-ver'] = version
  end
  only_if { File.exist?("#{node['myiis-cookbook']['doc-root']}/VERSION.txt") }
  action :nothing
end


